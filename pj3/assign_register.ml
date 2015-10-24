open Ir3_structs_new
open Arm_structs

let used_reg_to_var = Hashtbl.create 5 (* string -> string *)
let used_var_to_reg = Hashtbl.create 5 (* string -> string *)

(*function to convert our internal REG/MEM to ARM reg/mem offset*)
let convert reg_mem =
    let regex = Str.regexp "__\\([AMR]\\)\\([0-9]+\\)" in
    let res = Str.string_match regex reg_mem 0 in
    if res = true then 
        let id = Str.matched_group 1 reg_mem in
        let number = Str.matched_group 2 reg_mem in
        if id = "R" then "v"^string_of_int ((int_of_string number) + 1)
        else if id = "A" then "a"^number
        else if id = "M" then string_of_int(-24 - ((int_of_string number)+1)*4)
        else failwith "Not a reg or mem. What else can it be ?!"
    else failwith reg_mem^" Bad reg number"


let rec get_number (var_name:string) (index:int) lst : int =
    match lst with
    | [] ->
        (*Assign reg V1 if it is not found anywhere*) 
        print_endline "Critical warning: var with no reg or mem assigned";
        -1
    | h::t -> if var_name = h then index
              else get_number var_name (index+1) t

let get_tmp_a_reg var_name index= 
    let reg_list = ["__A1"; "__A2"; "__A3"; "__A4"] in
    let rec pick_reg (var_list: string list) = 
    match var_list with
    | [] -> failwith "Error - Reg a1 - a4 are all used up"
    | h::t -> if Hashtbl.mem used_reg_to_var h then pick_reg t 
              (* there are still regs available and mark in the hashtable*)
              else
                let _ = Hashtbl.add used_reg_to_var h var_name in 
                let _ = Hashtbl.add used_var_to_reg var_name h in h
    in
	let proposed_reg = "__A"^string_of_int((index mod 4) + 1) in
	if Hashtbl.mem used_reg_to_var proposed_reg = false then
	(*first try to pick its reserved reg first*)
		let _ = Hashtbl.add used_reg_to_var proposed_reg var_name in 
		let _ = Hashtbl.add used_var_to_reg var_name proposed_reg in proposed_reg
	(*if failed just follow the normal way*)
    else pick_reg reg_list 


let get_register_id var_id3 reg_alloc spill_list isRight
    : (string * reg_or_mem * (ir3_stmt_new option))= 
    let (name, reg) = var_id3 in
    try
    let (_, reg_id) =  List.find (fun (x, _) -> name = x) reg_alloc in
        let reg_name = "__R"^string_of_int reg_id in  
            (name, Ir3_structs_new.Reg reg_name, None)
    with Not_found ->
        try
        let found_reg = Hashtbl.find used_var_to_reg name in
            if isRight = true then (name, Ir3_structs_new.Reg found_reg, None)
            else let number = get_number name 0 spill_list
            in let mem_name = "__M"^(string_of_int number)
            in (name, Ir3_structs_new.Reg found_reg, Some (ST (found_reg, mem_name)))
        with Not_found ->
        let number = get_number name 0 spill_list
        (*Assign reg V1 if it is not found anywhere*)
        in if number = -1 then (name, Ir3_structs_new.Reg "__R0", None)
        else let spilled_reg = get_tmp_a_reg name number
            in let mem_name = "__M"^(string_of_int number)
            in if isRight = true then (name, Ir3_structs_new.Reg spilled_reg, Some (LD (spilled_reg, mem_name)))
                else (name, Ir3_structs_new.Reg spilled_reg, Some (ST (spilled_reg, mem_name)))

let get_register_idc var_idc3 reg_alloc spill_list isRight
    (*: (Var3_new * (ir3_stmt_new option))*)=
    match var_idc3 with
    | Var3_new (str, reg) ->
        begin
        try
            let (_, reg_id) =  List.find (fun (x, _) -> str = x) reg_alloc in
            let reg_name = "__R"^string_of_int reg_id in  
                (Var3_new (str, Ir3_structs_new.Reg reg_name), None)
        with Not_found ->
            try
            let found_reg = Hashtbl.find used_var_to_reg str in
                if isRight = true then (Var3_new (str, Ir3_structs_new.Reg found_reg), None)
                else let number = get_number str 0 spill_list
                in let mem_name = "__M"^(string_of_int number)
                in (Var3_new (str, Ir3_structs_new.Reg found_reg), Some (ST (found_reg, mem_name)))
            with Not_found -> 
            let number = get_number str 0 spill_list
            in if number = -1 then (Var3_new (str, Ir3_structs_new.Reg "__R0"), None)
            else 
                let spilled_reg = get_tmp_a_reg str number
                in let mem_name = "__M"^(string_of_int number)
                in if isRight = true then (Var3_new (str, Ir3_structs_new.Reg spilled_reg), Some (LD (spilled_reg, mem_name)))
                else (Var3_new (str, Ir3_structs_new.Reg spilled_reg), Some (ST (spilled_reg, mem_name)))
        end
    | t -> (t, None)

(*For method call we don't handle spill reg here 
 *because they have regs a1-a4*)
let get_register_idc_mdcall var_idc3 reg_alloc spill_list isRight
    (*: (Var3_new * (ir3_stmt_new option))*)=
    match var_idc3 with
    | Var3_new (str, reg) ->
        begin
        try
            let (_, reg_id) =  List.find (fun (x, _) -> str = x) reg_alloc in
            let reg_name = "__R"^string_of_int reg_id in
                (Var3_new (str, Ir3_structs_new.Reg reg_name), None)
        with Not_found ->
            let number = get_number str 0 spill_list
            in if number = -1 then (Var3_new (str, Ir3_structs_new.Reg "__R0"), None)
            else 
                let mem_name = "__M"^(string_of_int number)
                in if isRight = true then (Var3_new (str, Mem mem_name), None)
                    else (Var3_new (str, Mem mem_name), None)
        end
    | t -> (t, None)


let rec assign_register_stmts input_stmts reg_alloc spill_list
    : (Ir3_structs_new.ir3_stmt_new list) = 
    let rec assign_reg_exp3  input_expr isRight
    : (ir3_exp_new * ir3_stmt_new list option)= 
        match input_expr with
        | BinaryExp3_new (op, idc1, idc2) ->
            begin
            let (new_idc1, stmt1) = get_register_idc idc1 reg_alloc spill_list isRight in
            let (new_idc2, stmt2) = get_register_idc idc2 reg_alloc spill_list isRight in
            match (stmt1, stmt2) with
            | (None, None) -> (BinaryExp3_new (op, new_idc1, new_idc2), None)
            | (Some t, None)
            | (None, Some t) -> (BinaryExp3_new (op, new_idc1, new_idc2), Some [t])
            | (Some t1, Some t2) -> (BinaryExp3_new (op, new_idc1, new_idc2), Some ([t1]@[t2]))
            end
        | UnaryExp3_new (op, idc) ->
            begin
            let (new_idc, stmt) = get_register_idc idc reg_alloc spill_list isRight in
            match stmt with
            | None -> (UnaryExp3_new (op, new_idc), None)
            | Some t -> (UnaryExp3_new (op, new_idc), Some [t])
            end
        | FieldAccess3_new (id1, id2) ->
            begin
            let (s1, r1, stmt1) = get_register_id id1 reg_alloc spill_list isRight in
            match stmt1 with
            | None -> (FieldAccess3_new ((s1, r1), id2), None)
            | Some t1 -> (FieldAccess3_new ((s1, r1), id2), Some [t1])
            end
        | Idc3Expr_new idc ->
            begin
            let (new_idc, stmt) = get_register_idc idc reg_alloc spill_list isRight in
             match stmt with
            | None -> (Idc3Expr_new (new_idc), None)
            | Some t -> (Idc3Expr_new (new_idc), Some [t])
            end
        | MdCall3_new (id3, idc3_list)-> 
            begin
            let (new_idc3_list, stmts_list) = List.split (List.map (fun x -> get_register_idc_mdcall x reg_alloc spill_list isRight) idc3_list) in
            let rec helper lst = 
                match lst with
                | [] -> []
                | (Some h)::t -> h::helper t
                | None::t -> helper t
            in let stmt_lst = helper stmts_list in
            (MdCall3_new (id3, new_idc3_list), Some stmt_lst) 
            end
        | ObjectCreate3_new t -> (ObjectCreate3_new t, None)
    in let rec process_one_stmt input_stmt
    : (ir3_stmt_new list)=
        match input_stmt with
        | IfStmt3_new (e, l) -> 
            begin
            let (e_new, stmts) = assign_reg_exp3 e true in
            match (e_new, stmts) with
            (*Binary expression has to be in the form of reg == false *)
            | (BinaryExp3_new (_, Var3_new (_, Ir3_structs_new.Reg reg), _), None) ->  [AnnoIfStmt3_new [(CMP ("", convert reg, ImmedOp "#0"));(B ("EQ", "."^string_of_int l))]]  (*[IfStmt3_new (e, l)]*)
            | (BinaryExp3_new (_, Var3_new (_, Ir3_structs_new.Reg reg), _), Some s) -> 
                begin 
                match List.hd s with
                | LD (reg, mem) ->
                    let addr_type = RegPreIndexed ("fp",int_of_string (convert mem),false) in
      [AnnoIfStmt3_new [LDR ("","", convert reg,addr_type);(CMP ("", convert reg, ImmedOp "#0"));(B ("EQ", "."^string_of_int l))]]
                | _ -> failwith ("Error - IfStmt3 "^(string_of_ir3_exp_new e_new))
                end
            (*Unary expression can have boolean literals: !true, !false*)
            | (UnaryExp3_new (_, BoolLiteral3_new b), _) ->  
                if b = true then [AnnoIfStmt3_new []]
                else [AnnoIfStmt3_new [(B ("", "."^string_of_int l))]] 
            (*Unary expression in form of !reg*)
            | (UnaryExp3_new (_, Var3_new (_, Ir3_structs_new.Reg reg)), None) ->  [AnnoIfStmt3_new [(CMP ("", convert reg, ImmedOp "#0"));(B ("EQ", "."^string_of_int l))]] 
            | (UnaryExp3_new (_, Var3_new (_, Ir3_structs_new.Reg reg)), Some s) -> 
                begin 
                match List.hd s with
                | LD (reg, mem) ->
                    let addr_type = RegPreIndexed ("fp",int_of_string (convert mem),false) in
      [AnnoIfStmt3_new [LDR ("","", convert reg,addr_type);(CMP ("", convert reg, ImmedOp "#0"));(B ("EQ", "."^string_of_int l))]]
                | _ -> failwith ("Error - IfStmt3 "^(string_of_ir3_exp_new e_new))
                end
            | _ -> failwith ("Error - Invalid IfStmt3 "^(string_of_ir3_exp_new e_new)^"")
            end
        (*TODO*)
        | ReadStmt3_new (id3) -> 
            let (s, r, _) = get_register_id id3 reg_alloc spill_list true
            in [ReadStmt3_new ((s,r))]
        | PrintStmt3_new idc -> 
            begin
            let res = get_register_idc idc reg_alloc spill_list true  in
            match res with
            | (v, None) -> [PrintStmt3_new(v)]
            | (v, Some stmt) -> [stmt]@[PrintStmt3_new(v)]
            end
        | AssignStmt3_new (id3, exp)->
            begin
            let expStmt = assign_reg_exp3 exp true in
            let id3Stmt = get_register_id id3 reg_alloc spill_list false in
            match (id3Stmt, expStmt) with
            | ((s, r, None), (e, None)) -> [AssignStmt3_new((s,r), e)]
            | ((s, r, None), (e, Some stmts)) -> stmts@[AssignStmt3_new((s,r), e)]
            | ((s, r, Some stmt), (e, None)) -> [AssignStmt3_new((s,r), e)]@[stmt]
            | ((s, r, Some stmt), (e, Some stmts)) -> stmts@[AssignStmt3_new((s,r), e)]@[stmt]
            end
        | AssignFieldStmt3_new (exp1, exp2) ->
            begin
            let expStmt2 = assign_reg_exp3 exp2 true in
            let expStmt1 = assign_reg_exp3 exp1 true in
            match (expStmt1, expStmt2) with
            | ((e1, None), (e2, None)) -> [AssignFieldStmt3_new(e1, e2)]
            | ((e1, None), (e2, Some stmts1)) -> stmts1@[AssignFieldStmt3_new(e1, e2)]
            | ((e1, Some stmts1), (e2, None)) -> stmts1@[AssignFieldStmt3_new(e1, e2)]
            | ((e1, Some stmts1), (e2, Some stmts2)) -> stmts1@stmts2@[AssignFieldStmt3_new(e1, e2)]
            end
        | MdCallStmt3_new exp ->
            begin
            let expStmt = assign_reg_exp3 exp true in
            match expStmt with
            | (e1, None) -> [MdCallStmt3_new (e1)]
            | (e1, Some stmts) -> stmts@[MdCallStmt3_new (e1)]
            end
        | ReturnStmt3_new id -> 
            begin
            let id3Stmt = get_register_id id reg_alloc spill_list true in
            match id3Stmt with
            | (s, r, None) -> [ReturnStmt3_new((s,r))]
            | (s, r, Some stmt) -> [stmt]@[ReturnStmt3_new((s,r))]
            end
        | m -> [m]
    in match input_stmts with
    | [] -> []
    | h::t ->
        let _ = Hashtbl.reset used_reg_to_var in
        let _ = Hashtbl.reset used_var_to_reg in
        let res = process_one_stmt h in
            res@(assign_register_stmts t reg_alloc spill_list) 

	
let rec get_number1 (var_name:string) (index:int) lst : int =
    match lst with
    | [] -> 
        raise Not_found
    | h::t -> if var_name = h then index
              else get_number1 var_name (index+1) t
	
let rec get_anno_param (params:var_decl3_new list) (alloc:(string*int) list) spill_list 
    : reg_or_mem list =
    match params with
    | [] -> []
    | (_, id3)::t ->
            let (str, _) = id3 in
        try
            let (_, reg_id) =  List.find (fun (x, _) -> str = x) alloc in
            (Ir3_structs_new.Reg ("__R"^string_of_int(reg_id)))::get_anno_param t alloc spill_list
        with Not_found ->
			try
		    let number = get_number1 str 0 spill_list in
            (Mem ("__M"^string_of_int(number)))::get_anno_param t alloc spill_list
			with Not_found ->
			(Ir3_structs_new.Reg ("dead"))::get_anno_param t alloc spill_list
            
let assign_register md reg_alloc spill_list =
    let updated_ir3stmts = assign_register_stmts md.ir3stmts reg_alloc spill_list in
    let anno_param_list = get_anno_param md.params3 reg_alloc spill_list in
    { 
      id3=md.id3; 
      rettype3=md.rettype3; 
      params3=md.params3; 
      localvars3=md.localvars3; 
      ir3stmts=updated_ir3stmts;
      stacksize=((List.length spill_list)*4 + 24);
      anno_param3=anno_param_list
    }
