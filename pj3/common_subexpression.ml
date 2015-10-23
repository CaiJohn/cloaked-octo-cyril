open Ir3_structs_new

let cse_varcount = ref 0
(* unit -> string = <fun> *)
(* Generate a new temp variable *)
let fresh_cse_var() =
    (cse_varcount:=!cse_varcount+1;
    (string_of_int !cse_varcount))

let common_subexp_elimination stmts =
    let add_new_exp_to_list exp_list exp =
        let is_same_exp exp1 exp2 =
            exp1 = exp2
        in
        try
            let entry = List.find
                (fun (exp2, _) -> is_same_exp exp exp2) exp_list in
            let (_, variable) = entry in
            (exp_list, false, variable)
        with
            Not_found ->
                let variable_name = "_cse" ^ fresh_cse_var() in
                let variable = (variable_name, (Reg "!!!Unset")) in
                let new_common_exp_list = exp_list@[(exp, variable)] in
                (new_common_exp_list, true, variable)
    in
    let remove_exp_from_list exp_list defined_var =
        let is_same_var var1 var2 =
            var1 = var2
        in
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
                false
        in
        let defined_var_idc3 = Var3_new defined_var in
        List.filter
            (fun (exp, _) -> is_var_used_in_exp defined_var_idc3 exp = false)
            exp_list
    in
    let rec cse_helper stmts common_exp_list =
        match stmts with
        | [] ->
            []
        | stmt::tail_list ->
            let (updated_stmts, updated_common_exp_list) =
                match stmt with
                | AssignStmt3_new (assignee, exp) ->
                    let (updated_stmts, updated_common_exp_list) =
                        match exp with
                        | BinaryExp3_new _
                        | UnaryExp3_new _ ->
                            let (updated_common_exp_list, is_new_exp, variable) =
                                add_new_exp_to_list common_exp_list exp in
                            if (is_new_exp) then
                                let assignee_exp = Idc3Expr_new (Var3_new assignee) in
                                let assign_stmt = AssignStmt3_new (variable, assignee_exp) in
                                (stmt::[assign_stmt], updated_common_exp_list)
                            else
                                let updated_stmt = AssignStmt3_new (assignee,
                                    Idc3Expr_new (Var3_new variable)) in
                                ([updated_stmt], updated_common_exp_list)
                        | _ ->
                            [stmt], common_exp_list
                    in
                    let updated_common_exp_list =
                        remove_exp_from_list updated_common_exp_list assignee in
                    updated_stmts, updated_common_exp_list
                | _ ->
                    [stmt], common_exp_list
            in
            let tail_stmts = cse_helper tail_list updated_common_exp_list in
            updated_stmts@tail_stmts
    in
    cse_helper stmts []
