open Ir3_structs
open Jlite_structs

 (* Convert to ir3 structures to ir3 new structures,
   the 1st pass is to combine consecutive label into one label
   but not linked with goto stmt yet
*)
let ir3_program_combine_labels (cdata_list, ir3Main, ir3Mtd_list) =
  (* old_label_id -> new_label_id 
     used only in linking goto stmt with new label stmt
  *)
  let lbl_htbl = Hashtbl.create 20 in 
  (* Generate a increasing unique int *)
  let lblVar = ref (-1) in
  let lblVarGen () = 
    lblVar := !lblVar + 1;
    !lblVar in
  (* process ir3_stmts in a 1st pass with 
     consecutive label stmt combined into one 
  *)
  let process_ir3_stmts_1st ir3_stmts =
    let rec process_stmts (preIsLbl,stmts) : int*(ir3_stmt list) = 
      match stmts with
      | [] -> 
        if (preIsLbl==true) 
        then let newLblId = lblVarGen () in (newLblId, (Label3 newLblId)::[])
        else (-1,[])
      | stmt::rest -> 
        match stmt with
        | Label3 lbl_id -> 
          let (new_lbl_id,new_rest) = process_stmts (true,rest) in
          Hashtbl.add lbl_htbl lbl_id new_lbl_id; (* for later lookup *)
          (new_lbl_id,new_rest)
        | _ ->
          if (preIsLbl==true) (* if previous stmt is a label stmt *) 
          then let newLblId = lblVarGen () in
            let (_,new_rest) = process_stmts (false,rest) in
            (newLblId, (Label3 newLblId)::stmt::new_rest)
          else let (_,new_rest) = process_stmts (false,rest) in
            (-1, stmt::new_rest) 
    in let (_,new_ir3_stmts) = process_stmts (false,ir3_stmts) in new_ir3_stmts in
  (* Process the ir3_stmts at 2nd pass with 
     goto stmt updated with new label stmt
  *)
  let rec process_ir3_stmts_2nd stmts =
    match stmts with
    | [] -> []
    | ir3_stmt::rest ->
      match ir3_stmt with
      | IfStmt3 (exp,gotoId) -> 
        let newId = Hashtbl.find lbl_htbl gotoId in
        (IfStmt3 (exp,newId))::(process_ir3_stmts_2nd rest) 
      | GoTo3 gotoId -> 
        let newId = Hashtbl.find lbl_htbl gotoId in
        (GoTo3 newId)::(process_ir3_stmts_2nd rest) 
      | _ -> ir3_stmt::(process_ir3_stmts_2nd rest) in 
  (* convert process the stmts in each function *)
  let process_ir3_mtd ir3Mtd =
    { 
      id3=ir3Mtd.id3;
      rettype3=ir3Mtd.rettype3;
      params3=ir3Mtd.params3;
      localvars3=ir3Mtd.localvars3;
      ir3stmts=process_ir3_stmts_2nd (process_ir3_stmts_1st ir3Mtd.ir3stmts);
    } in 
  let mainDecl = process_ir3_mtd ir3Main in
  let mtdDecls = List.map process_ir3_mtd ir3Mtd_list in
  (cdata_list, mainDecl, mtdDecls)  

(* It will make multiply's second operands to be var
   let IfStmt3's cond exp to be Idc3Expr
   let AssignFieldStmt3's right exp to be Idc3Expr 
*)
let ir3_program_simplify_exp (cdata_list, ir3Main, ir3Mthd_list) =
  let varId = ref 0 in
  let varIdGen () = varId := !varId-1; !varId in
  let get_ops op =
    match op with
    | BooleanOp s -> s
    | RelationalOp s -> s
    | AritmeticOp s -> s
    | UnaryOp s -> s 
  in
  let replace_operand var : idc3*var_decl3 list*ir3_stmt list = 
    match var with 
    | IntLiteral3 i ->
      let new_var_id = "_t"^string_of_int (varIdGen ()) in
      let new_var_decl = (Unknown,new_var_id) in
      let new_assign_stmt = AssignStmt3 (new_var_id,Idc3Expr (IntLiteral3 i)) in
      (Var3 new_var_id,[new_var_decl],[new_assign_stmt])
    | BoolLiteral3 b ->
      let new_var_id = "_t"^string_of_int (varIdGen ()) in
      let new_var_decl = (Unknown, new_var_id) in
      let new_assign_stmt = AssignStmt3 (new_var_id,Idc3Expr (BoolLiteral3 b)) in
      (Var3 new_var_id,[new_var_decl],[new_assign_stmt])
    | _ -> (var,[],[]) 
  in
  let replace_operand_big_int var : idc3*var_decl3 list*ir3_stmt list =
    match var with
    | IntLiteral3 i -> 
      if i<=1020 then (var,[],[]) 
      else let new_var_id = "_t"^string_of_int (varIdGen ()) in
           let new_var_decl = (IntT,new_var_id) in
           let new_assign_stmt = AssignStmt3 (new_var_id,Idc3Expr (IntLiteral3 i)) in
           (Var3 new_var_id,[new_var_decl],[new_assign_stmt])      
    | _ -> (var,[],[])
  in
  let new_copy_assign_operand var : idc3*var_decl3 list*ir3_stmt list = 
    match var with
    | Var3 var_id ->
      let new_var_id = "_t"^string_of_int (varIdGen ()) in
      let new_var_decl = (Unknown, new_var_id) in
      let new_assign_stmt = AssignStmt3 (new_var_id,Idc3Expr var) in
      (Var3 new_var_id,[new_var_decl],[new_assign_stmt]) 
    | _ -> failwith "Error - this cannot happen, var can only be Var3"
  in
  (* filter literal operands for binary operations *)
  let reconst_exp exp : ir3_exp*var_decl3 list*ir3_stmt list = 
    match exp with
    | UnaryExp3 (op,var) ->
      let (new_var,new_vars,new_stmts) = replace_operand var in
      let new_exp = UnaryExp3 (op,new_var) in
      (new_exp,new_vars,new_stmts)
    | BinaryExp3 (op,lvar,rvar) ->
      let ops = get_ops op in
      let (lnew_var,lnew_var_decls,lnew_assign_stmts) = replace_operand lvar in 
      if ops="*" then
        let (rnew_var, rnew_var_decls,rnew_assign_stmts) = replace_operand rvar in
        let (rnew_var,rnew_var_decls,rnew_assign_stmts) = 
          if rnew_var=lnew_var (* Just make sure rd and rm not same for mul *) then
          new_copy_assign_operand rnew_var 
          else (rnew_var, rnew_var_decls,rnew_assign_stmts) in  
        let new_exp = BinaryExp3 (op,lnew_var,rnew_var) in
        (new_exp,lnew_var_decls@rnew_var_decls,lnew_assign_stmts@rnew_assign_stmts)
      else 
        let (rnew_var, rnew_var_decls,rnew_assign_stmts) = replace_operand_big_int rvar in
        let new_exp = BinaryExp3 (op,lnew_var,rnew_var) in
        (new_exp,lnew_var_decls@rnew_var_decls,lnew_assign_stmts@rnew_assign_stmts)
    | MdCall3 (md_name,params) ->
      let rec filter_params plst : idc3 list*var_decl3 list*ir3_stmt list = 
        match plst with
        | [] -> ([],[],[])
        | param::rest ->
          let (idcs,vars,stmts) = filter_params rest in 
          let (new_var,new_vars,new_stmts) = replace_operand_big_int param in
          (new_var::idcs,new_vars@vars,new_stmts@stmts) 
      in 
      let (new_params,new_vars,new_stmts) = filter_params params in
      let new_md_call_exp = MdCall3 (md_name,new_params) in
      (new_md_call_exp,new_vars,new_stmts) 
    | _ -> (exp,[],[])
  in
  let reconst_stmt stmt : var_decl3 list*ir3_stmt list =
    match stmt with
    | AssignStmt3 (lvar,rexp) ->
      let (new_rexp,var_lst,stmt_lst) = reconst_exp rexp in
      if (List.length var_lst)==0 then ([],[stmt])
      else let new_assign_stmt = AssignStmt3 (lvar,new_rexp) in
           (var_lst,stmt_lst@[new_assign_stmt])
    | AssignFieldStmt3 (lexp,rexp) ->
      begin
        match rexp with
        | Idc3Expr idc3_val ->
          begin
            match idc3_val with
            | Var3 _ -> ([],[stmt])
            | _ -> 
              let new_vid = "_t"^string_of_int (varIdGen ()) in
              let new_var_decl = (Unknown,new_vid) in
              let new_assign_stmt = AssignStmt3 (new_vid,rexp) in
              let new_field_assign_stmt = AssignFieldStmt3 (lexp,Idc3Expr (Var3 new_vid)) in 
              ([new_var_decl],[new_assign_stmt;new_field_assign_stmt])
          end
        | _ -> 
          let (new_rexp,var_lst,stmt_lst) = reconst_exp rexp in 
          let new_vid = "_t"^string_of_int (varIdGen ()) in
          let new_var_decl = (Unknown,new_vid) in
          let new_assign_stmt = AssignStmt3 (new_vid,new_rexp) in
          let new_field_assign_stmt = AssignFieldStmt3 (lexp,Idc3Expr (Var3 new_vid)) in
          (var_lst@[new_var_decl],stmt_lst@[new_assign_stmt;new_field_assign_stmt]) 
      end 
 (*   | IfStmt3 (cond_exp,lbl) ->
      begin
        match cond_exp with
        | Idc3Expr _ -> ([],[stmt])
        | _ -> 
          let (new_exp,var_lst,stmt_lst) = reconst_exp cond_exp in
          let new_vid = "_t"^string_of_int (varIdGen ()) in
          let new_var_decl = (Unknown,new_vid) in
          let new_assign_stmt = AssignStmt3 (new_vid,new_exp) in
          let new_if_stmt = IfStmt3 (Idc3Expr (Var3 new_vid),lbl) in
          (var_lst@[new_var_decl],stmt_lst@[new_assign_stmt;new_if_stmt]) 
      end *)
    | MdCallStmt3 md_call_exp -> 
      let (new_exp,var_lst,stmt_lst) = reconst_exp md_call_exp in
      let new_md_call_stmt = MdCallStmt3 new_exp in
      (var_lst,stmt_lst@[new_md_call_stmt])
    | PrintStmt3 idc3_val -> 
      let (new_idc3,var_lst,stmt_lst) = replace_operand_big_int idc3_val in
      let new_print_stmt = PrintStmt3 new_idc3 in
      (var_lst,stmt_lst@[new_print_stmt]) 
    | _ -> ([],[stmt])
  in
  let process_mtd_decl mtd =
    let rec reconst_stmts stmts : var_decl3 list*ir3_stmt list  =
      match stmts with
      | [] -> ([],[])
      | stmt::rest ->
        let (rest_vars,rest_stmts) = reconst_stmts rest in
        let (curr_vars,curr_stmts) = reconst_stmt stmt in
        (curr_vars@rest_vars,curr_stmts@rest_stmts)
    in 
    let (new_vars,new_stmts) = reconst_stmts mtd.ir3stmts in
    {
      id3=mtd.id3;
      rettype3=mtd.rettype3;
      params3=mtd.params3;
      localvars3=mtd.localvars3 @ new_vars;
      ir3stmts=new_stmts
    }
  in
  let mainDecl = process_mtd_decl ir3Main in
  let mtdDecls = List.map process_mtd_decl ir3Mthd_list in
  (cdata_list, mainDecl, mtdDecls)

let ir3_program_filter program =
  let program1 = ir3_program_combine_labels program in
  let program2 = ir3_program_simplify_exp program1 in
  program2
