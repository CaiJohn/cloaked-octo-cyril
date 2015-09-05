open Ir3_structs_new
module  Liveness_Set = Set.Make(String)

(* map from line number to the list of line number that can be the next statement *)
(* It needs initializing by initial_next_statement_tbl*)
let next_statement_tbl = Hashtbl.create 10000 (* index:int -> int list*)
(* map from line number to the set of live var *)
(*It needs initializing by initial_liveness_information_tbl *)
let liveness_information_tbl = Hashtbl.create 10000 (* index:int -> Set *)


let get_l_set
	(index:int):Liveness_Set.t=
	try
		Hashtbl.find liveness_information_tbl index
	with Not_found ->
	 	Liveness_Set.empty



let string_of_string_set 
	(input_set:Liveness_Set.t):string =
	Liveness_Set.fold (fun elt s -> s^" "^elt) input_set ""

let string_of_int_list
	(input_list:int list):string =
	List.fold_left (fun s i -> s^" "^(string_of_int i)) "" input_list

let string_of_liveness_information_tbl
	():string =
		let length = Hashtbl.length liveness_information_tbl in
		let rec helper
			(counter:int):string=
			if counter=length then ""
			else
				try
					"\nline: "^(string_of_int counter)^" ["^(string_of_string_set (get_l_set counter))^" ]\n"^(helper (counter+1))
				with Not_found -> failwith "string_of_liveness_information_tbl"
		in
		helper 0 

let string_of_indexed_ir3_stmt_new_list
	(stmt_list:ir3_stmt_new list):string =
	let counter = ref 0 in
	List.fold_left 	(
						fun s stmt -> 	let _ = counter := !counter + 1 in
										s^"\n\n"^"## line "^(string_of_int (!counter-1))^"\n"^(string_of_ir3_stmt_new stmt)
					) "" stmt_list

let string_of_next_statement_tbl
	():string =
	Hashtbl.fold (fun index lst s -> s^"\n"^"line: "^(string_of_int index)^" ["^(string_of_int_list lst)^" ]\n") next_statement_tbl ""

let updated_tag = ref false

(* Given a list of stmtments and a label, return while line this label is in *)
let get_label_index
	(stmt_list:ir3_stmt_new list) (label:int):int=
	let rec helper
		(stmt_list:ir3_stmt_new list) (label:int) (counter:int):int =
		match stmt_list with
		| h::rest ->
			begin
				match h with
				| Label3_new l ->
					if l = label then counter else helper rest label (counter+1)
				| _ -> helper rest label (counter+1)
			end
		| [] -> failwith ("get_label_index: Cannot find label "^(string_of_int label))
	in
	helper stmt_list label 0

let get_id_from_id3
	(input:idc3_new):string option=
	match input with
	| Var3_new aux_id -> 
		begin
			match aux_id with
			| (id,_)->  Some id
		end
	| _ -> None



(* Given a list of line index, return the union set of liveness var in these lines *)
let collect_l_set
	(index_list:int list):Liveness_Set.t=
	List.fold_left (fun set index -> Liveness_Set.union set (get_l_set index))  Liveness_Set.empty index_list

let get_l_post_set
	(index:int):(Liveness_Set.t)=
	collect_l_set (Hashtbl.find next_statement_tbl index)

let get_idc3_var_list
	(input:idc3_new):string list=
	match input with
	| Var3_new (id,_)-> [id]
	| _ -> []


let expr_var_set
	(e:ir3_exp_new):Liveness_Set.t=
	let helper
		(e:ir3_exp_new):string list=
		match e with
		| BinaryExp3_new (_,idc1,idc2) -> (get_idc3_var_list idc1)@(get_idc3_var_list idc2)
		| UnaryExp3_new (_,id) -> (get_idc3_var_list id)
		| FieldAccess3_new ((id1,_),(id2,_))->[id1]
		| Idc3Expr_new id -> get_idc3_var_list id
		| MdCall3_new (_,lst) -> List.fold_left (fun result idc3-> (get_idc3_var_list idc3)@result) [] lst 
		| ObjectCreate3_new _ -> []
	in
	List.fold_left (fun set v->Liveness_Set.add v set) Liveness_Set.empty (helper e)


let rec initial_next_statement_tbl
	(stmt_list:ir3_stmt_new list)=
	(* stmt_list_reserve stay unchanged. Just for searching label*)
	let rec helper
		(stmt_list_reserve:ir3_stmt_new list) (stmt_list:ir3_stmt_new list) (counter:int)=
		match stmt_list with
		| h::[] ->
			(* let _ = print_endline "initial_next_statement_tbl h::[]" in *)
			begin
				match h with
				| IfStmt3_new (_,l) ->
					Hashtbl.add next_statement_tbl counter ((get_label_index stmt_list_reserve l)::[-1])
				| GoTo3_new l ->
					Hashtbl.add next_statement_tbl counter [(get_label_index stmt_list_reserve l)]
				| _ -> 
					Hashtbl.add next_statement_tbl counter [-1]
			end
		| h::rest ->
			begin
				match h with
				| IfStmt3_new (_,l) ->
					Hashtbl.add next_statement_tbl counter ((get_label_index stmt_list_reserve l)::[counter+1]);
					helper stmt_list_reserve rest (counter+1)
				| GoTo3_new l ->
					Hashtbl.add next_statement_tbl counter [(get_label_index stmt_list_reserve l)];
					helper stmt_list_reserve rest (counter+1)
				| _ -> 
					Hashtbl.add next_statement_tbl counter [(counter+1)];
					helper stmt_list_reserve rest (counter+1)
			end
		(*| [] -> failwith "initial_next_statement_tbl: Empty stmt list"*)
		| [] -> ()
	in
	(*Hashtbl.reset next_statement_tbl;*)
	helper stmt_list stmt_list 0

let rec calc_fix_point
	(stmt_list:ir3_stmt_new list)=
	let process_one_stmt
		(stmt:ir3_stmt_new)(counter:int):(Liveness_Set.t)=
		let l_set_old = get_l_set counter in
		let l_set_input =
			try
				collect_l_set (Hashtbl.find next_statement_tbl counter) 
			with Not_found -> failwith "calc_fix_point"
		in
		let l_set_new =
			match stmt with
			| IfStmt3_new (e,_)->
				Liveness_Set.union l_set_input (expr_var_set e)
			| AssignStmt3_new ((id,_),e) ->
				Liveness_Set.union (Liveness_Set.remove id l_set_input) (expr_var_set e)
			| ReadStmt3_new ((id,_)) ->
				Liveness_Set.add id l_set_input
			| PrintStmt3_new (id3) ->
				let id = get_id_from_id3 id3 in
				begin
					match id with
					| Some i ->
						Liveness_Set.add i l_set_input
					| None ->
						l_set_input
				end
			| ReturnStmt3_new (id,_)->
				Liveness_Set.add id l_set_input
			| LD (t,_) ->
				Liveness_Set.remove t l_set_input
			| ST (_,t) ->
				Liveness_Set.add t l_set_input
			| MdCallStmt3_new e->
				Liveness_Set.union l_set_input (expr_var_set e)
			| AssignFieldStmt3_new (e1,e2) ->
				Liveness_Set.union l_set_input (Liveness_Set.union (expr_var_set e1) (expr_var_set e2))
			| _ ->
				l_set_input
		in
		if Liveness_Set.equal l_set_new l_set_old 
		then l_set_new
		else
			let _ = updated_tag := true in
			l_set_new
			
	in
	let rec process_stmts
		(stmt_list:ir3_stmt_new list)(counter:int):bool =
		match stmt_list with
		| h::rest ->
			let l_set_new = process_one_stmt h counter in
			let _ = Hashtbl.replace liveness_information_tbl counter l_set_new in
			process_stmts rest (counter+1)
		| [] -> !updated_tag
	in
	if process_stmts stmt_list 0
	then
		let _ = updated_tag := false in
		(* let _ = print_endline "calc_fix_point: true branch" in *)
		calc_fix_point stmt_list
	else liveness_information_tbl 


(* Initialize next_statement_tbl and liveness_information_tbl *)
(* After initialization, liveness_information_tbl is empty *)
let liveness_analysis_initialize
	(stmt_list:ir3_stmt_new list)=
	let _ = initial_next_statement_tbl stmt_list in
	Hashtbl.reset liveness_information_tbl

let liveness_analysis_for_meth
	(input:md_decl3_new)=
	match input with
	| {id3=_; rettype3=_; params3=_; localvars3=_; ir3stmts=stmtlst}->
		let _ = liveness_analysis_initialize stmtlst in
		calc_fix_point stmtlst

let test
	(input:ir3_program_new) =
	match input with
	| (_,m,mlst) ->
		let _ =liveness_analysis_initialize m.ir3stmts in
		(*let _ = print_endline (string_of_next_statement_tbl ()) in*)
		let _ = print_endline (string_of_indexed_ir3_stmt_new_list m.ir3stmts) in 
		(*let _ = print_endline (string_of_int_list (Hashtbl.find next_statement_tbl 1)) in*)
		let _ = calc_fix_point m.ir3stmts in
		let _ = print_endline (string_of_liveness_information_tbl ()) in
		()

let rec string_of_coloring_matrix
	(input:(string*(string list)) list):string=
	let rec string_of_string_list
		(i:string list) : string=
		match i with
		| h::rest -> "[ "^h^(string_of_string_list rest)^" ]"
		| []->""
	in
	match input with
	| (key,valuelst)::rest -> key^" "^(string_of_string_list valuelst)^"\n"^(string_of_coloring_matrix rest)
	| [] -> "" 

let get_coloring_matrix
	(stmtlst:ir3_stmt_new list):(string*(string list)) list=
	(* var_liveness_tbl contains edge for registration allocation *)
	let var_liveness_tbl = Hashtbl.create 10000 in (* string -> string list *)
	let get_var_liveness_tbl
		(index:string):string list=
		try
			Hashtbl.find var_liveness_tbl index
		with Not_found->
			[]
	in
	let rec no_duplicate_combine
		(lst1:string list)(lst2:string list):string list =
		match lst1 with
		| h::rest -> if List.mem h lst2 then no_duplicate_combine rest lst2 else h::(no_duplicate_combine rest lst2)
		| [] -> lst2
	in
	let get_edge_set_list
		(stmtlst:ir3_stmt_new list):(Liveness_Set.t list)=
		let rec add_define_edge
			(stmtlst:ir3_stmt_new list) (counter:int)(lst:Liveness_Set.t list):(Liveness_Set.t list)=
			(*let _ = print_endline ("Length of stmt list "^(string_of_int (List.length stmtlst))) in*)
			match stmtlst with
			| h::rest->
				(*let _ = print_endline ("add_define_edge "^(string_of_ir3_stmt_new h)) in*)
				begin
					match h with
					| AssignStmt3_new ((id,_),e) -> (*let _ = print_endline ("AssignStmt3_new: id "^id) in *)
							add_define_edge rest (counter+1) ((Liveness_Set.add id (get_l_post_set counter))::lst)
					| _ -> add_define_edge rest (counter+1) ((get_l_post_set counter)::lst)
				end
			| [] -> lst
		in
		let init_lst = Hashtbl.fold (fun key value lst-> value::lst) liveness_information_tbl [] in
		add_define_edge stmtlst 0 init_lst
	in
	(* Build up var_liveness_tbl from liveness information *)
	let helper
		(input:Liveness_Set.t)=
		let mk_rest_list
			(s:Liveness_Set.t)(target:string):string list=
			Liveness_Set.fold (fun elt lst-> if elt=target then lst else elt::lst) s []
		in
		Liveness_Set.iter (fun elt -> Hashtbl.replace var_liveness_tbl elt (no_duplicate_combine (get_var_liveness_tbl elt) (mk_rest_list input elt))) input
	in
	let _ = List.iter (fun set -> helper set) (get_edge_set_list stmtlst)  in
	Hashtbl.fold (fun key value lst -> (key,value)::lst) var_liveness_tbl []
	(*let _ = Hashtbl.iter (fun key value -> helper value) liveness_information_tbl in
	Hashtbl.fold (fun key value lst -> (key,value)::lst) var_liveness_tbl []*)

let fake_cost graph =
    List.map
        (fun (node, _) -> (node, 1))
        graph

let calc_cost
	(stmtlst:ir3_stmt_new list) (graph:(string*(string list)) list):(string*int) list=
	let var_usage_number = Hashtbl.create 10000 (*string -> int *)
	in
	let get_var_usage_number
		(index:string):int =
		try
			Hashtbl.find var_usage_number index
		with Not_found->
			0
	in
	let rec helper
		(stmtlst:ir3_stmt_new list)=
		match stmtlst with
		| h::rest ->
			let _ =
				begin
					match h with
					| IfStmt3_new (e,_)->
						Liveness_Set.iter (fun elt-> Hashtbl.replace var_usage_number elt ((get_var_usage_number elt)+1)) (expr_var_set e) 
					| AssignStmt3_new ((id,_),e) ->
						let _ = Liveness_Set.iter (fun elt-> Hashtbl.replace var_usage_number elt ((get_var_usage_number elt)+1)) (expr_var_set e) in
						Hashtbl.replace var_usage_number id ((get_var_usage_number id)+1)
					| ReadStmt3_new ((id,_)) ->
						Hashtbl.replace var_usage_number id ((get_var_usage_number id)+1)
					| PrintStmt3_new (id3) ->
						let id = get_id_from_id3 id3 in
						begin
							match id with
							| Some i -> 
								Hashtbl.replace var_usage_number i ((get_var_usage_number i)+1)
							| None ->
								()
						end
					| ReturnStmt3_new (id,_)->
						Hashtbl.replace var_usage_number id ((get_var_usage_number id)+1)
					| LD (t,_) ->
						()
					| ST (_,t) ->
						Hashtbl.replace var_usage_number t ((get_var_usage_number t)+1)
					| _ ->
						()
				end
			in
			helper rest
		| [] -> ()
	in
	let _ = helper stmtlst in
	List.map (fun (key, lst)-> 
				let used_time = get_var_usage_number  key in 
				let edges_number = (List.length lst) in
				(*let _ = print_endline ("var: "^key^" used time: "^(string_of_int used_time)^" edge number: "^(string_of_int edges_number)) in*)
				if edges_number=0 then (key,0) else (key,used_time/edges_number)) graph



let liveness_analysis
	(input :ir3_stmt_new list) =
	let _ = liveness_analysis_initialize input in
	let _ = calc_fix_point input in
	(*let _ = print_endline (string_of_liveness_information_tbl ()) in*)
    let graph = get_coloring_matrix input in
    let costs = calc_cost input graph in
    (*let _ = print_endline "==========indexed ir3 new stmt list=======================" in*)
    (*let _ = print_endline (string_of_indexed_ir3_stmt_new_list input) in*)
    (*let _ = print_endline "==========End of indexed ir3 new stmt list================" in*)
    (* let _ = print_endline (string_of_liveness_information_tbl ()) in  *)
(*     let _ = print_endline "===============coloring matrix============================" in
    let _ = print_endline (string_of_coloring_matrix graph) in
 *)    (graph, costs)

(*
let test2
	(input:ir3_program_new) =
	match input with
	| (_,m,mlst) ->
		let result = liveness_analysis m.ir3stmts in
		let _ = print_endline (string_of_coloring_matrix result) in
		()
*)


let rec dead_code_elimination_fixpoint
	(stmtlst:ir3_stmt_new list):(ir3_stmt_new list)=
	let rec dead_code_elimination
		(stmtlst:ir3_stmt_new list):(ir3_stmt_new list)=
		let rec helper
			(stmt:ir3_stmt_new)(counter:int):bool=
			match stmt with
			| AssignStmt3_new ((id,_),exp) ->
				begin
					match exp with
					| MdCall3_new _ -> true
					| _ ->	Liveness_Set.mem id (get_l_post_set counter)
				end
			| _ -> true
		in
		let rec helperlst
			(stmtlst:ir3_stmt_new list)(counter:int):(ir3_stmt_new list)=
			match stmtlst with
			| h::rest -> if (helper h (counter)) then h::(helperlst rest (counter+1)) else (helperlst rest (counter+1))
			| [] -> []
		in
		helperlst stmtlst 0
	in
	let liveness_analysis_for_dead_code_elimination
		(input:ir3_stmt_new list)=
		let _ = liveness_analysis_initialize input in
		let _ = calc_fix_point input in
		(*let _ = print_endline "########## liveness analysis for dead code elimination ##########" in*)
		(*let _ = print_endline (string_of_liveness_information_tbl ()) in*)
		()
	in
	let compare_stmt_lst
		(stmtlst1:ir3_stmt_new list)(stmtlst2:ir3_stmt_new list):bool=
		if (List.length stmtlst1)=(List.length stmtlst2) then true else false
	in
	(*** The execution part of this function ***)
	(*let _ = print_endline ("######## dead_code_elimination input ########"^(string_of_indexed_ir3_stmt_new_list stmtlst)) in*)
	let _ = liveness_analysis_for_dead_code_elimination stmtlst in
	let new_stmtlst = dead_code_elimination stmtlst in
	(*let _ = print_endline ("######## dead_code_elimination output ########"^(string_of_indexed_ir3_stmt_new_list new_stmtlst)) in*)
	if compare_stmt_lst new_stmtlst stmtlst 
	then new_stmtlst
	else dead_code_elimination_fixpoint new_stmtlst


let dead_code_elimination_for_meth
	(m:md_decl3_new):(md_decl3_new)=
	{m with ir3stmts=(dead_code_elimination_fixpoint (m.ir3stmts))}

let dead_code_elimination_for_prog
	((c3,m3,m3lst):ir3_program_new):(ir3_program_new)=
	let rec helper_m3lst
		(m3lst:md_decl3_new list):(md_decl3_new list)=
		match m3lst with
		| h::rest -> (dead_code_elimination_for_meth h)::(helper_m3lst rest)
		| [] -> []
	in
	(c3,(dead_code_elimination_for_meth m3),(helper_m3lst m3lst))