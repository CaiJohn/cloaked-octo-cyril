(* Implements peephole optimization*)
(* 1. Strength reduction           *)
(* 2. Contant folding              *)

open Ir3_structs
open Jlite_structs


let peephole_mth mtd =
    let process_stmt stmt
    : (ir3_stmt list)=
    match stmt with
    (*constant folding*)
    | AssignStmt3 (v, BinaryExp3 (AritmeticOp op, IntLiteral3 id1, IntLiteral3 id2)) ->
        if op = "+" then [(AssignStmt3 (v, (Idc3Expr (IntLiteral3 (id1+id2)))))]
        else if op = "-" then [(AssignStmt3 (v, (Idc3Expr (IntLiteral3 (id1-id2)))))]
        else if op = "*" then [(AssignStmt3 (v, (Idc3Expr (IntLiteral3 (id1*id2)))))]
        else failwith "Error - '/' is not expected in binary expression"
    | AssignStmt3 (v, BinaryExp3 (RelationalOp op, IntLiteral3 id1, IntLiteral3 id2)) ->
        let helper = 
            if op = "==" then BoolLiteral3 (id1 = id2)
            else if op = "!=" then BoolLiteral3 (id1 <> id2) 
            else if op = ">=" then BoolLiteral3 (id1 >= id2) 
            else if op = "<=" then BoolLiteral3 (id1 <= id2) 
            else if op = ">" then BoolLiteral3 (id1 > id2)
            (*if op = "<"*)
            else BoolLiteral3 (id1 < id2) 
        in [AssignStmt3 (v, Idc3Expr helper)]
    | AssignStmt3 (v, BinaryExp3 (BooleanOp op, BoolLiteral3 id1, BoolLiteral3 id2)) ->
        if op = "&&" then [AssignStmt3 (v, Idc3Expr (BoolLiteral3 (id1 && id2)))]
        else [AssignStmt3 (v, Idc3Expr (BoolLiteral3 (id1 || id2)))]
    | AssignStmt3 (v, UnaryExp3(UnaryOp op, BoolLiteral3 id)) ->
        if op = "!" then [(AssignStmt3 (v, Idc3Expr (BoolLiteral3 (not id))))]
        else [stmt]
    (*strength reduction*)
    | AssignStmt3 (v, BinaryExp3 (AritmeticOp op, IntLiteral3 id1, Var3 id2))
    | AssignStmt3 (v, BinaryExp3 (AritmeticOp op, Var3 id2, IntLiteral3 id1)) ->
        (*ARM has an efficient multiplier so single multiplication 
         *could be faster than multiple addition                    *)
        if op = "*"  && id1 < 5 then
        (*binary addition*)
        let rec generate_addition var count =
            if count = 0 then [(AssignStmt3 (var, Idc3Expr (IntLiteral3 0)))]
            else if count = 1 then [AssignStmt3(var, Idc3Expr (Var3 id2))]
            else if count = 2 then [AssignStmt3(var, BinaryExp3 (AritmeticOp "+", Var3 id2, Var3 id2))]
            else if count mod 2 = 1 then (generate_addition var ((count-1)/2))@[AssignStmt3 (var, BinaryExp3 (AritmeticOp "+", Var3 var, Var3 var));AssignStmt3 (var, BinaryExp3 (AritmeticOp "+", Var3 var, Var3 id2))]
            else (generate_addition var (count/2))@[AssignStmt3 (var, BinaryExp3 (AritmeticOp "+", Var3 var, Var3 var))]
        in  if v = id2 then 
                let new_id = "__PH"^id2 in
                if id1 = 0 then [(AssignStmt3 (v, Idc3Expr (IntLiteral3 0)))]
                else if id1 = 1 then []
                else if id1 = 2 then [AssignStmt3(v, BinaryExp3 (AritmeticOp "+", Var3 id2, Var3 id2))]
                else if id1 mod 2 = 1 then (generate_addition new_id (id1-1))@[AssignStmt3 (v, BinaryExp3 (AritmeticOp "+", Var3 new_id, Var3 v))]
                else (generate_addition new_id (id1/2))@[AssignStmt3 (v, BinaryExp3 (AritmeticOp "+", Var3 new_id, Var3 new_id))]
        else generate_addition v id1
        else [stmt]
    | _ -> [stmt]
    in let rec process_stmts lst =
      match lst with
      | [] -> []
      | h::t -> (process_stmt h)@(process_stmts t)
    in let new_stmts = process_stmts mtd.ir3stmts in
    {
      id3=mtd.id3;
      rettype3=mtd.rettype3;
      params3=mtd.params3;
      localvars3=mtd.localvars3;
      ir3stmts=new_stmts
    }

let peephole_optimize program =
  let (cdata_list, ir3Main, ir3Mthd_list) = program in
  let mainDecl = peephole_mth ir3Main in
  let mtdDecls = List.map peephole_mth ir3Mthd_list in
  (cdata_list, mainDecl, mtdDecls)

