open Ir3_structs_new
open Ir3_bbl_generator 

let cse_varcount = ref 0
(* unit -> string = <fun> *)
(* Generate a new temp variable *)
let fresh_cse_var() =
    (cse_varcount:=!cse_varcount+1;
    (string_of_int !cse_varcount))

let bbl_lookup_tbl = Hashtbl.create 50
let in_common_exp_list_tbl = Hashtbl.create 50
let out_common_exp_list_tbl = Hashtbl.create 50
let common_exp_var_tbl = Hashtbl.create 500

let get_var_for_common_exp exp prefix = 
    try
        Hashtbl.find common_exp_var_tbl exp
    with
        Not_found ->
            let variable_name = prefix ^ fresh_cse_var() in
            let variable = (variable_name, (Reg "!!!UNSET")) in
            let _ = Hashtbl.add common_exp_var_tbl exp variable in
            variable

let add_new_exp_to_list exp_list exp =
    match exp with
    | BinaryExp3_new _
    | UnaryExp3_new _ ->
        if (List.mem exp exp_list) then
            (true, exp_list, false)
        else
            let new_common_exp_list = exp::exp_list in
            (true, new_common_exp_list, true)
    | _ ->
        (false, exp_list, false)
        
let is_same_var var1 var2 =
    var1 = var2
            
let is_var_used_in_exp var_idc3 exp =
    match exp with
    | BinaryExp3_new (_, var1, var2) ->
        if ((is_same_var var_idc3 var1) || (is_same_var var_idc3 var2)) then
            true
        else
            false
    | UnaryExp3_new (_, var1) ->
        if (is_same_var var_idc3 var1) then
            true
        else
            false
    | _ ->
        failwith ("Unrecognised expression type in the list")
        
let remove_exp_from_list exp_list defined_var =
    let defined_var_idc3 = Var3_new defined_var in
    List.filter
        (fun x -> is_var_used_in_exp defined_var_idc3 x = false)
        exp_list
        
let get_bbl id =
    Hashtbl.find bbl_lookup_tbl id

let initialize_hash_tbls t =
    begin
        Hashtbl.reset bbl_lookup_tbl;
        Hashtbl.reset in_common_exp_list_tbl;
        Hashtbl.reset out_common_exp_list_tbl;
        Hashtbl.clear common_exp_var_tbl;
    end


let initialize_block_mapping id bbl =
        Hashtbl.add bbl_lookup_tbl id bbl

let list_intersect l1 l2 =
    List.filter (fun x -> List.mem x l2) l1
    
let optimize_stmts common_exp_list stmts =
    let rec helper common_exp_list stmts =
        match stmts with
        | [] ->
            []
        | stmt::tail_list ->
            let (updated_stmts, updated_common_exp_list) =
                match stmt with
                | AssignStmt3_new (assignee, exp) ->
                    let (is_valid, updated_exp_list, is_new_exp) = add_new_exp_to_list common_exp_list exp in
                    let updated_exp_list = remove_exp_from_list updated_exp_list assignee in
                    if (is_valid) then
                        let variable = get_var_for_common_exp exp "_cse_l" in
                        if (is_new_exp) then
                            let assignee_exp = Idc3Expr_new (Var3_new assignee) in
                            let assign_stmt = AssignStmt3_new (variable, assignee_exp) in
                            (stmt::[assign_stmt], updated_exp_list)
                        else
                            let updated_stmt = AssignStmt3_new (assignee, Idc3Expr_new (Var3_new variable)) in
                            ([updated_stmt], updated_exp_list)
                    else
                        [stmt], updated_exp_list
                | _ ->
                    [stmt], common_exp_list
            in
            let tail_stmts = helper updated_common_exp_list tail_list in
            updated_stmts@tail_stmts
    in
    helper common_exp_list stmts
    
let optimize_bbl bbl =
    let common_exp_list =
        try
            Hashtbl.find in_common_exp_list_tbl bbl.id
        with
            Not_found ->
                []
    in
    optimize_stmts common_exp_list bbl.stmts
    
let rec discover_bbl (bbls:Ir3_bbl_generator.md_bbls) bbl in_common_exp_list =
    let (update_required, common_exp_list) =
        if (Hashtbl.mem in_common_exp_list_tbl bbl.id) then
            let original_in_common_exp_list = Hashtbl.find in_common_exp_list_tbl bbl.id in
            if (in_common_exp_list <> original_in_common_exp_list) then
                let updated_common_exp_list = list_intersect in_common_exp_list original_in_common_exp_list in
                let _ = Hashtbl.replace in_common_exp_list_tbl bbl.id updated_common_exp_list in
                (true, updated_common_exp_list)
            else
                (false, in_common_exp_list)
        else
            let _ = Hashtbl.add in_common_exp_list_tbl bbl.id in_common_exp_list in
            (true, in_common_exp_list)
    in
    if (update_required) then
        let rec discover_bbl_helper common_exp_list stmts =
            match stmts with
            | [] ->
                common_exp_list
            | stmt::tail_list ->
                match stmt with
                | AssignStmt3_new (assignee, exp) ->
                    let (_, updated_exp_list, _) = add_new_exp_to_list common_exp_list exp in
                    let updated_exp_list = remove_exp_from_list updated_exp_list assignee in
                    discover_bbl_helper updated_exp_list tail_list
                | _ ->
                    discover_bbl_helper common_exp_list tail_list
        in
        let out_common_exp_list = discover_bbl_helper common_exp_list bbl.stmts in
        let out_common_exp_changed = 
            try 
                let original_out_common_exp_list = Hashtbl.find out_common_exp_list_tbl bbl.id in
                out_common_exp_list <> original_out_common_exp_list
            with 
                Not_found ->
                    true
        in
        if (out_common_exp_changed) then
            let _ = Hashtbl.replace out_common_exp_list_tbl bbl.id out_common_exp_list in
            let next_bbls = Hashtbl.find_all bbls.next_bbls_htbl bbl.id in
            List.iter (fun x -> discover_bbl bbls (get_bbl x) out_common_exp_list) next_bbls
        else
            ()
    else
        ()
        

let discover_bbls (bbls:Ir3_bbl_generator.md_bbls) =
    let _ = initialize_hash_tbls () in
    let _ = List.iter (fun x -> initialize_block_mapping x.id x) bbls.ir3bbls in
    discover_bbl bbls (List.hd bbls.ir3bbls) []
    
let global_common_subexp_elimination stmts =
    (*let _ = print_endline ("Discover new method") in*)
    let bbls = ir3_stmts_to_bbls stmts in
    let _ = discover_bbls bbls in
    let assign_new_cse_var_list exp_list prefix =
        List.iter
        (fun exp ->
            let _ = get_var_for_common_exp exp prefix in
            ()
        )
        exp_list
    in
    let _ = Hashtbl.iter
        (fun _ exp_list -> assign_new_cse_var_list exp_list "_cse_g")
        in_common_exp_list_tbl 
    in
    let _ = Hashtbl.iter
        (fun _ exp_list -> assign_new_cse_var_list exp_list "_cse_g")
        out_common_exp_list_tbl 
    in
    (*
    let _ = List.iter
        (fun x ->
            let id = x.id in
            let _ = print_endline ("Block " ^ (string_of_int id) ^ "\n======== In List =======") in
            let lst = 
                try
                    Hashtbl.find in_common_exp_list_tbl id
                with
                    Not_found ->
                        let _ = print_endline ("Uninitialized") in
                        []
            in
            let _ = print_endline (string_of_list lst string_of_ir3_exp_new "\n") in
            let _ = print_endline("======== Out List =======") in
            let lst = 
                try
                    Hashtbl.find out_common_exp_list_tbl id
                with
                    Not_found ->
                        let _ = print_endline ("Uninitialized") in
                        []
            in
            let _ = print_endline (string_of_list lst string_of_ir3_exp_new "\n" )in
            ()
        )
        bbls.ir3bbls
    in
    let _ = print_endline ("========= Name List ==========") in
    let _ = Hashtbl.iter
        (fun exp (var_name, _) ->
            print_endline ((string_of_ir3_exp_new exp) ^ " -> " ^ var_name))
        common_exp_var_tbl
    in
    *)
    let stmts_list = List.map optimize_bbl bbls.ir3bbls in
    List.flatten stmts_list

(* Internal Test Propose only, don not use *)
let global_common_subexp_elimination_prog ir3_prog_new =
    let (cdata, main_md_decl, md_decls) = ir3_prog_new in
    let optimized_main_md_decl = {main_md_decl with ir3stmts = (global_common_subexp_elimination main_md_decl.ir3stmts)} in
    let optimized_md_decls = List.map (fun x -> {x with ir3stmts = (global_common_subexp_elimination x.ir3stmts)}) md_decls in
    (cdata, optimized_main_md_decl, optimized_md_decls)
