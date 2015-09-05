open Ir3_structs_new
open Arm_structs

(* The structure of a basic block *)
type ir3_bbl = 
  {
     id: int; (* Note: id may not be consecutive *) 
     (* set to mutable here to make it easier to add/delete stmt *) 
     mutable stmts: ir3_stmt_new list; (* empty list means this is the End block of function *)
  }

type md_bbls = 
  {
    ir3bbls: ir3_bbl list;
    pre_bbls_htbl: (int, int) Hashtbl.t;
    next_bbls_htbl: (int, int) Hashtbl.t;
    end_bbl_id: int; 
  }

let ir3_bbls_to_stmts (bbls: md_bbls) : ir3_stmt_new list = 
  let rec process_bbls bbl_lst = 
    match bbl_lst with
    | [] -> []
    | bbl::rest -> bbl.stmts @ (process_bbls rest) 
  in process_bbls bbls.ir3bbls

let ir3_stmts_to_bbls (stmts : ir3_stmt_new list) : md_bbls =
   let lblHtbl = Hashtbl.create 20 (* label->bbl_id *) in 
   let add_to_htbl htbl k v =
     if ((Hashtbl.mem htbl k)==true) 
     then 
       let vlst = Hashtbl.find_all htbl k in
       if ((List.exists (fun x -> v == x) vlst)==true)
       then ()
       else Hashtbl.add htbl k v; 
     else
       Hashtbl.add htbl k v; 
   in 
   let rec get_lbl_from_arm_stmts arm_stmts : int =
     match arm_stmts with
     | [stmt] -> 
       begin
         match stmt with
         | B (_,lblStr) -> int_of_string (String.sub lblStr 1 ((String.length lblStr)-1)) 
         | _ -> failwith "Error - the AnnoIfStmt3's last arm_stmt is not B stmt!"
       end 
     | _::rest -> get_lbl_from_arm_stmts rest 
     | [] -> failwith "This cannot happen! If's arm_stmts cannot be empty"
   in
   let stmts_to_bbls ir3_stmts : (ir3_bbl list)*((int,int) Hashtbl.t)*((int, int) Hashtbl.t)*int =
     let next_bbls_htbl = Hashtbl.create 30 in
     let tmp_pre_bbls_htbl = Hashtbl.create 30 in 
     let rec iterate_stmts bbl_id startNewBbl stmts : (ir3_stmt_new list)*(ir3_bbl list)*int =
       match stmts with
       | [] -> ([], { id=bbl_id+1; stmts=[]; }::[], bbl_id+1) 
       | stmt::rest ->
         match stmt with 
         | AnnoIfStmt3_new [] -> iterate_stmts bbl_id false rest (* Just skip this one *) 
         | IfStmt3_new _ | AnnoIfStmt3_new _ -> 
           add_to_htbl next_bbls_htbl bbl_id (bbl_id+1);
           add_to_htbl tmp_pre_bbls_htbl (bbl_id+1) bbl_id; 
           let (new_stmts, new_bbls, end_id) = iterate_stmts (bbl_id+1) true rest in
           let goto_bbl_id = 
             match stmt with 
             | IfStmt3_new (_,lbl) -> Hashtbl.find lblHtbl lbl 
             | AnnoIfStmt3_new arm_stmts -> Hashtbl.find lblHtbl (get_lbl_from_arm_stmts arm_stmts) 
             | _ -> failwith "This never ever happen....."
           in
           add_to_htbl next_bbls_htbl bbl_id goto_bbl_id;
           add_to_htbl tmp_pre_bbls_htbl goto_bbl_id bbl_id; 
           if (startNewBbl==true) 
           then ([], { id=bbl_id; stmts=stmt::new_stmts; }::new_bbls, end_id)
           else (stmt::new_stmts, new_bbls, end_id)   
         | GoTo3_new lbl ->
           let (new_stmts, new_bbls, end_id) = iterate_stmts (bbl_id+1) true rest in
           let goto_bbl_id = Hashtbl.find lblHtbl lbl in
           if (startNewBbl==true) (* dangling goto, only happen if it is right after return *)
           then ([], new_bbls, end_id)
           else 
             begin 
               add_to_htbl next_bbls_htbl bbl_id goto_bbl_id;
               add_to_htbl tmp_pre_bbls_htbl goto_bbl_id bbl_id; 
               (stmt::new_stmts, new_bbls, end_id)
             end
         | Label3_new lbl ->
           let bbl_id = if (startNewBbl==true) then bbl_id else bbl_id+1 in
           Hashtbl.add lblHtbl lbl bbl_id;
           let (new_stmts, new_bbls, end_id) = iterate_stmts bbl_id false rest in
           begin
             match new_stmts with
             | [] -> 
               begin 
                 add_to_htbl next_bbls_htbl bbl_id (bbl_id+1);                 
                 add_to_htbl tmp_pre_bbls_htbl (bbl_id+1) bbl_id; 
               end;
             | _ -> ()
           end;
           ([], { id=bbl_id; stmts=stmt::new_stmts; }::new_bbls, end_id)
         | ReturnStmt3_new _ | ReturnVoidStmt3_new ->
           let (new_stmts, new_bbls, end_id) = iterate_stmts (bbl_id+1) true rest in
           add_to_htbl next_bbls_htbl bbl_id end_id;
           add_to_htbl tmp_pre_bbls_htbl end_id bbl_id; 
           if (startNewBbl==true)
           then ([], { id=bbl_id; stmts=stmt::new_stmts; }::new_bbls, end_id)
           else (stmt::new_stmts, new_bbls, end_id)
         | _ -> 
           let (new_stmts, new_bbls, end_id) = iterate_stmts bbl_id false rest in
           begin
             match new_stmts with
             | [] -> 
               begin
                 add_to_htbl next_bbls_htbl bbl_id (bbl_id+1);                 
                 add_to_htbl tmp_pre_bbls_htbl (bbl_id+1) bbl_id; 
               end; 
             | _ -> ()
           end;
           if (startNewBbl==true) 
           then ([], { id=bbl_id; stmts=stmt::new_stmts; }::new_bbls, end_id)
           else (stmt::new_stmts, new_bbls, end_id)
     in
     let (_,bbls,end_id) = iterate_stmts 0 true ir3_stmts in 
     let rec filter bbl_list = 
       match bbl_list with
       | [] -> []
       | bbl::rest -> 
         if (bbl.id>0 && (Hashtbl.mem tmp_pre_bbls_htbl bbl.id)==false) 
         then (filter rest) 
         else bbl::(filter rest) in 
     let f_bbls = filter bbls in
     let pre_bbls_htbl = Hashtbl.create 30 in
     let pre_hashing bbl_list = 
       let helper bbl =
         let helper2 next_id = add_to_htbl pre_bbls_htbl next_id bbl.id
         in ignore (List.map helper2 (Hashtbl.find_all next_bbls_htbl bbl.id))
       in ignore (List.map helper bbl_list) in 
     pre_hashing f_bbls;
     (f_bbls,pre_bbls_htbl,next_bbls_htbl,end_id) 
   in
   let (bbls,pre_bbls,next_bbls,end_id) = stmts_to_bbls stmts in
   {
     ir3bbls=bbls;
     pre_bbls_htbl=pre_bbls;
     next_bbls_htbl=next_bbls;
     end_bbl_id=end_id; 
   } 

type md_decl3_bbl = 
  {
    id3: string;
    rettype3: ir3_type_new;
    params3: var_decl3_new list;
    ir3bbls: ir3_bbl list;
    pre_bbls_htbl: (int, int) Hashtbl.t;
    next_bbls_htbl: (int, int) Hashtbl.t; 
  }

type ir3_program_bbl = (cdata3_new list) * (md_decl3_bbl) * (md_decl3_bbl list)

let ir3_program_to_bbls (cdatas,ir3Main,ir3Mtds) : ir3_program_bbl =
  let generate_md_decl3_bbl md_decl3 =
    let bbls = ir3_stmts_to_bbls md_decl3.ir3stmts in
      let (fname,_) = md_decl3.id3 in
      {
        id3=fname;
        rettype3=md_decl3.rettype3;
        params3=md_decl3.params3;
        ir3bbls=bbls.ir3bbls;
        pre_bbls_htbl=bbls.pre_bbls_htbl;
        next_bbls_htbl=bbls.next_bbls_htbl;
      } 
  in (cdatas, generate_md_decl3_bbl ir3Main, (List.map generate_md_decl3_bbl ir3Mtds)) 

let string_of_md_decl3_bbl (m : md_decl3_bbl) =
  let string_of_ir3_stmt_bbl stmt =
    print_tab() ^ (string_of_ir3_stmt_new stmt) in
  let string_of_bbl bbl =
    print_tab() ^ "---------- Basic Block " ^ (string_of_int bbl.id) ^ " ----------\n" ^
    print_tab() ^ "pre_bbls: " ^ (string_of_list (Hashtbl.find_all m.pre_bbls_htbl bbl.id) string_of_int " ") ^
    "\n" ^ print_tab() ^ 
    "next_bbls: " ^ (string_of_list (Hashtbl.find_all m.next_bbls_htbl bbl.id) string_of_int " ") ^
    "\n" ^ print_tab() ^ "-----------------------------------\n" ^
    (string_of_list bbl.stmts string_of_ir3_stmt_bbl "\n") ^ "\n" in 
  let methodHeader = 
    print_tab() ^ (string_of_ir3_type_new m.rettype3) 
		^ " " ^ m.id3 ^ 
		"(" ^ (string_of_list m.params3 string_of_arg_decl3_new "," ) ^ ")" 
		^"{\n" in
  let indentI = indent_inc() in
  let methodBbls = string_of_list m.ir3bbls string_of_bbl "\n" in
  let indentD = indent_dec() in
  let methodEnd = print_tab() ^ "}\n" in
  methodHeader ^ indentI ^ methodBbls ^ indentD ^ methodEnd

let string_of_ir3_program_bbl (_, main_bbl, bbl_list) =
  "========== IR3 Basic Blocks =========\n\n" ^ 
  (string_of_md_decl3_bbl main_bbl) ^ "\n\n" ^
  (string_of_list bbl_list string_of_md_decl3_bbl "\n") ^
  "\n========== End of IR3 Basic Blocks ==========\n\n"

