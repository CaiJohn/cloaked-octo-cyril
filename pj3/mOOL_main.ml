(* ===================================================== *)
(* ============== CS41212 Compiler Design ============== *)
(* ===================================================== *)

open Printf
open Ir3_to_arm
open MOOL_annotatedtyping
open Arm_structs
open Ir3mOOL_structs
open MOOLtoir3
open Ir3_structs_new
open Ir3_bbl_generator
open Ir3_filter
open Peephole
open Register_allocation
open Liveness_analysis
open Ldr_str_optimizer
open Common_subexpression
open Copy_propagation
open Optimization_flags

open MOOL_simple_annotatedtyping
let useTA = false

let source_files = ref []
let output_file = ref ""
let verbose = ref false

let usage_msg = Sys.argv.(1) ^ " <source files>"

let set_source_file arg = source_files := arg :: !source_files

let print_endlinev str = if !verbose then print_endline str
  else () 

let parse_file file_name =
  let org_in_chnl = open_in file_name in
  let lexbuf = Lexing.from_channel org_in_chnl in
  try
    print_endlinev "Compiling..." ;
    print_endlinev file_name ;
    let prog =  MOOL_parser.input (MOOL_lexer.token file_name) lexbuf in
    close_in org_in_chnl;
    prog
  with
    End_of_file -> exit 0

let analyze_method md =
  let (liveness_graph,costs) = Liveness_analysis.liveness_analysis md.ir3stmts in
  let _ = print_endlinev
      ("====Graph====\n" ^
       (string_of_list liveness_graph
          (fun (node, neibour) -> node ^ ": " ^
                                  string_of_list neibour (fun str -> str) " ")
          "\n"))
  in
  let (reg_assign_res, spill_list) =
    Register_allocation.register_allocation 5 liveness_graph costs in
  let _ = print_endlinev
      ("====Reg Assignment====\n" ^
       (string_of_list reg_assign_res
          (fun (var, reg) -> (var ^ ": R" ^ (string_of_int reg)))
          "\n"
       ))
  in
  let _ = print_endlinev
      ("====Spill List====\n" ^
       (string_of_list spill_list (fun str -> str) ", ")
       ^ "\n")
  in
  Assign_register.assign_register md reg_assign_res spill_list

let analyze_program (cdata,main,mtds) =
  let new_main = analyze_method main in
  let new_mtds = List.map analyze_method mtds in
  (cdata,new_main,new_mtds)

let basic_block_optimize ir3_prog_new =
  let block_optimize_md_decl md_decl =  
    let stmts = ref md_decl.ir3stmts in
    let pre_stmts_len = ref (List.length md_decl.ir3stmts) in
    let cse_cp_loop_flag = ref true in 
    while !cse_cp_loop_flag do
      cse_cp_loop_flag := false;
      (* Global Common Sub-expression Elimination *)
      stmts := if (!Optimization_flags.opt_global_common_sub_expression) then
          (Global_common_subexpression.global_common_subexp_elimination !stmts)
        else !stmts; 
      let ir3bbls = (ir3_stmts_to_bbls !stmts).ir3bbls in 
      let stmts_list = 
        List.map
          (
            fun x ->
              let stmts = x.stmts in
              let optimized_stmts = stmts in
              (* Common Sub-expression Elimination *)
              let optimized_stmts =
                if (!Optimization_flags.opt_common_sub_expression) then
                  (Common_subexpression.common_subexp_elimination optimized_stmts)
                else
                  optimized_stmts
              in
              (* Copy propagation optimization *)
              let optimized_stmts =
                if (!Optimization_flags.opt_copy_propagation) then
                  (Copy_propagation.copy_propagation_elimination optimized_stmts)
                else
                  optimized_stmts
              in
              optimized_stmts
          )
          ir3bbls in
      stmts := List.flatten stmts_list;
      (* Dead code elimination *)
      stmts := if (!Optimization_flags.opt_deadcode) then
          (Liveness_analysis.dead_code_elimination_fixpoint !stmts)
        else
          !stmts;
      (*print_endline ("Pre Stmt Len = " ^ (string_of_int !pre_stmts_len) ^ ", New Stmt Len = " ^ (string_of_int (List.length !stmts)));*)
      if !pre_stmts_len=(List.length !stmts) 
      then cse_cp_loop_flag := false
      else cse_cp_loop_flag := true;
      pre_stmts_len := List.length !stmts
    done;
    { md_decl with ir3stmts = !stmts }
  in
  let (cdata, main_md_decl, md_decls) = ir3_prog_new in
  let optimized_main_md_decl = block_optimize_md_decl main_md_decl in
  let optimized_md_decls = List.map
      (fun md_decl -> block_optimize_md_decl md_decl) md_decls in
  (cdata, optimized_main_md_decl, optimized_md_decls) 

let process prog  =
  begin
    (*print_endlinev (MOOL_structs.string_of_mOOL_program prog);*)

    (* Whether to use the type checker provided by TA *)
    let typedprog= if useTA then (MOOL_annotatedtyping.type_check_mOOL_program prog)
      else (MOOL_annotatedtyping.type_check_mOOL_program prog) in
    (*print_endlinev (MOOL_structs.string_of_mOOL_program typedprog);*)
    let ir3prog = (MOOLtoir3.mOOL_program_to_IR3 typedprog) in
    print_endlinev (Ir3mOOL_structs.string_of_ir3_program ir3prog);
    let ir3prog_optimized =
      if !Optimization_flags.opt_peephole then
        Peephole.peephole_optimize ir3prog
      else ir3prog in
    if !Optimization_flags.opt_peephole then
      begin
        print_endlinev "=========Peephole optimization======";
        print_endlinev (Ir3mOOL_structs.string_of_ir3_program ir3prog_optimized)
      end
    else print_endlinev "";
    let ir3prog_filtered = Ir3_filter.ir3_program_filter ir3prog_optimized in
    (*print_endlinev (ir3mOOL_structs.string_of_ir3_program ir3prog_filtered);*)
    let ir3newprog = Ir3_structs_new.ir3_program_to_ir3_program_new ir3prog_filtered in
    let ir3newprog = if !Optimization_flags.opt_deadcode then 
        Liveness_analysis.dead_code_elimination_for_prog
          ir3newprog
      else ir3newprog in
    let ir3newprog = basic_block_optimize ir3newprog in
    let updated_ir3newprog = analyze_program ir3newprog in
    let _ = print_endlinev ("======Updated IR3 program========\n"^
                            Ir3_structs_new.string_of_ir3_program_new updated_ir3newprog) in
    let final_ir3prog =
      if (!Optimization_flags.opt_ldr_str) then
        (Ldr_str_optimizer.ldr_str_opt_program updated_ir3newprog)
      else updated_ir3newprog in

    (* Generate arm code from ir3 *)
    let arm_program = Ir3_to_arm.ir3_to_arm final_ir3prog in
    let file = open_out !output_file in
    let _ = Printf.fprintf file "%s" ((Arm_structs.string_of_arm_prog arm_program)^"\n");
      close_out file;
    in
    print_endlinev ("======Arm Program========\n"^
                    Arm_structs.string_of_arm_prog arm_program)
  end

let _ =
  let set_all() = 
    Optimization_flags.opt_deadcode:=true;
    Optimization_flags.opt_common_sub_expression:=true;
    Optimization_flags.opt_copy_propagation:=true;
    Optimization_flags.opt_peephole:=true;
    Optimization_flags.opt_ldr_str:=true
  in let speclist = [("-d", Arg.Set Optimization_flags.opt_deadcode, "Enables deadcode optimization");
                     ("-cse", Arg.Set Optimization_flags.opt_common_sub_expression, "Enables common sub-expression optimization");
                     ("-gcse", Arg.Set Optimization_flags.opt_global_common_sub_expression, "Enables global common sub-expression optimization");
                     ("-cp", Arg.Set Optimization_flags.opt_copy_propagation, "Enables copy propagation optimization");
                     ("-ph", Arg.Set Optimization_flags.opt_peephole, "Enables peephole optimization");
                     ("-cl", Arg.Set Optimization_flags.opt_ldr_str, "Enables consecutive ldr optimization");
                     ("-o", Arg.Set_string output_file, "Set output file name");
                     ("-v", Arg.Set verbose, "Enable debug information");
                     ("-a", Arg.Unit set_all, "Enable all optimizations");
                    ]
  in let usage_msg = "==============MOOL compiler=============="
  in
  Arg.parse speclist (fun x -> source_files:=!source_files@[x]) usage_msg;
  if (!Optimization_flags.opt_common_sub_expression || !Optimization_flags.opt_global_common_sub_expression) then
    Optimization_flags.opt_deadcode := true else ();
  print_endlinev ("opt_deadcode = " ^ string_of_bool !Optimization_flags.opt_deadcode);
  print_endlinev ("opt_common_sub_expression = " ^ string_of_bool !Optimization_flags.opt_common_sub_expression);
  print_endlinev ("opt_global_common_sub_expression = " ^ string_of_bool !Optimization_flags.opt_global_common_sub_expression);
  print_endlinev ("opt_copy_propagation = " ^ string_of_bool !Optimization_flags.opt_copy_propagation);
  print_endlinev ("opt_peephole = " ^ string_of_bool !Optimization_flags.opt_peephole);
  print_endlinev ("opt_ldr_str = " ^ string_of_bool !Optimization_flags.opt_ldr_str);
  match !source_files with
  | [] -> print_string "No file provided \n"
  | x::_-> if !output_file = "" then output_file:= x^".s";
    let prog = parse_file x in process prog
