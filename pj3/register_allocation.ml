(*
   An implementation of Chaitin-Briggs graph colouring
   algorithm with optimistic colouring to perform
   register allocation
*)

let is_connected edges nodes node1 node2 =
    if (List.mem node1 nodes) && (List.mem node2 nodes)
        && (node1 <> node2) then
        let (_, connected_nodes) = List.find
            (fun (node, _) -> node = node1) edges in
        List.mem node2 connected_nodes
    else
        false

let get_neighbours edges nodes node =
    List.find_all
        (fun node2 -> is_connected edges nodes node node2)
        nodes

let compute_degree edges nodes node =
    let neighbours = get_neighbours edges nodes node in
    List.length neighbours

let simplify num_reg edges nodes =
    let rec simplify_helper nodes stack =
        match nodes with
        | [] ->
            stack
        | head::_ ->
            let node =
                try
                    List.find
                        (fun node -> compute_degree edges
                            nodes node < num_reg)
                        nodes
                with
                    Not_found ->
                        (* Optimistic colouring *)
                        head
            in
            let new_stack = node::stack in
            let new_nodes = List.filter
                (fun node2 -> node <> node2) nodes in
            simplify_helper new_nodes new_stack
    in
    let stack = [] in
    simplify_helper nodes stack

let rec get_assigned_reg node assign_result =
    match assign_result with
    | [] ->
        (-1)
    | (node_in_list, reg)::tail_list ->
        if ( node = node_in_list) then
            reg
        else
            get_assigned_reg node tail_list

let assign_register num_reg edges nodes node assign_result =
    let new_nodes = node::nodes in
    let neighbours = get_neighbours edges new_nodes node in
    let used_regs = List.map
        (fun node -> get_assigned_reg node assign_result)
        neighbours in
    let rec find_free_reg_helper current_attempt =
        if current_attempt = num_reg then
            (-1)
        else
            if List.mem current_attempt used_regs then
                find_free_reg_helper (current_attempt + 1)
            else
                current_attempt
    in
    find_free_reg_helper 0

let select num_reg edges stack =
    let rec select_helper nodes stack assign_result spill_candidate=
        match stack with
        | [] ->
            (assign_result, spill_candidate)
        | node::tail_list ->
            let reg = assign_register num_reg edges
                nodes node assign_result in
            let new_stack = tail_list in
            if ( reg <> -1 ) then
                let new_nodes = node::nodes in
                let new_assign_result = (node, reg)::assign_result in
                select_helper new_nodes new_stack new_assign_result spill_candidate
            else
                let new_spill_candidate = node::spill_candidate in
                select_helper nodes new_stack assign_result new_spill_candidate
    in
    let nodes = [] in
    let assign_result = [] in
    let spill_candidate = [] in
    select_helper nodes stack assign_result spill_candidate

let spill nodes spill_candidate costs =
    let get_node_cost_helper node =
        let (_, cost) = List.find
            (fun (node_in_list, _) -> node = node_in_list)
            costs in
        cost
    in
    let rec get_minimum_cost_node_helper node_list =
        match node_list with
        | [] ->
            failwith ("Empty node_list in get_minimum_cost_node_helper")
        | last_node::[] ->
            last_node
        | node::tail_list ->
            let min_cost_node_tail =
                get_minimum_cost_node_helper tail_list in
            if (get_node_cost_helper node)
                < (get_node_cost_helper min_cost_node_tail) then
                node
            else
                min_cost_node_tail
    in
    let node_to_spill = get_minimum_cost_node_helper spill_candidate in
    let new_nodes = List.filter
        (fun node -> node <> node_to_spill)
        nodes in
    (node_to_spill, new_nodes)

(*
The main function of register allocation.
- : int ->
    (int * int list) list -> (int * 'a) list -> (int * int) list * int list
= <fun>
*)
let register_allocation num_reg edges costs =
    let rec register_allocation_helper nodes spill_list =
        let stack = simplify num_reg edges nodes in
        let (assign_result, spill_candidate) =
            select num_reg edges stack in
        match spill_candidate with
        | [] ->
            (assign_result, spill_list)
        | _ ->
            let (spilled_node, new_nodes) =
                spill nodes spill_candidate costs in
            let new_spill_list = spilled_node::spill_list in
            register_allocation_helper new_nodes new_spill_list
        in
        let nodes = List.map (fun (node, _) -> node) edges in
        let spill_list = [] in
        register_allocation_helper nodes spill_list

(* This is a sample input *)
let num_reg_input = 4

let edges_input = [(0, [1;2;3;4;5]);
                   (1, [0;2;3;5])  ;
                   (2, [0;1;3;4;5]);
                   (3, [0;1;2;4;5]);
                   (4, [0;2;3;5])  ;
                   (5, [0;1;2;3;4]);]

let costs_input = [(0, 14.5);
                   (1, 6.4 );
                   (2, 97.1);
                   (3, 20.5);
                   (4, 25.5);
                   (5, 4.3 );]
(* End of Sample Input *)
