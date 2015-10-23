(* ===================================================== *)
(* ============== CS4212 Compiler Design =============== *)
(*             TypeChecking of MOOL Programs            *)
(*                 Huang Zhuo  A0048273A                 *)
(* ===================================================== *)

open MOOL_structs

(* class_name -> (cvar_id -> var_type) *)
let cvar_t_htbl = Hashtbl.create 10
(* class_name -> (cmtd_id -> func_type)
   Due to function overloading,
   one cmtd_id can have multiple func_types
 *)
let cmtd_t_htbl = Hashtbl.create 10

(* The method signaure type: (annotated_id,rettype,param_type list) *)
type func_type = var_id * mOOL_type * mOOL_type list

(* Get the type list of var_decl list *)
let get_tlist (vlist: var_decl list) : mOOL_type list =
  let helper (v_t,_) = v_t in
    (List.map helper vlist)

(* Type check if the given class name already defined *)
let check_cls_in_htbl cmtd_t_htbl cname = 
  if (Hashtbl.mem cmtd_t_htbl cname)
  then failwith ("\nTypeChecking error - duplicated class name: " 
                 ^ cname ^ "\n") 
  else ()

(* Type check if the given vid is already declared *)
let check_var_in_htbl var_sub_htbl cname vid =
  if (Hashtbl.mem var_sub_htbl vid) 
  then failwith ("\nTypeChecking error - class " ^ cname ^ "\n" 
                 ^ "class variable name duplicates: " 
                 ^ (string_of_var_id vid) ^ "\n") 
  else () 

let check_mtd_vars cname mtd = 
  let localvars = List.append mtd.params mtd.localvars in
  let occurence (_,c_id) = 
    if (List.length (List.find_all (fun (_,id) -> id = c_id) localvars) > 1)
    then failwith ("\nTypeChecking error - class " ^ cname ^ "\n" 
                   ^ " in method " ^ string_of_var_id mtd.mOOLid 
                   ^ " dulplicate local variable: " ^ string_of_var_id c_id ^ "\n") 
    else ()
  in ignore (List.map occurence localvars) 

let match_types (type1: mOOL_type) (type2: mOOL_type) : bool = 
  match type1,type2 with
  | Unknown,_ | _,Unknown -> false
  | ObjectT c1,ObjectT c2 -> 
    if (c1="null" || c2="null") then true
    else (c1=c2) 
  | _ -> (type1=type2) 

let match_type_list (lst1: mOOL_type list) (lst2: mOOL_type list) : bool =
  try
    let resultLst = List.map2 match_types lst1 lst2 in
    not (List.exists (fun x -> not x) resultLst)
  with Invalid_argument e -> false

(* Type check if methods with the same type signatures *)
let check_mtd_in_htbl mtd_sub_htbl cname mtd = 
  if (Hashtbl.mem mtd_sub_htbl mtd.mOOLid) then 
    let func_list = Hashtbl.find_all mtd_sub_htbl mtd.mOOLid in 
    let param_types = get_tlist mtd.params in
    let helper (_,_,p_param_types) = 
      if (param_types = p_param_types) 
      then failwith ("\nTypeChecking error - class " ^ cname ^ "\n"
                     ^ "function with same parameter types: "
                     ^ string_of_md_decl mtd ^ "\n")    
      else ()
    in ignore (List.map helper func_list)
  else ()

(* Create the hashtable for function types *)
let make_cmtd_t_htbl ((cmain,clist): mOOL_program) = 
    let add_cmain_into_htbl ((cname,mtd): class_main) = 
      check_mtd_vars cname mtd; 
      let mtd_sub_htbl = Hashtbl.create 10 in
      Hashtbl.add mtd_sub_htbl mtd.mOOLid 
        (SimpleVarId "main", mtd.rettype, get_tlist mtd.params);
      Hashtbl.add cmtd_t_htbl cname mtd_sub_htbl 
    in add_cmain_into_htbl cmain;
    let add_cls_into_htbl ((cname,_,mtd_list): class_decl) =
      check_cls_in_htbl cmtd_t_htbl cname; 
      let mtd_sub_htbl = Hashtbl.create 10 in 
      let rec itr_mtd_list (mlist: md_decl list) (idx:int) =
        match mlist with 
        | [] -> ()
        | mtd::tail ->
          check_mtd_vars cname mtd; 
          check_mtd_in_htbl mtd_sub_htbl cname mtd;
          mtd.ir3id <- SimpleVarId (cname ^ "_" ^ (string_of_int idx));
          Hashtbl.add mtd_sub_htbl mtd.mOOLid (mtd.ir3id,mtd.rettype,get_tlist mtd.params);
          itr_mtd_list tail (idx+1) 
      in itr_mtd_list mtd_list 0;
      Hashtbl.add cmtd_t_htbl cname mtd_sub_htbl
    in ignore (List.map add_cls_into_htbl clist) 

(* Create the hashtable for class variable types *)
let make_cvar_t_htbl (clist: class_decl list) =
  let class_map_func ((cname,var_list,_): class_decl) =
    let var_sub_htbl = Hashtbl.create 10 in 
    let var_map_func ((v_t,v_id): var_decl) = 
      match v_id with 
      | SimpleVarId ids ->
        check_var_in_htbl var_sub_htbl cname v_id;
        Hashtbl.add var_sub_htbl v_id v_t  
      | _ -> () (* this case should never occur! *) 
    in ignore (List.map var_map_func var_list);
    Hashtbl.add cvar_t_htbl cname var_sub_htbl
  in ignore (List.map class_map_func clist) 

(* Create related hashtables for later type lookup *)
let make_t_htbls ((cmain,clist): mOOL_program) =
  make_cmtd_t_htbl (cmain,clist);
  make_cvar_t_htbl clist

(* Compare two variable ids *)   
let compare_var_ids (v1: var_id) 
                    (v2: var_id) : bool =
  match v1,v2 with
  | SimpleVarId id1, SimpleVarId id2 -> 
    ((String.compare id1 id2) == 0)
  | SimpleVarId id1, TypedVarId (id2,t,s) -> 
    ((String.compare id1 id2) == 0)  
  | TypedVarId (id1,t,s), SimpleVarId id2 -> 
    ((String.compare id1 id2) == 0)    
  | TypedVarId (id1,t1,s1), TypedVarId (id2,t2 ,s2) ->
    ((String.compare id1 id2) == 0) && (s1 == s2)

(* Find the declared type of a variable *)     
let rec find_var_decl_type (vlst: var_decl list) 
                           (vid: var_id) : var_decl =
  match vlst with
  | [] -> (Unknown, SimpleVarId "") 
  | (t,v)::lst -> 
    if (compare_var_ids v vid) then (t,v) 
    else find_var_decl_type lst vid

(* Check if a variable id exists *)
let exists_var_id (vlst: var_decl list) 
                  (vid: var_id) : bool =
  let is_eq_id (t,v) = 
    compare_var_ids v vid 
  in List.exists is_eq_id vlst 

(* Check if the declaration of a class exists *)         
let exists_class_decl ((cm,clst): mOOL_program) 
                      (cid: class_name) : bool =
  List.exists 
     (fun (cname,cvars,cmtd) -> 
        (String.compare cname cid) == 0)
  clst

(* Annotate a list of variable declarations with their scope *)  
let rec create_scoped_var_decls (vlst: var_decl list) (scope: int) : var_decl list =
  let helper ((vt,vid): var_decl) : var_decl =
    match vid with
    | SimpleVarId id -> (vt, TypedVarId (id, vt, scope))
    | TypedVarId (id,t,s) -> (vt, TypedVarId (id, vt, scope))
  in List.map helper vlst
  
(* Type check a list of variable declarations 
   1) Determine if all object types exist
   2) Find and return duplicate variable names 
   The function returns the typecheck result (true or false) and an error message.
*) 
let rec type_check_var_decl_list (p: mOOL_program) (vlst: var_decl list) : (bool * string) =
  let rec helper (vlst: var_decl list) : mOOL_type list =
    match vlst with
    | [] -> []
    | (typ,vid)::tail -> 
      match typ with
      | ObjectT cname -> 
        (* check if the declared class name exists *)
        if (exists_class_decl p cname) then helper tail
        (* put the undefined type into the list *)
        else typ::helper tail 
        (* Primitive type *)
      | _ -> helper tail 
  in match (helper vlst) with
     | [] -> (true,"")
     | lst -> (false, ("Undefined types: " ^ (string_of_list lst string_of_mOOL_type ",")))
 
(* Type check an expression 
   Return the type of the expression 
   and a new TypedExpession 
*) 
let rec type_check_expr (p: mOOL_program) 
                        (env: var_decl list) 
                        (classid: class_name) 
                        (exp: mOOL_exp) : (mOOL_type * mOOL_exp) =
  let rec helper (e: mOOL_exp) : (mOOL_type * mOOL_exp) =
    match e with
    | BoolLiteral v -> (BoolT, e)
    | IntLiteral v -> (IntT, e)
    | StringLiteral v -> (StringT, e)
    | ThisWord -> (ObjectT classid, TypedExp (e, ObjectT classid))
    | NullWord -> (ObjectT "null", TypedExp (e, ObjectT "null"))
    | Var v -> 
      let (vtyp,vid) = find_var_decl_type env v in
      if (vtyp = Unknown) then 
        failwith ("\nType-check error in " ^ classid ^ "." 
                  ^ ". expression fails:\n" 
		  ^ string_of_mOOL_expr e ^ 
                    " variable not defined!\n")
      else (vtyp, TypedExp (Var vid,vtyp))
    | ObjectCreate c -> 
      if (exists_class_decl p c) 
      then (ObjectT c, TypedExp(e, ObjectT c)) 
      else (Unknown, e)
    | UnaryExp (op, op_e) ->
      let (expr_type, exprnew) = type_check_expr p env classid op_e in
      if ((String.compare (string_of_mOOL_op op)) "!" == 0) then 
        match expr_type with 
        | BoolT -> (BoolT, TypedExp (UnaryExp (op, exprnew), BoolT)) 
        | _ -> failwith ("\nType-check error in " ^ classid ^ "." 
                         ^ ". expression fails:\n" 
			 ^ string_of_mOOL_expr op_e ^ "Expected of type BoolT, but of type: " 
                         ^ string_of_mOOL_type expr_type ^ "\n")
      else if ((String.compare (string_of_mOOL_op op) "-") == 0) then
        match expr_type with 
	| IntT -> (IntT, TypedExp (UnaryExp (op, exprnew), IntT))
        | _ -> failwith ("\nType-check error in " ^ classid ^ "." 
			 ^ ". expression fails:\n" 
			 ^ string_of_mOOL_expr op_e ^ "Expected of type IntT, but of type: " 
			 ^ string_of_mOOL_type expr_type ^ "\n")
      else failwith ("\nType-check error in " ^ classid ^ "." 
                     ^ ". expression fails:\n" 
                     ^ string_of_mOOL_expr op_e ^ "Unrecognized unary operator: "
                     ^ string_of_mOOL_op op ^ "\n")
    | BinaryExp (op, l_e, r_e) ->
      let (l_expr_type, l_expr_new) = type_check_expr p env classid l_e in
      let (r_expr_type, r_expr_new) = type_check_expr p env classid r_e in
      if (match_types l_expr_type r_expr_type) then
        match op with
        | BooleanOp s -> 
          begin 
            match l_expr_type with 
            | BoolT -> (BoolT, TypedExp (BinaryExp (op,l_expr_new,r_expr_new), BoolT))
            | _ -> failwith ("\nType-check error in " ^ classid ^ "." 
                             ^ ". expression fails:\n" 
                             ^ string_of_mOOL_expr e ^ "Expected of type BoolT, but of type: " 
			     ^ string_of_mOOL_type l_expr_type ^ "\n")
          end   
        | RelationalOp "<"
        | RelationalOp "<=" 
        | RelationalOp ">"
        | RelationalOp ">=" -> 
          begin
            match l_expr_type with 
	    | IntT -> (BoolT, TypedExp (BinaryExp (op,l_expr_new,r_expr_new), BoolT))
            | _ -> failwith ("\nType-check error in " ^ classid ^ "." 
                             ^ ". expression fails:\n" 
                             ^ string_of_mOOL_expr e ^ "Expected of type IntT, but of type: " 
                             ^ string_of_mOOL_type l_expr_type ^ "\n")
          end
        | RelationalOp "=="
        | RelationalOp "!=" ->
          (BoolT, TypedExp (BinaryExp (op,l_expr_new,r_expr_new), BoolT))
        | AritmeticOp s ->
          begin
            match l_expr_type with 
	    | IntT -> (IntT, TypedExp (BinaryExp (op,l_expr_new,r_expr_new), IntT))
            | _ -> failwith ("\nType-check error in " ^ classid ^ "." 
                             ^ ". expression fails:\n" 
                             ^ string_of_mOOL_expr e ^ "Expected of type IntT, but of type: " 
                             ^ string_of_mOOL_type l_expr_type ^ "\n")
          end 
        | _ -> failwith ("\nType-check error in " ^ classid ^ "." 
                         ^ ". expression fails:\n" 
                         ^ string_of_mOOL_expr e ^ "Unsupported binary expression: " 
                         ^ string_of_mOOL_type l_expr_type ^ "\n")
      else failwith ("\nType-check error in " ^ classid ^ "." 
                     ^ ". expression fails:\n" 
                     ^ string_of_mOOL_expr e
                     ^ " left expr and right expr type mismatch" ^ "\n")
    | FieldAccess (obj_e, id) ->
      let (expr_type, expr_new) = type_check_expr p env classid obj_e in    
      begin
        match expr_type with 
        | ObjectT cname ->  
	  if (Hashtbl.mem cvar_t_htbl cname) then
            let var_sub_htbl = Hashtbl.find cvar_t_htbl cname in
            if (Hashtbl.mem var_sub_htbl id) then
              let var_type = Hashtbl.find var_sub_htbl id in 
                (var_type, TypedExp (FieldAccess (expr_new,id), var_type))
            else failwith ("\nType-check error in " ^ classid ^ "." 
                           ^ ". expression fails:\n" 
                           ^ string_of_mOOL_expr obj_e ^ "'s field " 
                           ^ string_of_var_id id ^ " cannot be found\n")
          else failwith ("\nType-check error in " ^ classid ^ "." 
                         ^ ". expression fails:\n" 
                         ^ string_of_mOOL_expr obj_e ^ " cannot be found\n")
        | _ -> failwith ("\nType-check error in " ^ classid ^ "." 
                         ^ ". expression fails:\n" 
                         ^ string_of_mOOL_expr obj_e ^ "is not ObjectT \n")
      end
    | MdCall (func_e, param_exp_list) ->
      let rec itr_func_sig_list sig_list matched_list matchedNum = 
        match sig_list with
        | (anno_id,ret_type,param_types)::tail ->
          let filter_param_type_exp (param: mOOL_exp) : mOOL_type * mOOL_exp =
            type_check_expr p env classid param in
            let filter_param_exp ((t,exp): (mOOL_type * mOOL_exp)) : mOOL_exp = exp in
              let filter_param_type ((t,exp): (mOOL_type * mOOL_exp)) : mOOL_type = t in
                let args_list = List.map filter_param_type_exp param_exp_list in
                let args_exp_list = (List.map filter_param_exp args_list) in
                let args_type_list = (List.map filter_param_type args_list) in
                if (match_type_list param_types args_type_list) then
                  itr_func_sig_list tail ((anno_id,ret_type,args_exp_list)::matched_list) (matchedNum+1)
                else itr_func_sig_list tail matched_list matchedNum 
        | [] -> 
          if (matchedNum==0) 
          then failwith ("\nType-check error in " ^ classid ^ "." 
                         ^ ". expression fails:\n" 
                         ^ string_of_mOOL_expr e ^ " arguments type not matched! \n")
          else if (matchedNum==1) then
            match matched_list with
            | matched_item::[] -> matched_item
            | _ -> failwith ("\nThis cannot happen, internal error!\n") 
          else (* more than one valid match, related with null match ObjectT *)
            let helper func_ids1 (func_id2,_,_) = 
              (func_ids1 ^ " " ^ (string_of_var_id func_id2) ^ " ") in
            let matched_func_ids = (List.fold_left helper "" matched_list) in
            failwith ("\nType-check error in " ^ classid ^ "." 
                         ^ ". confusion in MdCall expression:\n" 
                         ^ string_of_mOOL_expr e 
                         ^ " multiple functions match the given parameters: " 
                         ^ matched_func_ids ^ "\n") 
      in begin 
        match func_e with
        (* func_e is a function defined in this class *)
        | Var varId ->
          let mtd_sub_htbl = Hashtbl.find cmtd_t_htbl classid in
            if (Hashtbl.mem mtd_sub_htbl varId) then
	      let sig_list = Hashtbl.find_all mtd_sub_htbl varId in
              let (anno_id,ret_type,args_exp_list) = itr_func_sig_list sig_list [] 0 in
	      (ret_type, TypedExp (MdCall (Var anno_id, args_exp_list), ret_type))               
            else failwith ("\nType-check error in " ^ classid ^ "." 
                            ^ ". expression fails:\n" 
                            ^ string_of_mOOL_expr func_e ^ " can not find such function \n")
        (* func_e is a function of other objects *) 
        | FieldAccess (obj_e, id) -> 
          begin 
            let (expr_type, expr_new) = type_check_expr p env classid obj_e in    
            match expr_type with 
            | ObjectT cname -> 
              if (Hashtbl.mem cmtd_t_htbl cname) then 
                let mtd_sub_htbl = Hashtbl.find cmtd_t_htbl cname in
                if (Hashtbl.mem mtd_sub_htbl id) then
                  let sig_list = Hashtbl.find_all mtd_sub_htbl id in
                  let (anno_id,ret_type,args_exp_list) = itr_func_sig_list sig_list [] 0 in
                  let field_access_exp = FieldAccess (expr_new, anno_id) in
                    (ret_type, TypedExp (MdCall (field_access_exp,args_exp_list), ret_type)) 
                else failwith ("\nType-check error in " ^ classid ^ "." 
                               ^ ". expression fails:\n" 
                               ^ string_of_mOOL_expr obj_e ^ "'s field " 
                               ^ string_of_var_id id ^ " cannot be found\n")
              else failwith ("\nType-check error in " ^ classid ^ "." 
                              ^ ". expression fails:\n" 
                              ^ string_of_mOOL_expr obj_e ^ " cannot be found\n")
            | _ -> failwith ("\nType-check error in " ^ classid ^ "." 
                             ^ ". expression fails:\n" 
                             ^ string_of_mOOL_expr obj_e ^ "is not ObjectT \n")
          end 
        | _ -> failwith ("\nType-check error in " ^ classid ^ "." 
                          ^ ". expression fails:\n" 
                          ^ string_of_mOOL_expr func_e ^ " is not a function form \n")
      end
    | _ -> (Unknown, e) 
  in helper exp

(* Type check a list of statements and determine the return type.
   Exceptions are thrown when a statement does not type check 
   and when dead code is found
*)
let rec type_check_stmts (p: mOOL_program) 
                         (env: var_decl list) 
                         (classid: class_name) 
                         (mthd: md_decl) 
                         (stmtlst: mOOL_stmt list)
                         (rettype: mOOL_type option) : (mOOL_type option * mOOL_stmt list) =
  match stmtlst with
  | [] -> (rettype, [])
  | s::tail_lst -> 
    let rec helper (s: mOOL_stmt) : (mOOL_type option * mOOL_stmt) =
      match s with
      | ReturnStmt e ->  
        let (expr_type, exprnew) = type_check_expr p env classid e in
        if (match_types expr_type mthd.rettype) 
        then (Some expr_type, ReturnStmt exprnew)
        else failwith ("\nType-check error in " ^ classid ^ "." 
                       ^ string_of_var_id mthd.mOOLid 
                       ^ ". Return expression fails:\n" 
                       ^ string_of_mOOL_stmt s ^ " - Expect return type "
                       ^ string_of_mOOL_type mthd.rettype
                       ^ " but actual return type is " ^ string_of_mOOL_type expr_type ^ "\n")
      | ReturnVoidStmt -> 
        if (match_types VoidT mthd.rettype) 
        then (Some VoidT, ReturnVoidStmt)
        else failwith ("\nType-check error in " ^ classid ^ "." 
                       ^ string_of_var_id mthd.mOOLid 
                       ^ ". Return expression fails:\n" 
                       ^ string_of_mOOL_stmt s ^ " - Expect return type " 
                       ^ string_of_mOOL_type mthd.rettype 
                       ^ " but actual return type is VoidT\n")
      | ReadStmt id -> 
        let (idtype,scopedid) = find_var_decl_type env id in
        begin
          match idtype with
          | ObjectT _ | Unknown -> 
            failwith ("\nType-check error in " ^ classid ^ "." 
                      ^ string_of_var_id mthd.mOOLid 
                      ^ ". Read statement fails:\n" 
                      ^ string_of_mOOL_stmt s ^ "\n")
          | _ -> (None, ReadStmt scopedid)
        end
      | PrintStmt e -> 
        let (expr_type,exprnew) = type_check_expr p env classid e in
        begin 
          match expr_type with
          | ObjectT _ | Unknown -> 
            failwith ("\nType-check error in " ^ classid ^ "." 
                      ^ string_of_var_id mthd.mOOLid  
                      ^ ". Statement fails:\n" 
                      ^ string_of_mOOL_stmt s ^ "\n")
          | _ -> (None, PrintStmt exprnew)
        end
      | IfStmt (e,then_stmt_lst,else_stmt_lst) -> 
        let (expr_type, exprnew) = (type_check_expr p env classid e) in
        begin
          match expr_type with
          | BoolT -> 
            let (then_ret_type, then_new_stmts) =  
              type_check_stmts p env classid mthd then_stmt_lst rettype in
            let (else_ret_type, else_new_stmts) = 
              type_check_stmts p env classid mthd else_stmt_lst rettype in
            begin
              match then_ret_type with 
              | Some then_t -> 
                begin
                  match else_ret_type with 
                  | Some else_t -> 
                    if (match_types then_t else_t) then 
                      (Some then_t, IfStmt (exprnew,then_new_stmts,else_new_stmts))
                    else failwith ("\nType-check error in " ^ classid ^ "." 
                                   ^ string_of_var_id mthd.mOOLid  
                                   ^ ". If Statement return type not match :\n" 
                                   ^ string_of_mOOL_stmt s ^ "\n")
                  | None -> (None, IfStmt (exprnew,then_new_stmts,else_new_stmts)) 
                end
              | None -> (None, IfStmt (exprnew,then_new_stmts,else_new_stmts))
            end
          | _ -> failwith ("\nType-check error in " ^ classid ^ "."
                           ^ string_of_var_id mthd.mOOLid 
                           ^ ". If statement condition not bool fails:\n"
                           ^ string_of_mOOL_stmt s ^ "\n")
        end
      | WhileStmt (e, while_stmt_lst) ->  
        let (expr_type, exprnew) = (type_check_expr p env classid e) in
        begin 
          match expr_type with  
          | BoolT -> 
            let (while_ret_type, while_new_stmts) =  
              type_check_stmts p env classid mthd while_stmt_lst rettype in
            (None, WhileStmt (exprnew,while_new_stmts)) (* return none cause it may not enter the while *)
          | _ -> failwith ("\nType-check error in " ^ classid ^ "."
                           ^ string_of_var_id mthd.mOOLid 
                           ^ ". While statement condition not bool fails:\n"
                           ^ string_of_mOOL_stmt s ^ "\n")
        end
      | MdCallStmt e ->
        let (expr_type, exprnew) = type_check_expr p env classid e in     
        begin
          match expr_type with
          | Unknown -> failwith ("\nType-check error in " ^ classid ^ "." 
                                 ^ string_of_var_id mthd.mOOLid  
                                 ^ ". Statement fails:\n" 
                                 ^ string_of_mOOL_stmt s ^ "\n")
          | _ -> (None, MdCallStmt exprnew)
        end
      | AssignStmt (id,e) -> 
        if ((exists_var_id env id) == true) then
          let (var_type, typId) = (find_var_decl_type env id) in 
          let (expr_type, exprnew) = (type_check_expr p env classid e) in
          if (match_types var_type expr_type) then (None, AssignStmt (typId,exprnew)) 
          else failwith ("\nType-check error in " ^ classid ^ "." 
                         ^ string_of_var_id mthd.mOOLid ^ "id: "  
                         ^ string_of_var_id id ^ " type not match" ^ ".Statement fails:\n" 
                         ^ string_of_mOOL_stmt s ^ "\n")
        else failwith ("\nType-check error in " ^ classid ^ "." 
                       ^ string_of_var_id mthd.mOOLid ^ "id: "  
                       ^ string_of_var_id id ^ " not found" ^ ".Statement fails:\n" 
                       ^ string_of_mOOL_stmt s ^ "\n")
      | AssignFieldStmt (left_exp, right_exp) ->
        let (left_exp_type, new_left_exp) = type_check_expr p env classid left_exp in
        let (right_exp_type, new_right_exp) = type_check_expr p env classid right_exp in
        if (match_types left_exp_type right_exp_type) then
          (None, AssignFieldStmt (new_left_exp, new_right_exp))
        else failwith ("\nType-check error in " ^ classid ^ "." 
                       ^ string_of_var_id mthd.mOOLid ^ "left exp type and right exp type not match"  
                       ^ ".Statement fails:\n" 
                       ^ string_of_mOOL_stmt s ^ "\n")
    in let (newrettype, newstmt) = helper s in
      match newrettype, tail_lst with
      (* Found current stmt returns and there are still rest stmts, 
         then the rest stmts are dead code! 
      *)
      | Some t, head::tail -> 
	failwith ("\nType-check error in " ^ classid ^ "." 
                  ^ string_of_var_id mthd.mOOLid 
                  ^ ". Dead Code:\n" 
                  ^ (string_of_list tail_lst string_of_mOOL_stmt "\n" ^ "\n")) 
      | _,_ -> 
        let (rettype, stmts) = 
	  type_check_stmts p env classid mthd tail_lst newrettype in
        (rettype, (newstmt::stmts))
  
(* TypeCheck a MOOL Method Declaration *)
let type_check_mthd_decl (p: mOOL_program) 
                         (env: var_decl list)
                         (cname: class_name)
                         (m: md_decl) : md_decl = 
  let mthdenv = List.append m.params m.localvars in 
  let (retval, errmsg) = (type_check_var_decl_list p mthdenv) in 
    if (retval == false) then 
      failwith ("\nType-check error in " ^ cname ^ "."
                ^ string_of_var_id m.mOOLid 
                ^ " parameter or local variables declarations.\n" ^ errmsg ^ "\n")
    else
      (* Note that the mthdenv comes before classenv so that linear search for type *) 
      let scopedEnv = List.append (create_scoped_var_decls mthdenv 2) env in 
      (* TypeCheck the body of the method *)
      let (rettyp,newstmts) = (type_check_stmts p scopedEnv cname m m.stmts None) in
      (* TypeCheck the return type of the method *)
      let _ = 
        match rettyp,m.rettype with
        | None, VoidT -> true
        | None, _ -> failwith ("\nType-check error in " ^ cname ^ "." 
                                ^ string_of_var_id m.mOOLid  
                                ^ ". This method must return a result of type " 
                                ^ string_of_mOOL_type m.rettype ^ ". \n")
        | _,_ -> true (* Just ignore this case, cause the type has been checked in return stmt itself *)
  in { m with stmts=newstmts }

(* Type check a MOOL Program. 
   Return a new MOOL Program 
   where all expressions are annotated with types
*)
let type_check_mOOL_program (p: mOOL_program) : mOOL_program =
  ignore (make_t_htbls p);
  (* Type check main class declaration *) 
  let type_check_class_main ((cname, mmthd): class_main) : class_main =
    (cname, (type_check_mthd_decl p [] cname mmthd)) in
  (* Type check the other class declarations *)
  let rec type_check_class_decl ((cname, cvars, cmthds): class_decl) : class_decl =
    (* Type check method declarations *)
    let env = create_scoped_var_decls cvars 1 in 
    (cname, cvars, List.map (type_check_mthd_decl p env cname) cmthds) in 
  let (mainclass, classes) = p in 
  let newmain = (type_check_class_main mainclass) in
  let newclasses = (List.map type_check_class_decl classes) in
  (newmain,newclasses)

(* End of File *)
