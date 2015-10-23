open Ir3_structs_new
open Ir3_bbl_generator
open Assign_register
open Arm_structs

let ldr_str_loop_flag = ref true

let rec filter_reg inlst reg : (string*string) list =
  match inlst with
  | [] -> []
  | (in_reg,in_offset)::rest -> 
    let outlst = filter_reg rest reg in   
    if reg=in_reg then outlst 
    else (in_reg,in_offset)::outlst 

let rec filter_offset inlst offset : (string*string) list =
  match inlst with
  | [] -> []
  | (in_reg,in_offset)::rest ->
    let outlst = filter_offset rest offset in
    if offset=in_offset then outlst
    else (in_reg,in_offset)::outlst 

let rec combineLsts lst1 lst2 = 
  match lst1 with
  | [] -> [] 
  | entry::rest -> 
    let helper e = (e=entry) in
    if List.exists helper lst2 then (List.find helper lst2)::(combineLsts rest lst2) 
    else combineLsts rest lst2 

let ldr_str_opt_bbl (bbl: ir3_bbl) (inlst: (string*string) list) : ir3_bbl*(string*string) list =
  let rec opt_stmts stmts inlst : ir3_stmt_new list*(string*string) list = 
    let opt_rest_stmts stmt rest new_inlst =
      let (new_stmts,outlst) = opt_stmts rest new_inlst in
      (stmt::new_stmts,outlst) in
    match stmts with
    | [] -> ([],inlst)
    | stmt::rest -> 
      begin
        match stmt with
        | LD (r,m) -> 
          let reg = Assign_register.convert r in
          let offset = Assign_register.convert m in
          if List.exists (fun entry -> entry=(reg,offset)) inlst then 
            begin
            ldr_str_loop_flag := true;
            opt_stmts rest inlst
            end
          else
            opt_rest_stmts stmt rest ((reg,offset)::(filter_reg inlst reg))
        | ST (r,m) ->
          let reg = Assign_register.convert r in
          let offset = Assign_register.convert m in
          if List.exists (fun entry -> entry=(reg,offset)) inlst then 
            begin
            ldr_str_loop_flag := true;
            opt_stmts rest inlst
            end
          else
            opt_rest_stmts stmt rest ((reg,offset)::(filter_offset inlst offset)) 
        | AssignStmt3_new ((_,r_m),exp) -> 
          begin
            match exp with 
            | MdCall3_new _ -> opt_rest_stmts stmt rest []
            | _ -> 
              match r_m with
              | Reg r -> 
                let reg = Assign_register.convert r in
                opt_rest_stmts stmt rest (filter_reg inlst reg) 
              | Mem _ -> failwith "var on leftside of assign stmt cannot be offset"
          end
        | AnnoIfStmt3_new arm_stmts ->
          let rec filter_arm_stmts stmts inlst : arm_instr list*(string*string) list= 
            match stmts with 
            | [] -> ([],inlst)
            | stmt::rest -> 
              begin
                match stmt with
                | LDR (_,_,reg,RegPreIndexed (_,offset_int,_)) -> 
                  let offset = string_of_int offset_int in
                  if List.exists (fun entry -> entry=(reg,offset)) inlst then
                    begin
                    ldr_str_loop_flag := true;
                    filter_arm_stmts rest inlst
                    end
                  else let (new_stmts,outlst) = filter_arm_stmts rest ((reg,offset)::(filter_reg inlst reg)) in
                    (stmt::new_stmts,outlst)
                | _ -> let (new_stmts,outlst) = filter_arm_stmts rest inlst in (stmt::new_stmts,outlst) 
              end 
          in let (new_arm_stmts,new_inlst) = filter_arm_stmts arm_stmts inlst in
             opt_rest_stmts (AnnoIfStmt3_new new_arm_stmts) rest new_inlst 
        | MdCallStmt3_new _ -> opt_rest_stmts stmt rest [] 
        | PrintStmt3_new _ -> opt_rest_stmts stmt rest [] 
        | _ -> opt_rest_stmts stmt rest inlst
      end
  in let (new_stmts,outlst) = opt_stmts bbl.stmts inlst in 
  ({id=bbl.id;stmts=new_stmts;}, outlst)

let ldr_str_opt_program (cdatas,mainDecl,mdDecls) =
  let opt_ir3_md_decl md =
    let analysis_htbl = Hashtbl.create 50 in 
    let getLst id = 
      if (Hashtbl.mem analysis_htbl id) = false then []
      else Hashtbl.find analysis_htbl id in
    let process_md_bbls (mdbbls: md_bbls) =
      let rec process_bbls bblLst = 
        match bblLst with
        | [] -> [] 
        | bbl::rest -> 
          let pre_bbl_id_lst = Hashtbl.find_all mdbbls.pre_bbls_htbl bbl.id in
          let inLsts = List.map getLst pre_bbl_id_lst in
          let combined_inLst = 
            if (List.length inLsts) == 0 then []
            else if (List.length inLsts) == 1 then List.hd inLsts 
            else List.fold_left combineLsts (List.hd inLsts) (List.tl inLsts) in
          let (new_bbl,outlst) = ldr_str_opt_bbl bbl combined_inLst in 
          Hashtbl.replace analysis_htbl bbl.id outlst;
          new_bbl::process_bbls rest 
      in 
      let bbls = ref mdbbls.ir3bbls in 
      ldr_str_loop_flag := true;
      while !ldr_str_loop_flag do 
        ldr_str_loop_flag := false; 
        bbls := process_bbls !bbls 
      done;
      {
        ir3bbls=(!bbls);
        pre_bbls_htbl=mdbbls.pre_bbls_htbl;
        next_bbls_htbl=mdbbls.next_bbls_htbl;
        end_bbl_id=mdbbls.end_bbl_id;
      }
    in 
    let new_bbls = process_md_bbls (ir3_stmts_to_bbls md.ir3stmts) in
    let new_stmts = ir3_bbls_to_stmts new_bbls in
    {
      id3=md.id3;
      rettype3=md.rettype3;
      params3=md.params3;
      localvars3=md.localvars3;
      ir3stmts=new_stmts;
      stacksize=md.stacksize;
      anno_param3=md.anno_param3; 
    } 
  in
  let new_main_decl = opt_ir3_md_decl mainDecl in
  let new_md_decls = List.map opt_ir3_md_decl mdDecls in
  (cdatas,new_main_decl,new_md_decls)
  
