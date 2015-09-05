type token =
  | PLUS
  | MINUS
  | MULTIPLY
  | DIVIDE
  | EQ
  | NEQ
  | GRE
  | GEQ
  | LE
  | LEQ
  | AND
  | OR
  | NEG
  | ASSIGN
  | INT_KWORD
  | BOOL_KWORD
  | STRING_KWORD
  | VOID_KWORD
  | TRUE_KWORD
  | FALSE_KWORD
  | CLASS_KWORD
  | WHILE_KWORD
  | IF_KWORD
  | ELSE_KWORD
  | RETURN_KWORD
  | THIS_KWORD
  | NULL_KWORD
  | NEW_KWORD
  | MAIN_KWORD
  | READ_KWORD
  | PRINT_KWORD
  | INTEGER_LITERAL of (int)
  | STRING_LITERAL of (string)
  | VAR_IDENTIFIER of (string)
  | CLASS_IDENTIFIER of (string)
  | NEWLINE
  | OPAREN
  | CPAREN
  | OBRACE
  | CBRACE
  | SEMICOLON
  | DOT
  | COMMA
  | COMMENT_LINE
  | COMMENT_OPEN
  | COMMENT_CLOSE
  | EOF

open Parsing;;
let _ = parse_error;;
# 8 "jlite_parser.mly"


  open Printf
  open Jlite_structs

  let get_pos x = 
	Parsing.rhs_start_pos x
	
   let cnt = ref 0 
   let fresh_label () = (cnt:=!cnt+1; !cnt)
   
   let report_error pos s =
   print_string ("\nFile \"" ^ pos.Lexing.pos_fname ^ "\", line " ^ 
		(string_of_int pos.Lexing.pos_lnum) ^", col "^
    	(string_of_int (pos.Lexing.pos_cnum - pos.Lexing.pos_bol))^ ": "
        ^ s ^ "\n"); flush stdout;
  failwith "Error detected"
  
# 72 "jlite_parser.ml"
let yytransl_const = [|
  257 (* PLUS *);
  258 (* MINUS *);
  259 (* MULTIPLY *);
  260 (* DIVIDE *);
  261 (* EQ *);
  262 (* NEQ *);
  263 (* GRE *);
  264 (* GEQ *);
  265 (* LE *);
  266 (* LEQ *);
  267 (* AND *);
  268 (* OR *);
  269 (* NEG *);
  270 (* ASSIGN *);
  271 (* INT_KWORD *);
  272 (* BOOL_KWORD *);
  273 (* STRING_KWORD *);
  274 (* VOID_KWORD *);
  275 (* TRUE_KWORD *);
  276 (* FALSE_KWORD *);
  277 (* CLASS_KWORD *);
  278 (* WHILE_KWORD *);
  279 (* IF_KWORD *);
  280 (* ELSE_KWORD *);
  281 (* RETURN_KWORD *);
  282 (* THIS_KWORD *);
  283 (* NULL_KWORD *);
  284 (* NEW_KWORD *);
  285 (* MAIN_KWORD *);
  286 (* READ_KWORD *);
  287 (* PRINT_KWORD *);
  292 (* NEWLINE *);
  293 (* OPAREN *);
  294 (* CPAREN *);
  295 (* OBRACE *);
  296 (* CBRACE *);
  297 (* SEMICOLON *);
  298 (* DOT *);
  299 (* COMMA *);
  300 (* COMMENT_LINE *);
  301 (* COMMENT_OPEN *);
  302 (* COMMENT_CLOSE *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  288 (* INTEGER_LITERAL *);
  289 (* STRING_LITERAL *);
  290 (* VAR_IDENTIFIER *);
  291 (* CLASS_IDENTIFIER *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\005\000\003\000\003\000\008\000\008\000\004\000\
\012\000\013\000\007\000\007\000\015\000\015\000\014\000\014\000\
\014\000\014\000\014\000\009\000\009\000\016\000\016\000\010\000\
\010\000\017\000\017\000\006\000\006\000\018\000\018\000\018\000\
\019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
\019\000\023\000\023\000\011\000\011\000\020\000\020\000\020\000\
\024\000\024\000\027\000\027\000\028\000\028\000\028\000\028\000\
\028\000\028\000\028\000\029\000\029\000\029\000\029\000\025\000\
\025\000\025\000\030\000\030\000\030\000\031\000\031\000\031\000\
\026\000\026\000\021\000\021\000\021\000\021\000\021\000\021\000\
\021\000\022\000\022\000\032\000\032\000\000\000"

let yylen = "\002\000\
\002\000\005\000\006\000\000\000\001\000\001\000\002\000\009\000\
\001\000\009\000\000\000\001\000\001\000\002\000\001\000\001\000\
\001\000\001\000\001\000\000\000\001\000\002\000\004\000\000\000\
\001\000\003\000\004\000\000\000\001\000\004\000\001\000\003\000\
\003\000\002\000\011\000\007\000\004\000\005\000\005\000\006\000\
\005\000\000\000\001\000\001\000\002\000\001\000\001\000\001\000\
\003\000\001\000\003\000\001\000\003\000\003\000\003\000\003\000\
\003\000\003\000\001\000\002\000\001\000\001\000\001\000\003\000\
\003\000\001\000\003\000\003\000\001\000\001\000\002\000\001\000\
\001\000\001\000\003\000\004\000\001\000\001\000\001\000\004\000\
\003\000\000\000\001\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\086\000\000\000\000\000\000\000\001\000\
\006\000\000\000\000\000\000\000\007\000\000\000\000\000\000\000\
\000\000\002\000\016\000\015\000\017\000\018\000\019\000\000\000\
\031\000\000\000\029\000\000\000\000\000\013\000\000\000\000\000\
\009\000\000\000\000\000\000\000\000\000\003\000\000\000\014\000\
\000\000\000\000\000\000\022\000\000\000\000\000\030\000\000\000\
\000\000\000\000\000\000\000\000\000\000\023\000\000\000\000\000\
\000\000\000\000\077\000\078\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\061\000\062\000\070\000\073\000\034\000\
\079\000\000\000\000\000\000\000\000\000\048\000\000\000\052\000\
\059\000\000\000\069\000\000\000\000\000\000\000\000\000\008\000\
\000\000\045\000\000\000\000\000\026\000\000\000\000\000\000\000\
\000\000\000\000\071\000\000\000\060\000\033\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\081\000\
\000\000\084\000\000\000\000\000\000\000\027\000\010\000\000\000\
\000\000\000\000\075\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\051\000\067\000\
\068\000\080\000\000\000\000\000\037\000\000\000\000\000\000\000\
\000\000\000\000\076\000\038\000\039\000\041\000\085\000\000\000\
\000\000\000\000\040\000\036\000\000\000\000\000\000\000\000\000\
\035\000"

let yydgoto = "\002\000\
\004\000\005\000\008\000\015\000\009\000\024\000\029\000\010\000\
\035\000\051\000\065\000\081\000\025\000\026\000\032\000\037\000\
\053\000\027\000\067\000\130\000\106\000\131\000\000\000\084\000\
\085\000\086\000\087\000\088\000\089\000\090\000\091\000\132\000"

let yysindex = "\012\000\
\236\254\000\000\252\254\000\000\016\255\004\255\011\255\000\000\
\000\000\016\255\055\255\014\255\000\000\026\255\025\255\059\000\
\044\255\000\000\000\000\000\000\000\000\000\000\000\000\059\000\
\000\000\050\255\000\000\059\000\049\255\000\000\050\255\059\000\
\000\000\235\254\057\255\050\255\056\255\000\000\076\255\000\000\
\059\000\059\000\094\255\000\000\059\000\096\255\000\000\059\000\
\050\255\115\255\061\000\050\255\059\000\000\000\059\000\114\255\
\124\255\074\255\000\000\000\000\121\255\126\255\127\255\224\255\
\128\255\155\255\061\000\233\254\129\255\050\255\061\000\224\255\
\224\255\002\000\139\255\000\000\000\000\000\000\000\000\000\000\
\000\000\130\255\241\254\160\255\121\000\000\000\164\255\000\000\
\000\000\031\255\000\000\141\255\050\255\224\255\144\255\000\000\
\224\255\000\000\224\255\050\255\000\000\142\255\152\255\157\255\
\158\255\241\254\000\000\241\254\000\000\000\000\224\255\050\255\
\246\255\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\246\255\002\000\002\000\169\255\170\255\180\255\000\000\
\178\255\000\000\183\255\181\255\209\255\000\000\000\000\186\255\
\188\255\190\255\000\000\241\254\121\000\164\255\031\255\031\255\
\062\255\062\255\062\255\062\255\062\255\062\255\000\000\000\000\
\000\000\000\000\195\255\197\255\000\000\198\255\224\255\224\255\
\061\000\061\000\000\000\000\000\000\000\000\000\000\000\199\255\
\189\255\194\255\000\000\000\000\207\255\202\255\061\000\206\255\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\232\000\000\000\000\000\000\000\
\000\000\249\000\000\000\000\000\000\000\000\000\000\000\214\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\215\255\
\000\000\000\000\000\000\225\255\000\000\000\000\000\000\222\255\
\000\000\000\000\000\000\000\000\226\255\000\000\000\000\000\000\
\225\255\227\255\000\000\000\000\000\000\000\000\000\000\074\000\
\000\000\000\000\000\000\000\000\087\000\000\000\074\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\020\255\228\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\119\255\009\255\112\255\000\000\251\254\000\000\
\000\000\179\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\231\255\000\000\000\000\000\000\000\000\000\000\
\000\000\136\255\000\000\037\255\000\000\000\000\231\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\237\255\035\255\000\000\000\000\000\000\
\000\000\000\000\000\000\119\255\000\000\028\255\192\255\204\255\
\047\255\071\255\003\000\009\000\020\000\026\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\061\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\243\000\000\000\000\000\000\000\
\238\000\226\000\191\255\230\255\236\255\025\001\000\000\000\000\
\000\000\240\000\000\000\201\255\213\255\178\000\000\000\000\000\
\019\001\000\000\183\000\169\000\223\000\233\255\193\255\000\000"

let yytablesize = 397
let yytable = "\034\000\
\003\000\098\000\082\000\030\000\039\000\103\000\050\000\068\000\
\095\000\044\000\107\000\040\000\001\000\099\000\083\000\041\000\
\104\000\105\000\100\000\042\000\083\000\111\000\054\000\068\000\
\066\000\069\000\112\000\068\000\083\000\083\000\006\000\108\000\
\050\000\123\000\124\000\050\000\007\000\050\000\127\000\049\000\
\066\000\129\000\011\000\102\000\066\000\012\000\046\000\063\000\
\063\000\046\000\083\000\046\000\016\000\083\000\017\000\083\000\
\079\000\053\000\053\000\152\000\153\000\079\000\114\000\115\000\
\018\000\049\000\126\000\083\000\049\000\140\000\049\000\075\000\
\014\000\133\000\063\000\074\000\075\000\063\000\140\000\063\000\
\028\000\054\000\054\000\033\000\053\000\139\000\075\000\053\000\
\038\000\053\000\143\000\144\000\076\000\077\000\043\000\169\000\
\170\000\076\000\045\000\059\000\060\000\061\000\076\000\167\000\
\168\000\078\000\079\000\033\000\054\000\176\000\064\000\054\000\
\041\000\054\000\080\000\083\000\083\000\068\000\068\000\072\000\
\072\000\072\000\072\000\072\000\072\000\072\000\072\000\072\000\
\072\000\063\000\063\000\068\000\048\000\050\000\066\000\066\000\
\072\000\072\000\072\000\072\000\072\000\072\000\072\000\072\000\
\072\000\072\000\072\000\072\000\066\000\047\000\072\000\075\000\
\047\000\055\000\047\000\092\000\063\000\076\000\077\000\063\000\
\073\000\063\000\093\000\094\000\059\000\060\000\061\000\096\000\
\097\000\101\000\110\000\113\000\033\000\072\000\122\000\064\000\
\072\000\125\000\072\000\066\000\066\000\128\000\134\000\066\000\
\066\000\066\000\066\000\066\000\066\000\066\000\066\000\135\000\
\064\000\064\000\136\000\137\000\064\000\064\000\064\000\064\000\
\064\000\064\000\064\000\064\000\065\000\065\000\154\000\155\000\
\065\000\065\000\065\000\065\000\065\000\065\000\065\000\065\000\
\066\000\156\000\157\000\066\000\158\000\066\000\160\000\159\000\
\161\000\074\000\162\000\163\000\172\000\064\000\174\000\004\000\
\064\000\173\000\064\000\164\000\075\000\165\000\166\000\171\000\
\175\000\065\000\076\000\077\000\065\000\177\000\065\000\074\000\
\005\000\059\000\060\000\061\000\013\000\028\000\011\000\078\000\
\079\000\033\000\075\000\074\000\064\000\012\000\020\000\021\000\
\076\000\077\000\032\000\044\000\082\000\055\000\055\000\059\000\
\060\000\061\000\083\000\056\000\056\000\078\000\046\000\033\000\
\071\000\047\000\064\000\059\000\060\000\061\000\057\000\057\000\
\138\000\078\000\151\000\033\000\058\000\058\000\064\000\142\000\
\055\000\109\000\000\000\055\000\000\000\055\000\056\000\000\000\
\031\000\056\000\000\000\056\000\036\000\000\000\000\000\000\000\
\031\000\057\000\000\000\000\000\057\000\000\000\057\000\058\000\
\000\000\036\000\058\000\000\000\058\000\049\000\000\000\000\000\
\052\000\019\000\020\000\021\000\022\000\070\000\000\000\052\000\
\000\000\000\000\056\000\057\000\000\000\058\000\059\000\060\000\
\061\000\000\000\062\000\063\000\000\000\023\000\033\000\024\000\
\024\000\064\000\024\000\024\000\024\000\024\000\000\000\024\000\
\024\000\000\000\000\000\024\000\025\000\025\000\024\000\025\000\
\025\000\025\000\025\000\000\000\025\000\025\000\000\000\000\000\
\025\000\114\000\115\000\025\000\000\000\116\000\117\000\118\000\
\119\000\120\000\121\000\141\000\000\000\000\000\145\000\146\000\
\147\000\148\000\149\000\150\000\141\000"

let yycheck = "\026\000\
\021\001\067\000\058\000\024\000\031\000\071\000\012\001\051\000\
\064\000\036\000\074\000\032\000\001\000\037\001\058\000\037\001\
\072\000\073\000\042\001\041\001\064\000\037\001\049\000\067\000\
\051\000\052\000\042\001\071\000\072\000\073\000\035\001\075\000\
\038\001\003\001\004\001\041\001\021\001\043\001\094\000\012\001\
\067\000\097\000\039\001\070\000\071\000\035\001\038\001\011\001\
\012\001\041\001\094\000\043\001\039\001\097\000\029\001\099\000\
\037\001\011\001\012\001\123\000\124\000\042\001\001\001\002\001\
\040\001\038\001\093\000\111\000\041\001\113\000\043\001\037\001\
\018\001\100\000\038\001\002\001\042\001\041\001\122\000\043\001\
\037\001\011\001\012\001\034\001\038\001\112\000\013\001\041\001\
\040\001\043\001\114\000\115\000\019\001\020\001\038\001\161\000\
\162\000\037\001\043\001\026\001\027\001\028\001\042\001\159\000\
\160\000\032\001\033\001\034\001\038\001\175\000\037\001\041\001\
\037\001\043\001\041\001\159\000\160\000\161\000\162\000\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\175\000\039\001\038\001\161\000\162\000\
\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\175\000\038\001\037\001\013\001\
\041\001\039\001\043\001\035\001\038\001\019\001\020\001\041\001\
\037\001\043\001\037\001\037\001\026\001\027\001\028\001\040\001\
\014\001\041\001\041\001\012\001\034\001\038\001\011\001\037\001\
\041\001\037\001\043\001\001\001\002\001\038\001\041\001\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\040\001\
\001\001\002\001\038\001\038\001\005\001\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\001\001\002\001\038\001\038\001\
\005\001\006\001\007\001\008\001\009\001\010\001\011\001\012\001\
\038\001\038\001\041\001\041\001\038\001\043\001\014\001\043\001\
\039\001\002\001\039\001\038\001\040\001\038\001\024\001\000\000\
\041\001\040\001\043\001\041\001\013\001\041\001\041\001\041\001\
\039\001\038\001\019\001\020\001\041\001\040\001\043\001\002\001\
\000\000\026\001\027\001\028\001\010\000\040\001\040\001\032\001\
\033\001\034\001\013\001\002\001\037\001\040\001\038\001\038\001\
\019\001\020\001\040\001\040\001\038\001\011\001\012\001\026\001\
\027\001\028\001\038\001\011\001\012\001\032\001\041\000\034\001\
\055\000\042\000\037\001\026\001\027\001\028\001\011\001\012\001\
\111\000\032\001\122\000\034\001\011\001\012\001\037\001\113\000\
\038\001\075\000\255\255\041\001\255\255\043\001\038\001\255\255\
\024\000\041\001\255\255\043\001\028\000\255\255\255\255\255\255\
\032\000\038\001\255\255\255\255\041\001\255\255\043\001\038\001\
\255\255\041\000\041\001\255\255\043\001\045\000\255\255\255\255\
\048\000\015\001\016\001\017\001\018\001\053\000\255\255\055\000\
\255\255\255\255\022\001\023\001\255\255\025\001\026\001\027\001\
\028\001\255\255\030\001\031\001\255\255\035\001\034\001\022\001\
\023\001\037\001\025\001\026\001\027\001\028\001\255\255\030\001\
\031\001\255\255\255\255\034\001\022\001\023\001\037\001\025\001\
\026\001\027\001\028\001\255\255\030\001\031\001\255\255\255\255\
\034\001\001\001\002\001\037\001\255\255\005\001\006\001\007\001\
\008\001\009\001\010\001\113\000\255\255\255\255\116\000\117\000\
\118\000\119\000\120\000\121\000\122\000"

let yynames_const = "\
  PLUS\000\
  MINUS\000\
  MULTIPLY\000\
  DIVIDE\000\
  EQ\000\
  NEQ\000\
  GRE\000\
  GEQ\000\
  LE\000\
  LEQ\000\
  AND\000\
  OR\000\
  NEG\000\
  ASSIGN\000\
  INT_KWORD\000\
  BOOL_KWORD\000\
  STRING_KWORD\000\
  VOID_KWORD\000\
  TRUE_KWORD\000\
  FALSE_KWORD\000\
  CLASS_KWORD\000\
  WHILE_KWORD\000\
  IF_KWORD\000\
  ELSE_KWORD\000\
  RETURN_KWORD\000\
  THIS_KWORD\000\
  NULL_KWORD\000\
  NEW_KWORD\000\
  MAIN_KWORD\000\
  READ_KWORD\000\
  PRINT_KWORD\000\
  NEWLINE\000\
  OPAREN\000\
  CPAREN\000\
  OBRACE\000\
  CBRACE\000\
  SEMICOLON\000\
  DOT\000\
  COMMA\000\
  COMMENT_LINE\000\
  COMMENT_OPEN\000\
  COMMENT_CLOSE\000\
  EOF\000\
  "

let yynames_block = "\
  INTEGER_LITERAL\000\
  STRING_LITERAL\000\
  VAR_IDENTIFIER\000\
  CLASS_IDENTIFIER\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'class_main) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'class_decl_list) in
    Obj.repr(
# 84 "jlite_parser.mly"
                            ( (_1, _2) )
# 405 "jlite_parser.ml"
               : Jlite_structs.jlite_program))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'method_main) in
    Obj.repr(
# 88 "jlite_parser.mly"
                            ( ( _2, _4) )
# 413 "jlite_parser.ml"
               : 'class_main))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'varmth_varmth_decl_list) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'method_decl_list) in
    Obj.repr(
# 95 "jlite_parser.mly"
         ( (_2, (fst _4), 
				(List.append (snd _4) _5)))
# 423 "jlite_parser.ml"
               : 'class_decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 100 "jlite_parser.mly"
 ( [] )
# 429 "jlite_parser.ml"
               : 'class_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_class_decl_list) in
    Obj.repr(
# 101 "jlite_parser.mly"
                            ( List.rev _1 )
# 436 "jlite_parser.ml"
               : 'class_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'class_decl) in
    Obj.repr(
# 105 "jlite_parser.mly"
                    ( [_1] )
# 443 "jlite_parser.ml"
               : 'non_zero_class_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_class_decl_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'class_decl) in
    Obj.repr(
# 106 "jlite_parser.mly"
                                       ( _2 :: _1)
# 451 "jlite_parser.ml"
               : 'non_zero_class_decl_list))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'mthd_param_list) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'var_decl_stmt_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 116 "jlite_parser.mly"
   ( { rettype=VoidT; 
				jliteid = SimpleVarId "main"; 
				ir3id =  (SimpleVarId "main"); 
				params=_4; 
				localvars=_7; stmts=_8;
			})
# 465 "jlite_parser.ml"
               : 'method_main))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 125 "jlite_parser.mly"
                ( SimpleVarId _1 )
# 472 "jlite_parser.ml"
               : 'var_id_rule))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 8 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 7 : 'var_id_rule) in
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'mthd_param_list) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'var_decl_stmt_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 135 "jlite_parser.mly"
   ( { rettype=_1; 
				jliteid=_2;
				ir3id= _2;				
				params=_4; 
				localvars=_7; stmts=_8;
			})
# 488 "jlite_parser.ml"
               : 'method_decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 144 "jlite_parser.mly"
 ( [] )
# 494 "jlite_parser.ml"
               : 'method_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_method_decl_list) in
    Obj.repr(
# 145 "jlite_parser.mly"
                             ( List.rev _1 )
# 501 "jlite_parser.ml"
               : 'method_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'method_decl) in
    Obj.repr(
# 149 "jlite_parser.mly"
                    ( [_1] )
# 508 "jlite_parser.ml"
               : 'non_zero_method_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_method_decl_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'method_decl) in
    Obj.repr(
# 150 "jlite_parser.mly"
                                         ( _2 :: _1)
# 516 "jlite_parser.ml"
               : 'non_zero_method_decl_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 154 "jlite_parser.mly"
              (BoolT )
# 522 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 155 "jlite_parser.mly"
                 ( IntT )
# 528 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 156 "jlite_parser.mly"
                 ( StringT )
# 534 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 157 "jlite_parser.mly"
               ( VoidT )
# 540 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 158 "jlite_parser.mly"
                    ( ObjectT _1 )
# 547 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 163 "jlite_parser.mly"
 ( [] )
# 553 "jlite_parser.ml"
               : 'mthd_param_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_mthd_param_list) in
    Obj.repr(
# 164 "jlite_parser.mly"
                            ( List.rev _1 )
# 560 "jlite_parser.ml"
               : 'mthd_param_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 169 "jlite_parser.mly"
  ( [(_1, _2)] )
# 568 "jlite_parser.ml"
               : 'non_zero_mthd_param_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'non_zero_mthd_param_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'type_KWORD) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 171 "jlite_parser.mly"
  ( (_3, _4) :: _1)
# 577 "jlite_parser.ml"
               : 'non_zero_mthd_param_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 177 "jlite_parser.mly"
 ( [] )
# 583 "jlite_parser.ml"
               : 'var_decl_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_var_decl_stmt_list) in
    Obj.repr(
# 178 "jlite_parser.mly"
                               ( List.rev _1 )
# 590 "jlite_parser.ml"
               : 'var_decl_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'var_id_rule) in
    Obj.repr(
# 183 "jlite_parser.mly"
  ( [(_1, _2)] )
# 598 "jlite_parser.ml"
               : 'non_zero_var_decl_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'non_zero_var_decl_stmt_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'var_id_rule) in
    Obj.repr(
# 185 "jlite_parser.mly"
  ( (_2, _3) :: _1)
# 607 "jlite_parser.ml"
               : 'non_zero_var_decl_stmt_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 191 "jlite_parser.mly"
 ( ([],[]) )
# 613 "jlite_parser.ml"
               : 'varmth_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_varmth_decl_list) in
    Obj.repr(
# 193 "jlite_parser.mly"
  ( ((fst _1),(snd _1)) )
# 620 "jlite_parser.ml"
               : 'varmth_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'var_id_rule) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_varmth_decl_list) in
    Obj.repr(
# 198 "jlite_parser.mly"
   ( (((_1, _2) :: (fst _4)), (snd _4)))
# 629 "jlite_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'method_decl) in
    Obj.repr(
# 200 "jlite_parser.mly"
   ( ([], [_1]))
# 636 "jlite_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'var_id_rule) in
    Obj.repr(
# 202 "jlite_parser.mly"
   ( ([(_1, _2)],[]) )
# 644 "jlite_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 207 "jlite_parser.mly"
                                ( ReturnStmt _2 )
# 651 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 208 "jlite_parser.mly"
                             ( ReturnVoidStmt)
# 657 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : 'exp) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'non_zero_stmt_list) in
    let _10 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 211 "jlite_parser.mly"
                                               ( IfStmt (_3,_6,_10) )
# 666 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'exp) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 213 "jlite_parser.mly"
                                    ( WhileStmt (_3,_6) )
# 674 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'var_id_rule) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 214 "jlite_parser.mly"
                                     ( AssignStmt (_1, _3) )
# 682 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'var_id_rule) in
    Obj.repr(
# 216 "jlite_parser.mly"
                                       ( ReadStmt (_3) )
# 689 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'exp) in
    Obj.repr(
# 218 "jlite_parser.mly"
                                ( PrintStmt (_3) )
# 696 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'var_id_rule) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 220 "jlite_parser.mly"
   ( AssignFieldStmt ( FieldAccess ( _1, _3), _5) )
# 705 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'exp_list) in
    Obj.repr(
# 221 "jlite_parser.mly"
                                         ( MdCallStmt (MdCall ( _1, _3)) )
# 713 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 225 "jlite_parser.mly"
 ( [] )
# 719 "jlite_parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_stmt_list) in
    Obj.repr(
# 226 "jlite_parser.mly"
                      ( _1 )
# 726 "jlite_parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 230 "jlite_parser.mly"
            ( [_1] )
# 733 "jlite_parser.ml"
               : 'non_zero_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_stmt_list) in
    Obj.repr(
# 231 "jlite_parser.mly"
                             ( _1 :: _2)
# 741 "jlite_parser.ml"
               : 'non_zero_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'bexp) in
    Obj.repr(
# 237 "jlite_parser.mly"
        ( _1 )
# 748 "jlite_parser.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 238 "jlite_parser.mly"
         ( _1 )
# 755 "jlite_parser.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'sexp) in
    Obj.repr(
# 239 "jlite_parser.mly"
         ( _1  )
# 762 "jlite_parser.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'bexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'conj) in
    Obj.repr(
# 243 "jlite_parser.mly"
              ( BinaryExp (BooleanOp "||", _1, _3) )
# 770 "jlite_parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'conj) in
    Obj.repr(
# 244 "jlite_parser.mly"
           ( _1 )
# 777 "jlite_parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'conj) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'rexp) in
    Obj.repr(
# 248 "jlite_parser.mly"
                ( BinaryExp (BooleanOp "&&", _1, _3) )
# 785 "jlite_parser.ml"
               : 'conj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'rexp) in
    Obj.repr(
# 249 "jlite_parser.mly"
           ( _1 )
# 792 "jlite_parser.ml"
               : 'conj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 252 "jlite_parser.mly"
               ( BinaryExp (RelationalOp "==", _1, _3) )
# 800 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 253 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp "!=", _1, _3) )
# 808 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 254 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp ">", _1, _3) )
# 816 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 255 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp ">=", _1, _3) )
# 824 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 256 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp "<", _1, _3) )
# 832 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 257 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp "<=", _1, _3) )
# 840 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'bgrd) in
    Obj.repr(
# 258 "jlite_parser.mly"
           ( _1)
# 847 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'bgrd) in
    Obj.repr(
# 262 "jlite_parser.mly"
            ( UnaryExp (UnaryOp "!", _2) )
# 854 "jlite_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    Obj.repr(
# 263 "jlite_parser.mly"
               ( BoolLiteral (true) )
# 860 "jlite_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    Obj.repr(
# 264 "jlite_parser.mly"
                ( BoolLiteral (false) )
# 866 "jlite_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 265 "jlite_parser.mly"
           ( _1)
# 873 "jlite_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 269 "jlite_parser.mly"
                 ( BinaryExp (AritmeticOp "+",_1,_3) )
# 881 "jlite_parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 270 "jlite_parser.mly"
                    ( BinaryExp (AritmeticOp "-",_1,_3) )
# 889 "jlite_parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 271 "jlite_parser.mly"
           ( _1 )
# 896 "jlite_parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 275 "jlite_parser.mly"
                   ( BinaryExp (AritmeticOp "*",_1,_3) )
# 904 "jlite_parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 276 "jlite_parser.mly"
                    ( BinaryExp (AritmeticOp "+",_1,_3) )
# 912 "jlite_parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 277 "jlite_parser.mly"
          ( _1 )
# 919 "jlite_parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 281 "jlite_parser.mly"
                 ( IntLiteral ( _1 ) )
# 926 "jlite_parser.ml"
               : 'ftr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 282 "jlite_parser.mly"
              ( UnaryExp (UnaryOp "-", _2) )
# 933 "jlite_parser.ml"
               : 'ftr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 283 "jlite_parser.mly"
          ( _1 )
# 940 "jlite_parser.ml"
               : 'ftr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 287 "jlite_parser.mly"
                ( StringLiteral ( _1 ) )
# 947 "jlite_parser.ml"
               : 'sexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 288 "jlite_parser.mly"
          ( _1 )
# 954 "jlite_parser.ml"
               : 'sexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 292 "jlite_parser.mly"
                        ( FieldAccess ( _1, _3) )
# 962 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'exp_list) in
    Obj.repr(
# 293 "jlite_parser.mly"
                                ( MdCall ( _1, _3) )
# 970 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 294 "jlite_parser.mly"
                   ( ThisWord )
# 976 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 295 "jlite_parser.mly"
                 ( NullWord )
# 982 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 296 "jlite_parser.mly"
                   ( Var _1 )
# 989 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    Obj.repr(
# 297 "jlite_parser.mly"
                                            ( ObjectCreate _2 )
# 996 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 298 "jlite_parser.mly"
                      ( _2 )
# 1003 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 301 "jlite_parser.mly"
 ( [] )
# 1009 "jlite_parser.ml"
               : 'exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_exp_list) in
    Obj.repr(
# 302 "jlite_parser.mly"
                     ( List.rev _1 )
# 1016 "jlite_parser.ml"
               : 'exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 306 "jlite_parser.mly"
           ( [_1] )
# 1023 "jlite_parser.ml"
               : 'non_zero_exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'non_zero_exp_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 307 "jlite_parser.mly"
                                ( _3 :: _1)
# 1031 "jlite_parser.ml"
               : 'non_zero_exp_list))
(* Entry input *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let input (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Jlite_structs.jlite_program)
;;
