open Ir3_structs_new

let find_copy var_name table_of_copies =
    try
        let copy_entry = List.find
            (fun l -> List.mem var_name l)
            table_of_copies in
        List.hd copy_entry
    with
        Not_found ->
            var_name

let update_idc3 idc3 table_of_copies =
    match idc3 with
    | Var3_new (var_name, reg_or_mem) ->
        let new_var_name =
            find_copy var_name table_of_copies in
        Var3_new (new_var_name, reg_or_mem)
    | other_idc3 ->
        other_idc3

let update_exp exp table_of_copies =
    match exp with
    | BinaryExp3_new (op, idc3_1, idc3_2) ->
        let new_idc3_1 = update_idc3 idc3_1 table_of_copies in
        let new_idc3_2 = update_idc3 idc3_2 table_of_copies in
        BinaryExp3_new (op, new_idc3_1, new_idc3_2)
    | UnaryExp3_new (op, idc3_1) ->
        let new_idc3_1 = update_idc3 idc3_1 table_of_copies in
        UnaryExp3_new(op, new_idc3_1)
    | Idc3Expr_new (idc3_1) ->
        let new_idc3_1 = update_idc3 idc3_1 table_of_copies in
        Idc3Expr_new (new_idc3_1)
    | other_exp ->
        other_exp

let update_stmt stmt table_of_copies =
    match stmt with
    | AssignStmt3_new (assignee, exp) ->
        let updated_exp = update_exp exp table_of_copies in
        AssignStmt3_new (assignee, updated_exp)
    | other_stmt ->
        stmt
        
let update_table_of_copies stmt table_of_copies =
    match stmt with
    | AssignStmt3_new ((assignee_name, _), expr) ->
        let rec remove_helper table_of_copies =
            match table_of_copies with
            | [] ->
                []
            | entry::tail_list ->
                if (List.mem assignee_name entry) then
                    let updated_entry =
                        List.filter (fun x -> x <> assignee_name) entry in
                    updated_entry::tail_list
                else
                    entry::(remove_helper tail_list)
        in
        let updated_table_of_copies = remove_helper table_of_copies in
        begin
        match expr with
        | Idc3Expr_new (Var3_new (var_name, _)) ->
            let rec add_helper table_of_copies =
                match table_of_copies with
                | [] ->
                    [(var_name::[assignee_name])]
                | entry::tail_list ->
                    if (List.mem var_name entry) then
                        (entry@[assignee_name])::tail_list
                    else
                        entry::(add_helper tail_list)
            in
            add_helper updated_table_of_copies
        | _ ->
            updated_table_of_copies
        end
    | _ ->
        table_of_copies

let copy_propagation_elimination stmts =
    let rec cpe_helper stmts table_of_copies =
        match stmts with
        | [] ->
            []
        | stmt::tail_list ->
            let updated_stmt =
                update_stmt stmt table_of_copies in
            let updated_table =
                update_table_of_copies stmt table_of_copies in
            let tail_stmts = cpe_helper tail_list updated_table in
            (updated_stmt::tail_stmts)
    in
    cpe_helper stmts []