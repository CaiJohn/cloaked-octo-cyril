open Arm_structs
open Jlite_structs
open Ir3_structs_new
open Assign_register

(* class_name -> size *)
let class_size_htbl = Hashtbl.create 1000
(* class_name -> (field_name -> offset) *)
let class_field_htbl = Hashtbl.create 1000
(* string_literal -> label string *)
let str_ltr_htbl = Hashtbl.create 1000 

let global_id = ref (-1)
let get_new_id () =
  global_id := !global_id + 1;
  !global_id

let preprocess_clist clist = 
  let helper (cname, vars) =
    let field_htbl = Hashtbl.create 1000 (* var_name -> offset *) in
    let rec calc_size vars offset =
      match vars with
      | [] -> () 
      | (_,(var_name,_))::rest -> 
        Hashtbl.add field_htbl var_name offset;
        calc_size rest (offset+4)
    in 
    calc_size vars 0;
    Hashtbl.add class_size_htbl cname ((List.length vars)*4);
    Hashtbl.add class_field_htbl cname field_htbl
  in List.map helper clist   


(* Given parameter must be a variable with a register *)
let get_reg_from_id3 (vname,reg_or_mem) =
  match reg_or_mem with
  | Reg r -> Assign_register.convert r
  | Mem _ -> failwith ("Error - "^vname^" should be a register!")

(* Given parameter cannot be StringLiteral3 *)
let get_op2_from_idc3 var : operand2_type = 
  match var with
  | IntLiteral3_new v -> ImmedOp ("#"^string_of_int v)
  | BoolLiteral3_new b -> if b then ImmedOp "#1" else ImmedOp "#0" 
  | Var3_new id3_val -> RegOp (get_reg_from_id3 id3_val) 
  | StringLiteral3_new _ -> failwith ("Error - "^string_of_idc3_new var^" cannot be String Literal!")
 
let get_lbl_from_str str =
  if Hashtbl.mem str_ltr_htbl str then Hashtbl.find str_ltr_htbl str
  else let ids = "L"^string_of_int (get_new_id()) in
    Hashtbl.add str_ltr_htbl str ids;
    ids  

(* Given parameter must be StringLiteral3_new *) 
let get_addr_type_from_idc3 var : address_type =
  match var with
  | StringLiteral3_new s ->
    let label = get_lbl_from_str s in 
    LabelAddr ("="^label)
  | _ -> failwith "Error - get address type of idc3 can only be string!"


(* Given parameter must be Var3_new *)
let get_reg_from_idc3 var = 
  match var with
  | Var3_new id3_val -> get_reg_from_id3 id3_val
  | _ -> failwith ("Error - "^string_of_idc3_new var^" should be a register!")

let get_offset_from_idc3 var = 
  match var with
  | Var3_new (_,Mem memStr) -> int_of_string (Assign_register.convert memStr) 
  | _ -> failwith ("Error - "^string_of_idc3_new var^" should be a var with spill mem!")

let is_idc3_spill var =
  match var with
  | Var3_new (_,Reg _) -> false
  | Var3_new (_,Mem _) -> true 
  | _ -> false

let get_ops_from_op op =
  match op with
  | BooleanOp s -> s
  | RelationalOp s -> s
  | AritmeticOp s -> s
  | UnaryOp s -> s

let print_string_arm str : arm_instr list =
  let lbl = get_lbl_from_str (str^"\\n") in
  let str_addr_type = LabelAddr ("="^lbl) in
  let arg1_instr = LDR ("","","a1",str_addr_type) in
  let call_instr = BL ("","printf(PLT)") in
  [arg1_instr;call_instr] 

let print_int_arm i : arm_instr list =
  let lbl = get_lbl_from_str "%i\\n" in
  let str_addr_type = LabelAddr ("="^lbl) in
  let arg1_instr = LDR ("","","a1",str_addr_type) in
  let arg2_instr = MOV ("",false,"a2",ImmedOp ("#"^string_of_int i)) in 
  let call_instr = BL ("","printf(PLT)") in
  [arg1_instr;arg2_instr;call_instr]

let print_bool_arm b : arm_instr list = 
  let v = if b then 1 else 0 in
  print_int_arm v

let print_var_arm a1str idc3_val : arm_instr list =
  let lbl = get_lbl_from_str a1str in
  let str_addr_type = LabelAddr ("="^lbl) in
  let arg1_instr = LDR ("","","a1",str_addr_type) in
  let arg2_instr = MOV ("",false,"a2",RegOp (get_reg_from_idc3 idc3_val)) in 
  let call_instr = BL ("","printf(PLT)") in
  [arg2_instr;arg1_instr;call_instr] 

let ir3_to_arm_mtd md : arm_instr list = 
  let lvars_htbl = Hashtbl.create 1000 (* var_name -> class_name *) in
  (* Given parameter must be a field access expression 
     and the return type must be RegPreIndexed
  *)
  let get_addr_type_from_exp exp : address_type = 
    match exp with
    | FieldAccess3_new (obj_id3, field_id3) -> 
      let (vname,_) = obj_id3 in
      let cname = Hashtbl.find lvars_htbl vname in 
      let (field_name,_) = field_id3 in
      let obj_reg = get_reg_from_id3 obj_id3 in
      let offset_htbl = Hashtbl.find class_field_htbl cname in
      let offset = Hashtbl.find offset_htbl field_name in
      RegPreIndexed (obj_reg,offset,false)
    | _ -> failwith ("Error - "^string_of_ir3_exp_new exp^" is not field access!") 
  in
  let (md_name,_) = md.id3 in
  let return_label = "." ^ md_name ^ "_exit" in
  let rec init_lvars_htbl lvars =
    match lvars with
    | [] -> ()
    | (var_type, (var_name,_))::rest ->
      let _ =
        match var_type with
        | ObjectT cname -> Hashtbl.add lvars_htbl var_name cname 
        | IntT -> Hashtbl.add lvars_htbl var_name "Int"
        | BoolT -> Hashtbl.add lvars_htbl var_name "Bool"
        | StringT -> Hashtbl.add lvars_htbl var_name "String"
        | _ -> ()
      in init_lvars_htbl rest
  in 
  init_lvars_htbl md.params3;
  init_lvars_htbl md.localvars3;
  let call_function (fname,_) args : int*arm_instr list =
    let rec get_arg_instrs idx args : int*arm_instr list =
      match args with
      | [] -> (0,[])
      | idc3_val::rest ->  
        let (n,arm_instrs) = get_arg_instrs (idx+1) rest in
        let (c,arg_instrs) = 
          if idx>4 then (* for parameters more than 4 *) 
            let (reg,assign_instrs) = 
              match idc3_val with
              | StringLiteral3_new str ->
                let lbl = get_lbl_from_str str in
                let addr_type = LabelAddr ("="^lbl) in
                ("a1", [LDR ("","","a1",addr_type)]) 
              | IntLiteral3_new _ | BoolLiteral3_new _ ->
                ("a1", [MOV ("",false,"a1",get_op2_from_idc3 idc3_val)])
              | Var3_new _ ->
                if is_idc3_spill idc3_val then
                  let addr_type = RegPreIndexed ("fp",get_offset_from_idc3 idc3_val,false) in 
                  ("a1",[LDR ("","","a1",addr_type)])
                else (get_reg_from_idc3 idc3_val,[])
            in let stm_instr = STMFD [reg] in (1,assign_instrs@[stm_instr])
          else
            match idc3_val with
            | StringLiteral3_new str ->
              let lbl = get_lbl_from_str str in
              let addr_type = LabelAddr ("="^lbl) in
              (0,[LDR ("","","a"^string_of_int idx,addr_type)])
            | _ -> 
              if is_idc3_spill idc3_val then
                let addr_type = RegPreIndexed ("fp",get_offset_from_idc3 idc3_val,false) in
                let ldr_instr = LDR ("","","a1",addr_type) in
                let mov_instr = MOV ("",false,"a"^string_of_int idx,RegOp "a1") in
                (0, [ldr_instr;mov_instr])
              else (0,[MOV ("",false,"a"^string_of_int idx,get_op2_from_idc3 idc3_val)])
        in (n+c,arm_instrs@arg_instrs)
     in 
     let (n,arm_instrs) = get_arg_instrs 1 args in
     let call_instr = BL ("",fname) in
     (n,arm_instrs @ [call_instr])
  in 
  let translate_stmt stmt : arm_instr list =
    match stmt with
    | Label3_new lbl -> [Label ("."^string_of_int lbl)]
    | GoTo3_new lbl -> [B ("","."^string_of_int lbl)]
    | AnnoIfStmt3_new instrlst -> instrlst
    | PrintStmt3_new idc3_val -> 
      begin
        match idc3_val with
        | IntLiteral3_new i -> print_int_arm i 
        | BoolLiteral3_new b -> print_bool_arm b
        | StringLiteral3_new str -> print_string_arm str
        | Var3_new (var_name,reg_or_mem) ->
          let type_str = Hashtbl.find lvars_htbl var_name in
          if type_str="Int" then print_var_arm "%i\\n" idc3_val 
          else if type_str="Bool" then print_var_arm "%i\\n" idc3_val 
          else if type_str="String" then print_var_arm "%s\\n" idc3_val 
          else failwith "Error - can only print Int, Bool or String!"
      end
    | AssignStmt3_new (lid3,rexp) ->
      let lreg = get_reg_from_id3 lid3 in
      begin
        match rexp with
        | FieldAccess3_new _ ->
          let addr_type = get_addr_type_from_exp rexp in
          [LDR ("","",lreg,addr_type)]
        | ObjectCreate3_new cname ->
          let csize = Hashtbl.find class_size_htbl cname in
          let size_param_instr = MOV ("",false,"a1",ImmedOp ("#"^string_of_int csize)) in
          let call_znjw_instr = BL ("", "_Znwj(PLT)") in
          let assign_instr = MOV ("",false,lreg,RegOp "a1") in
          [size_param_instr;call_znjw_instr;assign_instr]
        | Idc3Expr_new idc3_val ->
          begin
            match idc3_val with
            | StringLiteral3_new _ -> 
              let addr_type = get_addr_type_from_idc3 idc3_val in
              [LDR ("","",lreg,addr_type)]
            | IntLiteral3_new i ->
              if i<= 1020 then let op2 = get_op2_from_idc3 idc3_val in [MOV ("",false,lreg,op2)] 
              else let addr_type = LabelAddr ("="^string_of_int i) in
                   [LDR ("","",lreg,addr_type)] 
            | _ -> 
              let op2 = get_op2_from_idc3 idc3_val in
              [MOV ("",false,lreg,op2)]
          end
        | UnaryExp3_new (op,idc3_val) ->
          let ops = get_ops_from_op op in
          begin
            match idc3_val with
            | IntLiteral3_new v -> [RSB ("",false,lreg,lreg,ImmedOp "#0")] 
            | BoolLiteral3_new b -> if b then [MOV ("",false,lreg,ImmedOp "#0")] 
                                    else [MOV ("",false,lreg,ImmedOp "#1")]
            | Var3_new id3_val -> 
              let rreg = get_reg_from_id3 id3_val in
              if ops="-" then [RSB ("",false,lreg,rreg,ImmedOp "#0")]
              else [RSB ("",false,lreg,rreg,ImmedOp "#1")] 
            | StringLiteral3_new _ -> failwith "Error - unary op not apply to string!"
          end
        | BinaryExp3_new (op,lvar,rvar) ->
          let ops = get_ops_from_op op in
          let op_lreg = 
          begin
            match lvar with
            | IntLiteral3_new _ | BoolLiteral3_new _ -> lreg
            | Var3_new id3_val -> get_reg_from_id3 id3_val 
            | StringLiteral3_new _ -> failwith "Error - binary op not apply to string!"
          end in
          let op2 = get_op2_from_idc3 rvar in
          if ops="+" then [ADD ("",false,lreg,op_lreg,op2)] 
          else if ops="-" then [SUB ("",false,lreg,op_lreg,op2)]
          else if ops="*" then 
            if lreg=op_lreg then [MUL ("",false,lreg,get_reg_from_idc3 rvar,op_lreg)]
            else [MUL ("",false,lreg,op_lreg,get_reg_from_idc3 rvar)] 
          else if ops="&&" then [AND ("",false,lreg,op_lreg,op2)]
          else if ops="||" then [ORR ("",false,lreg,op_lreg,op2)]
          else if ops="/" then failwith "Error - division not supported!"
          else (* ==,!=,>,>=,<,<= *) 
            let cmp_instr = CMP ("",op_lreg,op2) in
            let (conds,neg_conds) = 
              if ops="==" then ("eq","ne") 
              else if ops="!=" then ("ne","eq") 
              else if ops=">=" then ("ge","lt")
              else if ops=">" then ("gt","le")
              else if ops="<=" then ("le","gt")
              else ("lt","ge") in
            let mov_instr1 = MOV (conds,false,lreg,ImmedOp "#1") in
            let mov_instr2 = MOV (neg_conds,false,lreg,ImmedOp "#0") in
            [cmp_instr;mov_instr1;mov_instr2]
        | MdCall3_new (fname,args) ->  
          let (n,arm_instrs) = call_function fname args in
          let new_instrs = 
            if n>0 then (arm_instrs @ [ADD ("",false,"sp","sp",ImmedOp ("#"^string_of_int (4*n)))]) 
            else arm_instrs in 
          let assign_instr = MOV ("",false,lreg,RegOp "a1") in
          new_instrs @ [assign_instr]
      end 
    | AssignFieldStmt3_new (lexp,rexp)->
      let l_addr_type = get_addr_type_from_exp lexp in
      begin 
        match rexp with
        | Idc3Expr_new idc3_val ->
          begin
            match idc3_val with
            | Var3_new id -> [STR ("","",get_reg_from_id3 id,l_addr_type)] 
            | _ -> failwith "Error - the righ exp of AssignFieldStmt cannot be literals!" 
          end
        | _ -> failwith "Error - the right exp of AssignFieldStmt can only be Idc3Expr!"
      end 
    | MdCallStmt3_new md_call_exp ->
      begin 
        match md_call_exp with
        | MdCall3_new (fname,args) ->
          let (n,arm_instrs) = call_function fname args in
            if n>0 then arm_instrs @ [ADD ("",false,"sp","sp",ImmedOp ("#"^string_of_int (4*n)))] 
            else arm_instrs
        | _ -> failwith "Error - MdCall stmt must be MdCallExp"
      end
    | ReturnStmt3_new id3_val -> 
      let reg = get_reg_from_id3 id3_val in
      let assign_a1_instr = MOV ("",false,"a1",RegOp reg) in
      let return_instr = B ("",return_label) in
      [assign_a1_instr;return_instr]
    | ReturnVoidStmt3_new -> [B ("",return_label)]
    | LD (reg,mem) ->
      let addr_type = RegPreIndexed ("fp",int_of_string (Assign_register.convert mem),false) in
      [LDR ("","",Assign_register.convert reg,addr_type)]
    | ST (reg,mem) ->
      let addr_type = RegPreIndexed ("fp",int_of_string (Assign_register.convert mem),false) in
      [STR ("","",Assign_register.convert reg,addr_type)]
    | _ -> failwith "Error - No IfStmt3_new, ReadStmt3_new and AssignDeclStmt3_new!"
  in
  let rec translate_stmts stmts : arm_instr list =
    match stmts with
    | [] -> []
    | stmt::rest -> 
      (translate_stmt stmt) @ (translate_stmts rest) 
  in 
  let rec pass_params idx reg_or_mems : arm_instr list =
    match reg_or_mems with
    | [] -> [] 
    | reg_or_mem::rest -> 
      let assign_instr = 
        match reg_or_mem with
        | Reg reg -> if reg="dead" then [] 
          else if idx>4 then 
            let addr_type = RegPreIndexed ("fp",4*(idx-4),false) in
            [LDR ("","",Assign_register.convert reg,addr_type)]
          else [MOV ("",false,Assign_register.convert reg,RegOp ("a"^string_of_int idx))] 
        | Mem mem -> 
          let addr_type = RegPreIndexed ("fp",int_of_string (Assign_register.convert mem),false) in 
          if idx>4 then
            let ldr_addr_type = RegPreIndexed ("fp",4*(idx-4),false) in
            let ldr_instr = LDR ("","","a1",ldr_addr_type) in
            let str_instr = STR ("","","a1",addr_type) in
            [ldr_instr;str_instr] 
          else [STR ("","","a"^string_of_int idx,addr_type)]
      in assign_instr @ (pass_params (idx+1) rest)
  in
  let headers = [PseudoInstr "stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}";
                 PseudoInstr "add fp,sp,#24"; 
                 PseudoInstr ("sub sp,fp,#"^string_of_int md.stacksize)] in 
  let pass_params_instrs = pass_params 1 md.anno_param3 in 
  let trailers = [PseudoInstr "sub sp,fp,#24";
                  PseudoInstr "ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}"] in
  (Label md_name::headers) @ pass_params_instrs @ (translate_stmts md.ir3stmts) @ (Label return_label::trailers) 
 
let ir3_to_arm (clist,main,mthds): arm_program =
   let _ = preprocess_clist clist in
   let data_header = PseudoInstr ".data" in 
   let text_headers = [PseudoInstr ".text";PseudoInstr ".global main"] in  
   let main_instrs = List.fold_left 
                     (fun lst mtd -> lst @ (ir3_to_arm_mtd mtd))
                    [] (main::mthds) in
   let helper str lbl arm_instrs : arm_instr list =
      let lblInstr = Label lbl in
      let ascizInstr = PseudoInstr (".asciz \""^str^"\"") in
      lblInstr::ascizInstr::arm_instrs
   in 
   let str_literals = Hashtbl.fold helper str_ltr_htbl [] in
   (data_header::str_literals) @ text_headers @ main_instrs
