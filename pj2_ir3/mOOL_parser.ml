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
  | SUPER_KWORD
  | NEW_KWORD
  | MAIN_KWORD
  | READ_KWORD
  | PRINT_KWORD
  | PRIVATE_KWORD
  | EXTENDS_KWORD
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
# 8 "mOOL_parser.mly"


  open Printf
  open MOOL_structs

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
  
# 75 "mOOL_parser.ml"
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
  284 (* SUPER_KWORD *);
  285 (* NEW_KWORD *);
  286 (* MAIN_KWORD *);
  287 (* READ_KWORD *);
  288 (* PRINT_KWORD *);
  289 (* PRIVATE_KWORD *);
  290 (* EXTENDS_KWORD *);
  295 (* NEWLINE *);
  296 (* OPAREN *);
  297 (* CPAREN *);
  298 (* OBRACE *);
  299 (* CBRACE *);
  300 (* SEMICOLON *);
  301 (* DOT *);
  302 (* COMMA *);
  303 (* COMMENT_LINE *);
  304 (* COMMENT_OPEN *);
  305 (* COMMENT_CLOSE *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  291 (* INTEGER_LITERAL *);
  292 (* STRING_LITERAL *);
  293 (* VAR_IDENTIFIER *);
  294 (* CLASS_IDENTIFIER *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\005\000\005\000\006\000\003\000\003\000\009\000\
\009\000\010\000\010\000\004\000\014\000\015\000\015\000\008\000\
\008\000\017\000\017\000\016\000\016\000\016\000\016\000\016\000\
\011\000\011\000\018\000\018\000\012\000\012\000\019\000\019\000\
\007\000\007\000\020\000\020\000\020\000\020\000\021\000\021\000\
\021\000\021\000\021\000\021\000\021\000\021\000\021\000\025\000\
\025\000\013\000\013\000\026\000\022\000\022\000\022\000\027\000\
\027\000\030\000\030\000\031\000\031\000\031\000\031\000\031\000\
\031\000\031\000\032\000\032\000\032\000\032\000\028\000\028\000\
\028\000\033\000\033\000\033\000\034\000\034\000\034\000\029\000\
\029\000\023\000\023\000\023\000\023\000\023\000\023\000\023\000\
\023\000\023\000\024\000\024\000\035\000\035\000\000\000"

let yylen = "\002\000\
\002\000\005\000\000\000\002\000\007\000\000\000\001\000\001\000\
\002\000\000\000\001\000\009\000\001\000\009\000\010\000\000\000\
\001\000\001\000\002\000\001\000\001\000\001\000\001\000\001\000\
\000\000\001\000\002\000\004\000\000\000\001\000\003\000\004\000\
\000\000\001\000\004\000\005\000\001\000\003\000\003\000\002\000\
\011\000\007\000\004\000\005\000\005\000\006\000\005\000\000\000\
\001\000\001\000\002\000\003\000\001\000\001\000\001\000\003\000\
\001\000\003\000\001\000\003\000\003\000\003\000\003\000\003\000\
\003\000\001\000\002\000\001\000\001\000\001\000\003\000\003\000\
\001\000\003\000\003\000\001\000\001\000\002\000\001\000\001\000\
\001\000\003\000\004\000\001\000\001\000\001\000\001\000\004\000\
\004\000\003\000\000\000\001\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\095\000\000\000\000\000\000\000\001\000\
\008\000\000\000\000\000\000\000\009\000\000\000\000\000\000\000\
\000\000\000\000\002\000\004\000\000\000\000\000\021\000\020\000\
\022\000\023\000\011\000\024\000\000\000\000\000\037\000\000\000\
\034\000\000\000\000\000\000\000\000\000\000\000\018\000\000\000\
\000\000\000\000\013\000\000\000\000\000\027\000\000\000\005\000\
\000\000\000\000\019\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\035\000\000\000\000\000\000\000\
\028\000\000\000\036\000\000\000\000\000\000\000\000\000\084\000\
\085\000\086\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\068\000\069\000\077\000\080\000\040\000\087\000\
\000\000\000\000\000\000\000\000\055\000\000\000\059\000\066\000\
\000\000\076\000\000\000\000\000\000\000\000\000\000\000\012\000\
\000\000\051\000\000\000\000\000\031\000\000\000\000\000\000\000\
\000\000\000\000\000\000\078\000\000\000\067\000\039\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\090\000\000\000\093\000\000\000\000\000\000\000\032\000\
\000\000\000\000\000\000\000\000\000\000\082\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\058\000\074\000\075\000\088\000\000\000\000\000\000\000\
\043\000\000\000\000\000\000\000\000\000\014\000\000\000\000\000\
\083\000\044\000\045\000\047\000\094\000\000\000\015\000\000\000\
\000\000\046\000\042\000\000\000\000\000\000\000\000\000\041\000"

let yydgoto = "\002\000\
\004\000\005\000\008\000\015\000\017\000\009\000\029\000\037\000\
\010\000\030\000\034\000\062\000\079\000\096\000\031\000\032\000\
\041\000\036\000\064\000\033\000\081\000\148\000\123\000\149\000\
\000\000\000\000\099\000\100\000\101\000\102\000\103\000\104\000\
\105\000\106\000\150\000"

let yysindex = "\042\000\
\026\255\000\000\013\255\000\000\034\255\017\255\023\255\000\000\
\000\000\034\255\054\255\040\255\000\000\055\255\066\255\057\255\
\081\255\077\255\000\000\000\000\185\255\063\255\000\000\000\000\
\000\000\000\000\000\000\000\000\185\255\063\255\000\000\087\255\
\000\000\091\255\087\255\088\255\090\255\063\255\000\000\087\255\
\185\255\087\255\000\000\235\254\098\255\000\000\063\255\000\000\
\087\255\101\255\000\000\245\254\063\255\185\255\063\255\087\255\
\102\255\063\255\185\255\154\255\000\000\131\000\087\255\063\255\
\000\000\164\255\000\000\108\255\174\255\177\255\017\000\000\000\
\000\000\000\000\168\255\179\255\182\255\047\000\172\255\202\255\
\131\000\238\254\181\255\087\255\178\255\063\255\075\000\075\000\
\079\000\109\000\000\000\000\000\000\000\000\000\000\000\000\000\
\186\255\042\255\217\255\207\000\000\000\242\255\000\000\000\000\
\009\255\000\000\214\255\087\255\075\000\222\255\223\255\000\000\
\075\000\000\000\075\000\087\255\000\000\221\255\063\255\131\000\
\225\255\227\255\042\255\000\000\042\255\000\000\000\000\075\000\
\087\255\109\255\079\000\079\000\079\000\079\000\079\000\079\000\
\079\000\079\000\109\255\079\000\079\000\228\255\232\255\236\255\
\170\000\000\000\234\255\000\000\239\255\235\255\013\000\000\000\
\131\000\244\255\243\255\246\255\248\255\000\000\042\255\207\000\
\242\255\009\255\009\255\056\255\056\255\056\255\056\255\056\255\
\056\255\000\000\000\000\000\000\000\000\251\255\253\255\042\255\
\000\000\254\255\075\000\075\000\247\255\000\000\131\000\131\000\
\000\000\000\000\000\000\000\000\000\000\004\000\000\000\007\000\
\008\000\000\000\000\000\023\000\014\000\131\000\012\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\058\001\000\000\000\000\000\000\
\000\000\059\001\000\000\026\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\027\000\028\000\000\000\000\000\
\000\000\000\000\000\000\000\000\029\000\000\000\000\000\000\000\
\000\000\000\000\000\000\030\000\000\000\000\000\000\000\000\000\
\035\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\028\000\036\000\147\000\000\000\
\000\000\028\000\000\000\000\000\000\000\000\000\000\000\163\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\049\255\
\037\000\000\000\000\000\000\000\000\000\147\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\152\255\024\255\025\255\000\000\153\255\000\000\000\000\
\226\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\045\000\000\000\000\000\000\000\147\000\000\000\
\000\000\000\000\166\255\000\000\251\254\000\000\000\000\045\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\048\000\065\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\152\255\000\000\
\167\255\238\255\250\255\004\255\052\255\230\255\080\000\086\000\
\106\000\000\000\000\000\000\000\000\000\000\000\000\000\180\255\
\000\000\075\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\080\001\000\000\000\000\
\000\000\241\255\090\000\175\255\176\255\224\255\003\000\061\000\
\000\000\000\000\000\000\150\000\000\000\189\255\203\255\221\000\
\000\000\000\000\000\000\088\001\000\000\222\000\216\000\010\001\
\231\255\169\255\000\000"

let yytablesize = 483
let yytable = "\044\000\
\114\000\124\000\046\000\097\000\120\000\070\000\070\000\050\000\
\082\000\052\000\111\000\140\000\141\000\038\000\060\000\060\000\
\057\000\098\000\053\000\121\000\122\000\115\000\054\000\065\000\
\098\000\038\000\116\000\082\000\058\000\080\000\083\000\039\000\
\059\000\098\000\098\000\070\000\125\000\153\000\070\000\154\000\
\070\000\144\000\001\000\051\000\060\000\147\000\003\000\060\000\
\080\000\060\000\006\000\118\000\171\000\172\000\007\000\098\000\
\131\000\132\000\011\000\098\000\012\000\098\000\061\000\061\000\
\053\000\054\000\082\000\053\000\054\000\053\000\054\000\014\000\
\181\000\016\000\098\000\143\000\159\000\023\000\024\000\025\000\
\026\000\128\000\035\000\151\000\018\000\159\000\129\000\080\000\
\087\000\040\000\042\000\176\000\061\000\087\000\020\000\061\000\
\158\000\061\000\049\000\082\000\028\000\040\000\192\000\193\000\
\082\000\162\000\163\000\056\000\019\000\082\000\089\000\189\000\
\190\000\035\000\083\000\063\000\022\000\199\000\035\000\083\000\
\080\000\090\000\021\000\043\000\084\000\098\000\098\000\091\000\
\092\000\082\000\082\000\045\000\048\000\047\000\072\000\073\000\
\074\000\075\000\110\000\055\000\053\000\058\000\060\000\093\000\
\082\000\043\000\063\000\066\000\078\000\086\000\080\000\080\000\
\079\000\079\000\079\000\079\000\079\000\079\000\079\000\079\000\
\079\000\079\000\070\000\070\000\057\000\080\000\079\000\079\000\
\079\000\079\000\079\000\079\000\079\000\079\000\079\000\079\000\
\079\000\079\000\056\000\063\000\089\000\089\000\089\000\089\000\
\089\000\089\000\089\000\089\000\089\000\089\000\089\000\089\000\
\070\000\057\000\068\000\070\000\057\000\070\000\057\000\023\000\
\024\000\025\000\026\000\061\000\085\000\107\000\079\000\056\000\
\067\000\079\000\056\000\079\000\056\000\087\000\112\000\113\000\
\088\000\027\000\108\000\119\000\089\000\109\000\028\000\089\000\
\117\000\089\000\073\000\073\000\130\000\127\000\073\000\073\000\
\073\000\073\000\073\000\073\000\073\000\073\000\071\000\071\000\
\062\000\062\000\071\000\071\000\071\000\071\000\071\000\071\000\
\071\000\071\000\072\000\072\000\139\000\142\000\072\000\072\000\
\072\000\072\000\072\000\072\000\072\000\072\000\145\000\146\000\
\152\000\155\000\073\000\156\000\173\000\073\000\062\000\073\000\
\174\000\062\000\089\000\062\000\175\000\177\000\071\000\178\000\
\179\000\071\000\180\000\071\000\183\000\090\000\182\000\184\000\
\185\000\191\000\072\000\091\000\092\000\072\000\186\000\072\000\
\187\000\188\000\072\000\073\000\074\000\075\000\197\000\194\000\
\089\000\195\000\196\000\093\000\094\000\043\000\200\000\198\000\
\078\000\006\000\007\000\090\000\095\000\023\000\024\000\025\000\
\026\000\091\000\092\000\003\000\025\000\033\000\026\000\016\000\
\072\000\073\000\074\000\075\000\089\000\017\000\038\000\050\000\
\089\000\093\000\094\000\043\000\028\000\091\000\078\000\090\000\
\092\000\013\000\063\000\063\000\157\000\091\000\092\000\161\000\
\064\000\064\000\170\000\126\000\072\000\073\000\074\000\075\000\
\072\000\073\000\074\000\075\000\000\000\093\000\094\000\043\000\
\000\000\093\000\078\000\043\000\065\000\065\000\078\000\000\000\
\063\000\090\000\000\000\063\000\000\000\063\000\064\000\091\000\
\092\000\064\000\000\000\064\000\000\000\000\000\072\000\073\000\
\074\000\075\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\043\000\065\000\000\000\078\000\065\000\000\000\065\000\
\069\000\070\000\000\000\071\000\072\000\073\000\074\000\075\000\
\000\000\076\000\077\000\000\000\000\000\000\000\000\000\043\000\
\029\000\029\000\078\000\029\000\029\000\029\000\029\000\029\000\
\000\000\029\000\029\000\000\000\000\000\000\000\000\000\029\000\
\030\000\030\000\029\000\030\000\030\000\030\000\030\000\030\000\
\000\000\030\000\030\000\072\000\073\000\074\000\075\000\030\000\
\000\000\000\000\030\000\000\000\000\000\000\000\043\000\131\000\
\132\000\078\000\000\000\133\000\134\000\135\000\136\000\137\000\
\138\000\160\000\000\000\000\000\164\000\165\000\166\000\167\000\
\168\000\169\000\160\000"

let yycheck = "\032\000\
\081\000\089\000\035\000\071\000\086\000\011\001\012\001\040\000\
\062\000\042\000\078\000\003\001\004\001\029\000\011\001\012\001\
\049\000\071\000\040\001\087\000\088\000\040\001\044\001\056\000\
\078\000\041\000\045\001\081\000\040\001\062\000\063\000\029\000\
\044\001\087\000\088\000\041\001\090\000\119\000\044\001\120\000\
\046\001\109\000\001\000\041\000\041\001\113\000\021\001\044\001\
\081\000\046\001\038\001\084\000\140\000\141\000\021\001\109\000\
\001\001\002\001\042\001\113\000\038\001\115\000\011\001\012\001\
\041\001\041\001\120\000\044\001\044\001\046\001\046\001\018\001\
\153\000\034\001\128\000\108\000\130\000\015\001\016\001\017\001\
\018\001\040\001\022\000\116\000\030\001\139\000\045\001\120\000\
\040\001\029\000\030\000\145\000\041\001\045\001\038\001\044\001\
\129\000\046\001\038\000\153\000\038\001\041\000\183\000\184\000\
\040\001\131\000\132\000\047\000\043\001\045\001\002\001\179\000\
\180\000\053\000\040\001\055\000\040\001\198\000\058\000\045\001\
\153\000\013\001\042\001\037\001\064\000\179\000\180\000\019\001\
\020\001\183\000\184\000\041\001\043\001\046\001\026\001\027\001\
\028\001\029\001\078\000\042\001\040\001\040\001\053\000\035\001\
\198\000\037\001\086\000\058\000\040\001\042\001\183\000\184\000\
\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\012\001\198\000\001\001\002\001\
\003\001\004\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\012\001\119\000\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\009\001\010\001\011\001\012\001\
\041\001\041\001\041\001\044\001\044\001\046\001\046\001\015\001\
\016\001\017\001\018\001\054\000\041\001\038\001\041\001\041\001\
\059\000\044\001\044\001\046\001\046\001\040\001\043\001\014\001\
\040\001\033\001\040\001\042\001\041\001\040\001\038\001\044\001\
\044\001\046\001\001\001\002\001\012\001\044\001\005\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\001\001\002\001\
\011\001\012\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\001\001\002\001\011\001\040\001\005\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\041\001\041\001\
\044\001\041\001\041\001\041\001\041\001\044\001\041\001\046\001\
\041\001\044\001\002\001\046\001\041\001\044\001\041\001\041\001\
\046\001\044\001\014\001\046\001\042\001\013\001\043\001\042\001\
\041\001\043\001\041\001\019\001\020\001\044\001\044\001\046\001\
\044\001\044\001\026\001\027\001\028\001\029\001\024\001\044\001\
\002\001\043\001\043\001\035\001\036\001\037\001\043\001\042\001\
\040\001\000\000\000\000\013\001\044\001\015\001\016\001\017\001\
\018\001\019\001\020\001\042\001\041\001\043\001\041\001\043\001\
\026\001\027\001\028\001\029\001\002\001\043\001\043\001\043\001\
\002\001\035\001\036\001\037\001\038\001\041\001\040\001\013\001\
\041\001\010\000\011\001\012\001\128\000\019\001\020\001\130\000\
\011\001\012\001\139\000\090\000\026\001\027\001\028\001\029\001\
\026\001\027\001\028\001\029\001\255\255\035\001\036\001\037\001\
\255\255\035\001\040\001\037\001\011\001\012\001\040\001\255\255\
\041\001\013\001\255\255\044\001\255\255\046\001\041\001\019\001\
\020\001\044\001\255\255\046\001\255\255\255\255\026\001\027\001\
\028\001\029\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\037\001\041\001\255\255\040\001\044\001\255\255\046\001\
\022\001\023\001\255\255\025\001\026\001\027\001\028\001\029\001\
\255\255\031\001\032\001\255\255\255\255\255\255\255\255\037\001\
\022\001\023\001\040\001\025\001\026\001\027\001\028\001\029\001\
\255\255\031\001\032\001\255\255\255\255\255\255\255\255\037\001\
\022\001\023\001\040\001\025\001\026\001\027\001\028\001\029\001\
\255\255\031\001\032\001\026\001\027\001\028\001\029\001\037\001\
\255\255\255\255\040\001\255\255\255\255\255\255\037\001\001\001\
\002\001\040\001\255\255\005\001\006\001\007\001\008\001\009\001\
\010\001\130\000\255\255\255\255\133\000\134\000\135\000\136\000\
\137\000\138\000\139\000"

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
  SUPER_KWORD\000\
  NEW_KWORD\000\
  MAIN_KWORD\000\
  READ_KWORD\000\
  PRINT_KWORD\000\
  PRIVATE_KWORD\000\
  EXTENDS_KWORD\000\
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
# 87 "mOOL_parser.mly"
                            ( (_1, _2) )
# 446 "mOOL_parser.ml"
               : MOOL_structs.mOOL_program))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'method_main) in
    Obj.repr(
# 91 "mOOL_parser.mly"
                            ( ( _2, _4) )
# 454 "mOOL_parser.ml"
               : 'class_main))
; (fun __caml_parser_env ->
    Obj.repr(
# 95 "mOOL_parser.mly"
 ( None )
# 460 "mOOL_parser.ml"
               : 'inheritence))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 96 "mOOL_parser.mly"
                                  ( Some _2 )
# 467 "mOOL_parser.ml"
               : 'inheritence))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'inheritence) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'varmth_varmth_decl_list) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'method_decl_list) in
    Obj.repr(
# 103 "mOOL_parser.mly"
         ( (_2, _3,(fst _5), 
				(List.append (snd _5) _6)))
# 478 "mOOL_parser.ml"
               : 'class_decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 108 "mOOL_parser.mly"
 ( [] )
# 484 "mOOL_parser.ml"
               : 'class_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_class_decl_list) in
    Obj.repr(
# 109 "mOOL_parser.mly"
                            ( List.rev _1 )
# 491 "mOOL_parser.ml"
               : 'class_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'class_decl) in
    Obj.repr(
# 114 "mOOL_parser.mly"
                    ( [_1] )
# 498 "mOOL_parser.ml"
               : 'non_zero_class_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_class_decl_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'class_decl) in
    Obj.repr(
# 115 "mOOL_parser.mly"
                                       ( _2 :: _1)
# 506 "mOOL_parser.ml"
               : 'non_zero_class_decl_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 120 "mOOL_parser.mly"
 (  Public )
# 512 "mOOL_parser.ml"
               : 'modifier))
; (fun __caml_parser_env ->
    Obj.repr(
# 121 "mOOL_parser.mly"
                 ( Private )
# 518 "mOOL_parser.ml"
               : 'modifier))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'mthd_param_list) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'var_decl_stmt_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 131 "mOOL_parser.mly"
   ( { 
				modifier = Public;
				rettype = VoidT; 
				mOOLid = SimpleVarId "main"; 
				ir3id = (SimpleVarId "main"); 
				params = _4; 
				localvars = _7; stmts = _8;
			})
# 534 "mOOL_parser.ml"
               : 'method_main))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 142 "mOOL_parser.mly"
                (  SimpleVarId _1 )
# 541 "mOOL_parser.ml"
               : 'var_id_rule))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 8 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 7 : 'var_id_rule) in
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'mthd_param_list) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'var_decl_stmt_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 152 "mOOL_parser.mly"
   ( { 
				modifier=Public;
				rettype=_1; 
				mOOLid=_2;
				ir3id= _2;				
				params=_4; 
				localvars=_7; stmts=_8;
			})
# 559 "mOOL_parser.ml"
               : 'method_decl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 9 : 'modifier) in
    let _2 = (Parsing.peek_val __caml_parser_env 8 : 'type_KWORD) in
    let _3 = (Parsing.peek_val __caml_parser_env 7 : 'var_id_rule) in
    let _5 = (Parsing.peek_val __caml_parser_env 5 : 'mthd_param_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'var_decl_stmt_list) in
    let _9 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 168 "mOOL_parser.mly"
   ( { 
				modifier=_1;
				rettype=_2; 
				mOOLid=_3;
				ir3id= _3;				
				params=_5; 
				localvars=_8; stmts=_9;
			})
# 578 "mOOL_parser.ml"
               : 'method_decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 179 "mOOL_parser.mly"
 ( [] )
# 584 "mOOL_parser.ml"
               : 'method_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_method_decl_list) in
    Obj.repr(
# 180 "mOOL_parser.mly"
                             ( List.rev _1 )
# 591 "mOOL_parser.ml"
               : 'method_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'method_decl) in
    Obj.repr(
# 184 "mOOL_parser.mly"
                    ( [_1] )
# 598 "mOOL_parser.ml"
               : 'non_zero_method_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_method_decl_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'method_decl) in
    Obj.repr(
# 185 "mOOL_parser.mly"
                                         ( _2 :: _1)
# 606 "mOOL_parser.ml"
               : 'non_zero_method_decl_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 189 "mOOL_parser.mly"
              ( BoolT )
# 612 "mOOL_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 190 "mOOL_parser.mly"
                 ( IntT )
# 618 "mOOL_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 191 "mOOL_parser.mly"
                 ( StringT )
# 624 "mOOL_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 192 "mOOL_parser.mly"
               ( VoidT )
# 630 "mOOL_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 193 "mOOL_parser.mly"
                    (  ObjectT _1 )
# 637 "mOOL_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 198 "mOOL_parser.mly"
 ( [] )
# 643 "mOOL_parser.ml"
               : 'mthd_param_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_mthd_param_list) in
    Obj.repr(
# 199 "mOOL_parser.mly"
                            ( List.rev _1 )
# 650 "mOOL_parser.ml"
               : 'mthd_param_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 204 "mOOL_parser.mly"
  ( [(_1, _2)] )
# 658 "mOOL_parser.ml"
               : 'non_zero_mthd_param_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'non_zero_mthd_param_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'type_KWORD) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 206 "mOOL_parser.mly"
  ( (_3, _4) :: _1)
# 667 "mOOL_parser.ml"
               : 'non_zero_mthd_param_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 212 "mOOL_parser.mly"
 ( [] )
# 673 "mOOL_parser.ml"
               : 'var_decl_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_var_decl_stmt_list) in
    Obj.repr(
# 213 "mOOL_parser.mly"
                               ( List.rev _1 )
# 680 "mOOL_parser.ml"
               : 'var_decl_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'var_id_rule) in
    Obj.repr(
# 218 "mOOL_parser.mly"
  ( [(_1, _2)] )
# 688 "mOOL_parser.ml"
               : 'non_zero_var_decl_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'non_zero_var_decl_stmt_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'var_id_rule) in
    Obj.repr(
# 220 "mOOL_parser.mly"
  ( (_2, _3) :: _1)
# 697 "mOOL_parser.ml"
               : 'non_zero_var_decl_stmt_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 226 "mOOL_parser.mly"
 ( ([],[]) )
# 703 "mOOL_parser.ml"
               : 'varmth_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_varmth_decl_list) in
    Obj.repr(
# 228 "mOOL_parser.mly"
  ( ((fst _1),(snd _1)) )
# 710 "mOOL_parser.ml"
               : 'varmth_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'var_id_rule) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_varmth_decl_list) in
    Obj.repr(
# 233 "mOOL_parser.mly"
   ( (((Public,(_1, _2)) :: (fst _4)), (snd _4)))
# 719 "mOOL_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'modifier) in
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'type_KWORD) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'var_id_rule) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_varmth_decl_list) in
    Obj.repr(
# 235 "mOOL_parser.mly"
   ( (((_1,(_2, _3)) :: (fst _5)), (snd _5)))
# 729 "mOOL_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'method_decl) in
    Obj.repr(
# 237 "mOOL_parser.mly"
   ( ([], [_1]))
# 736 "mOOL_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'var_id_rule) in
    Obj.repr(
# 239 "mOOL_parser.mly"
   ( ([(Public,(_1, _2))],[]) )
# 744 "mOOL_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 244 "mOOL_parser.mly"
                                ( ReturnStmt _2 )
# 751 "mOOL_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 245 "mOOL_parser.mly"
                             ( ReturnVoidStmt)
# 757 "mOOL_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : 'exp) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'non_zero_stmt_list) in
    let _10 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 248 "mOOL_parser.mly"
                                               ( IfStmt (_3,_6,_10) )
# 766 "mOOL_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'exp) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 250 "mOOL_parser.mly"
                                    ( WhileStmt (_3,_6) )
# 774 "mOOL_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'var_id_rule) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 251 "mOOL_parser.mly"
                                     ( AssignStmt (_1, _3) )
# 782 "mOOL_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'var_id_rule) in
    Obj.repr(
# 253 "mOOL_parser.mly"
                                       ( ReadStmt (_3) )
# 789 "mOOL_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'exp) in
    Obj.repr(
# 255 "mOOL_parser.mly"
                                ( PrintStmt (_3) )
# 796 "mOOL_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'var_id_rule) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 257 "mOOL_parser.mly"
   ( AssignFieldStmt ( FieldAccess ( _1, _3), _5) )
# 805 "mOOL_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'exp_list) in
    Obj.repr(
# 258 "mOOL_parser.mly"
                                         ( MdCallStmt (MdCall ( _1, _3)) )
# 813 "mOOL_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 262 "mOOL_parser.mly"
 ( [] )
# 819 "mOOL_parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_stmt_list) in
    Obj.repr(
# 263 "mOOL_parser.mly"
                      ( _1 )
# 826 "mOOL_parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 267 "mOOL_parser.mly"
            ( [_1] )
# 833 "mOOL_parser.ml"
               : 'non_zero_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_stmt_list) in
    Obj.repr(
# 268 "mOOL_parser.mly"
                             ( _1 :: _2)
# 841 "mOOL_parser.ml"
               : 'non_zero_stmt_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 274 "mOOL_parser.mly"
                                ( Some _2 )
# 848 "mOOL_parser.ml"
               : 'cast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'bexp) in
    Obj.repr(
# 279 "mOOL_parser.mly"
        ( _1 )
# 855 "mOOL_parser.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 280 "mOOL_parser.mly"
         ( _1 )
# 862 "mOOL_parser.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'sexp) in
    Obj.repr(
# 281 "mOOL_parser.mly"
         ( _1  )
# 869 "mOOL_parser.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'bexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'conj) in
    Obj.repr(
# 285 "mOOL_parser.mly"
              ( BinaryExp (BooleanOp "||", _1, _3) )
# 877 "mOOL_parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'conj) in
    Obj.repr(
# 286 "mOOL_parser.mly"
           ( _1 )
# 884 "mOOL_parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'conj) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'rexp) in
    Obj.repr(
# 290 "mOOL_parser.mly"
                ( BinaryExp (BooleanOp "&&", _1, _3) )
# 892 "mOOL_parser.ml"
               : 'conj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'rexp) in
    Obj.repr(
# 291 "mOOL_parser.mly"
           ( _1 )
# 899 "mOOL_parser.ml"
               : 'conj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 294 "mOOL_parser.mly"
               ( BinaryExp (RelationalOp "==", _1, _3) )
# 907 "mOOL_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 295 "mOOL_parser.mly"
                 ( BinaryExp (RelationalOp "!=", _1, _3) )
# 915 "mOOL_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 296 "mOOL_parser.mly"
                 ( BinaryExp (RelationalOp ">", _1, _3) )
# 923 "mOOL_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 297 "mOOL_parser.mly"
                 ( BinaryExp (RelationalOp ">=", _1, _3) )
# 931 "mOOL_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 298 "mOOL_parser.mly"
                 ( BinaryExp (RelationalOp "<", _1, _3) )
# 939 "mOOL_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 299 "mOOL_parser.mly"
                 ( BinaryExp (RelationalOp "<=", _1, _3) )
# 947 "mOOL_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'bgrd) in
    Obj.repr(
# 300 "mOOL_parser.mly"
           ( _1)
# 954 "mOOL_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'bgrd) in
    Obj.repr(
# 304 "mOOL_parser.mly"
            ( UnaryExp (UnaryOp "!", _2) )
# 961 "mOOL_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    Obj.repr(
# 305 "mOOL_parser.mly"
               ( BoolLiteral (true) )
# 967 "mOOL_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    Obj.repr(
# 306 "mOOL_parser.mly"
                ( BoolLiteral (false) )
# 973 "mOOL_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 307 "mOOL_parser.mly"
           ( _1)
# 980 "mOOL_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 311 "mOOL_parser.mly"
                 ( BinaryExp (AritmeticOp "+",_1,_3) )
# 988 "mOOL_parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 312 "mOOL_parser.mly"
                    ( BinaryExp (AritmeticOp "-",_1,_3) )
# 996 "mOOL_parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 313 "mOOL_parser.mly"
           ( _1 )
# 1003 "mOOL_parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 317 "mOOL_parser.mly"
                   ( BinaryExp (AritmeticOp "*",_1,_3) )
# 1011 "mOOL_parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 318 "mOOL_parser.mly"
                    ( BinaryExp (AritmeticOp "+",_1,_3) )
# 1019 "mOOL_parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 319 "mOOL_parser.mly"
          ( _1 )
# 1026 "mOOL_parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 323 "mOOL_parser.mly"
                 ( IntLiteral ( _1 ) )
# 1033 "mOOL_parser.ml"
               : 'ftr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 324 "mOOL_parser.mly"
              ( UnaryExp (UnaryOp "-", _2) )
# 1040 "mOOL_parser.ml"
               : 'ftr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 325 "mOOL_parser.mly"
          ( _1 )
# 1047 "mOOL_parser.ml"
               : 'ftr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 329 "mOOL_parser.mly"
                ( StringLiteral ( _1 ) )
# 1054 "mOOL_parser.ml"
               : 'sexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 330 "mOOL_parser.mly"
          ( _1 )
# 1061 "mOOL_parser.ml"
               : 'sexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 334 "mOOL_parser.mly"
                        ( FieldAccess ( _1, _3) )
# 1069 "mOOL_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'exp_list) in
    Obj.repr(
# 335 "mOOL_parser.mly"
                                ( MdCall ( _1, _3) )
# 1077 "mOOL_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 336 "mOOL_parser.mly"
                   ( ThisWord )
# 1083 "mOOL_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 337 "mOOL_parser.mly"
                 ( NullWord )
# 1089 "mOOL_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 338 "mOOL_parser.mly"
                                         ( SuperWord)
# 1095 "mOOL_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 339 "mOOL_parser.mly"
                   ( Var _1 )
# 1102 "mOOL_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    Obj.repr(
# 340 "mOOL_parser.mly"
                                            ( ObjectCreate _2 )
# 1109 "mOOL_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 341 "mOOL_parser.mly"
                                 ( CastExp ( _4, _2) )
# 1117 "mOOL_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 342 "mOOL_parser.mly"
                      ( _2 )
# 1124 "mOOL_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 346 "mOOL_parser.mly"
 ( [] )
# 1130 "mOOL_parser.ml"
               : 'exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_exp_list) in
    Obj.repr(
# 347 "mOOL_parser.mly"
                     ( List.rev _1 )
# 1137 "mOOL_parser.ml"
               : 'exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 351 "mOOL_parser.mly"
           ( [_1] )
# 1144 "mOOL_parser.ml"
               : 'non_zero_exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'non_zero_exp_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 352 "mOOL_parser.mly"
                                ( _3 :: _1)
# 1152 "mOOL_parser.ml"
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : MOOL_structs.mOOL_program)
;;
# 355 "mOOL_parser.mly"

# 1179 "mOOL_parser.ml"
