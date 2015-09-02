
(* ===================================================== *)
(* ============== CS4212 Compiler Design ============== *)
(* ===================================================== *)


let source_files = ref []

let usage_msg = Sys.argv.(1) ^ " <source files>"

let set_source_file arg = source_files := arg :: !source_files

let parse_file file_name = 
  let org_in_chnl = open_in file_name in
  let lexbuf = Lexing.from_channel org_in_chnl in
    try
      print_string "Parsing...\n" ;
    print_string file_name ;
    print_string "\n" ;
    let prog =  MOOL_parser.input (MOOL_lexer.token file_name) lexbuf in
      close_in org_in_chnl;
        prog 
    with
    End_of_file -> exit 0  
    | Parsing.Parse_error ->
        let curr = lexbuf.Lexing.lex_curr_p in
        let tok = Lexing.lexeme lexbuf in
        let () = print_endline ("parsing: tok "^tok) in exit 0 


let _ = 
 begin
  Arg.parse [] set_source_file usage_msg ;
    match !source_files with
    | [] -> print_string "no file provided \n"
    | x::_-> 
      let prog = parse_file x in
      let () = print_endline (MOOL_structs.string_of_mOOL_program prog) in
      let typed_prog = MOOL_annotatedtyping.type_check_mOOL_program prog in
      let () = print_endline (MOOL_structs.string_of_mOOL_program typed_prog) in
      ()
 end
(*
 begin
        let curr = lexbuf.Lexing.lex_curr_p in
        let line = curr.Lexing.pos_lnum in
        let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
        let tok = Lexing.lexeme lexbuf in
        let tail = Sql_lexer.ruleTail "" lexbuf in
        raise (Error (exn,(line,cnum,tok,tail)))
      end
*)
