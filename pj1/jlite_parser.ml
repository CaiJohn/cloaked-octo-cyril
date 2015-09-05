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
  
# 74 "jlite_parser.ml"
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
  288 (* PRIVATE_KWORD *);
  289 (* EXTENDS_KWORD *);
  294 (* NEWLINE *);
  295 (* OPAREN *);
  296 (* CPAREN *);
  297 (* OBRACE *);
  298 (* CBRACE *);
  299 (* SEMICOLON *);
  300 (* DOT *);
  301 (* COMMA *);
  302 (* COMMENT_LINE *);
  303 (* COMMENT_OPEN *);
  304 (* COMMENT_CLOSE *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  290 (* INTEGER_LITERAL *);
  291 (* STRING_LITERAL *);
  292 (* VAR_IDENTIFIER *);
  293 (* CLASS_IDENTIFIER *);
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
\023\000\024\000\024\000\035\000\035\000\000\000"

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
\001\000\003\000\004\000\001\000\001\000\001\000\004\000\004\000\
\003\000\000\000\001\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\094\000\000\000\000\000\000\000\001\000\
\008\000\000\000\000\000\000\000\009\000\000\000\000\000\000\000\
\000\000\000\000\002\000\004\000\000\000\000\000\021\000\020\000\
\022\000\023\000\011\000\024\000\000\000\000\000\037\000\000\000\
\034\000\000\000\000\000\000\000\000\000\000\000\018\000\000\000\
\000\000\000\000\013\000\000\000\000\000\027\000\000\000\005\000\
\000\000\000\000\019\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\035\000\000\000\000\000\000\000\
\028\000\000\000\036\000\000\000\000\000\000\000\000\000\084\000\
\085\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\068\000\069\000\077\000\080\000\040\000\086\000\000\000\
\000\000\000\000\000\000\055\000\000\000\059\000\066\000\000\000\
\076\000\000\000\000\000\000\000\000\000\000\000\012\000\000\000\
\051\000\000\000\000\000\031\000\000\000\000\000\000\000\000\000\
\000\000\000\000\078\000\000\000\067\000\039\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\089\000\000\000\092\000\000\000\000\000\000\000\032\000\000\000\
\000\000\000\000\000\000\000\000\082\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\058\000\074\000\075\000\087\000\000\000\000\000\000\000\043\000\
\000\000\000\000\000\000\000\000\014\000\000\000\000\000\083\000\
\044\000\045\000\047\000\093\000\000\000\015\000\000\000\000\000\
\046\000\042\000\000\000\000\000\000\000\000\000\041\000"

let yydgoto = "\002\000\
\004\000\005\000\008\000\015\000\017\000\009\000\029\000\037\000\
\010\000\030\000\034\000\062\000\078\000\095\000\031\000\032\000\
\041\000\036\000\064\000\033\000\080\000\147\000\122\000\148\000\
\000\000\000\000\098\000\099\000\100\000\101\000\102\000\103\000\
\104\000\105\000\149\000"

let yysindex = "\003\000\
\247\254\000\000\241\254\000\000\020\255\009\255\042\255\000\000\
\000\000\020\255\070\255\058\255\000\000\065\255\056\255\063\255\
\061\255\069\255\000\000\000\000\131\255\202\255\000\000\000\000\
\000\000\000\000\000\000\000\000\131\255\202\255\000\000\083\255\
\000\000\082\255\083\255\089\255\099\255\202\255\000\000\083\255\
\131\255\083\255\000\000\242\254\101\255\000\000\202\255\000\000\
\083\255\104\255\000\000\013\255\202\255\131\255\202\255\083\255\
\105\255\202\255\131\255\121\255\000\000\140\000\083\255\202\255\
\000\000\127\255\000\000\168\255\106\255\173\255\030\000\000\000\
\000\000\178\255\182\255\185\255\059\000\180\255\196\255\140\000\
\041\255\184\255\083\255\188\255\202\255\086\000\086\000\087\255\
\118\000\000\000\000\000\000\000\000\000\000\000\000\000\189\255\
\053\255\218\255\206\000\000\000\214\255\000\000\000\000\029\255\
\000\000\192\255\083\255\086\000\193\255\194\255\000\000\086\000\
\000\000\086\000\083\255\000\000\200\255\202\255\140\000\197\255\
\204\255\053\255\000\000\053\255\000\000\000\000\086\000\083\255\
\090\000\087\255\087\255\087\255\087\255\087\255\087\255\087\255\
\087\255\090\000\087\255\087\255\227\255\228\255\237\255\235\254\
\000\000\235\255\000\000\239\255\191\255\011\000\000\000\140\000\
\248\255\241\255\245\255\251\255\000\000\053\255\206\000\214\255\
\029\255\029\255\076\255\076\255\076\255\076\255\076\255\076\255\
\000\000\000\000\000\000\000\000\250\255\253\255\053\255\000\000\
\255\255\086\000\086\000\004\000\000\000\140\000\140\000\000\000\
\000\000\000\000\000\000\000\000\001\000\000\000\005\000\010\000\
\000\000\000\000\014\000\013\000\140\000\017\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\045\001\000\000\000\000\000\000\
\000\000\055\001\000\000\019\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\020\000\023\000\000\000\000\000\
\000\000\000\000\000\000\000\000\025\000\000\000\000\000\000\000\
\000\000\000\000\000\000\028\000\000\000\000\000\000\000\000\000\
\029\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\023\000\038\000\155\000\000\000\
\000\000\023\000\000\000\000\000\000\000\000\000\000\000\170\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\067\255\039\000\
\000\000\000\000\000\000\000\000\155\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\171\255\019\255\023\255\000\000\015\255\000\000\000\000\240\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\042\000\000\000\000\000\000\000\155\000\000\000\000\000\
\000\000\183\255\000\000\002\255\000\000\000\000\042\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\043\000\073\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\171\255\000\000\126\255\
\252\255\008\000\027\255\113\255\119\255\244\255\096\000\116\000\
\000\000\000\000\000\000\000\000\000\000\000\000\195\255\000\000\
\116\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\060\001\000\000\000\000\
\000\000\236\255\099\000\187\255\177\255\224\255\238\255\052\000\
\000\000\000\000\000\000\154\000\000\000\205\255\213\255\213\000\
\000\000\000\000\000\000\088\001\000\000\216\000\208\000\002\001\
\002\000\170\255\000\000"

let yytablesize = 482
let yytable = "\044\000\
\113\000\123\000\046\000\001\000\072\000\073\000\074\000\050\000\
\038\000\052\000\039\000\003\000\070\000\070\000\043\000\119\000\
\057\000\077\000\081\000\096\000\038\000\006\000\051\000\065\000\
\053\000\110\000\057\000\097\000\054\000\079\000\082\000\139\000\
\140\000\097\000\120\000\121\000\081\000\060\000\060\000\153\000\
\007\000\070\000\097\000\097\000\070\000\124\000\070\000\079\000\
\152\000\011\000\117\000\058\000\170\000\171\000\057\000\059\000\
\143\000\057\000\053\000\057\000\146\000\053\000\054\000\053\000\
\097\000\054\000\060\000\054\000\097\000\060\000\097\000\060\000\
\180\000\035\000\142\000\081\000\130\000\131\000\012\000\114\000\
\040\000\042\000\150\000\097\000\115\000\158\000\079\000\014\000\
\088\000\049\000\016\000\127\000\040\000\018\000\158\000\157\000\
\128\000\019\000\056\000\020\000\175\000\021\000\191\000\192\000\
\035\000\086\000\063\000\022\000\081\000\035\000\086\000\082\000\
\072\000\073\000\074\000\083\000\082\000\198\000\043\000\079\000\
\092\000\045\000\043\000\061\000\061\000\077\000\188\000\189\000\
\109\000\062\000\062\000\161\000\162\000\047\000\097\000\097\000\
\063\000\056\000\081\000\081\000\048\000\055\000\053\000\058\000\
\086\000\023\000\024\000\025\000\026\000\079\000\079\000\060\000\
\061\000\081\000\083\000\061\000\066\000\061\000\062\000\083\000\
\068\000\062\000\027\000\062\000\079\000\056\000\084\000\028\000\
\056\000\063\000\056\000\079\000\079\000\079\000\079\000\079\000\
\079\000\079\000\079\000\079\000\079\000\070\000\070\000\079\000\
\079\000\079\000\079\000\079\000\079\000\079\000\079\000\079\000\
\079\000\079\000\079\000\088\000\088\000\088\000\088\000\088\000\
\088\000\088\000\088\000\088\000\088\000\088\000\088\000\061\000\
\085\000\112\000\070\000\087\000\067\000\070\000\106\000\070\000\
\023\000\024\000\025\000\026\000\107\000\111\000\079\000\108\000\
\138\000\079\000\116\000\079\000\118\000\129\000\141\000\126\000\
\144\000\145\000\088\000\178\000\154\000\088\000\028\000\088\000\
\073\000\073\000\151\000\155\000\073\000\073\000\073\000\073\000\
\073\000\073\000\073\000\073\000\071\000\071\000\063\000\063\000\
\071\000\071\000\071\000\071\000\071\000\071\000\071\000\071\000\
\072\000\072\000\172\000\173\000\072\000\072\000\072\000\072\000\
\072\000\072\000\072\000\072\000\174\000\176\000\177\000\073\000\
\179\000\182\000\073\000\063\000\073\000\183\000\063\000\088\000\
\063\000\181\000\184\000\071\000\185\000\196\000\071\000\186\000\
\071\000\187\000\089\000\193\000\006\000\190\000\194\000\072\000\
\090\000\091\000\072\000\195\000\072\000\197\000\007\000\072\000\
\073\000\074\000\199\000\003\000\088\000\033\000\025\000\092\000\
\093\000\043\000\016\000\026\000\077\000\013\000\017\000\089\000\
\094\000\023\000\024\000\025\000\026\000\090\000\091\000\038\000\
\050\000\090\000\091\000\156\000\072\000\073\000\074\000\088\000\
\160\000\169\000\125\000\088\000\092\000\093\000\043\000\028\000\
\000\000\077\000\089\000\000\000\000\000\000\000\089\000\000\000\
\090\000\091\000\064\000\064\000\090\000\091\000\000\000\072\000\
\073\000\074\000\000\000\072\000\073\000\074\000\000\000\092\000\
\093\000\043\000\000\000\092\000\077\000\043\000\065\000\065\000\
\077\000\000\000\089\000\000\000\000\000\000\000\000\000\064\000\
\090\000\091\000\064\000\000\000\064\000\000\000\000\000\072\000\
\073\000\074\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\043\000\000\000\065\000\077\000\000\000\065\000\000\000\
\065\000\069\000\070\000\000\000\071\000\072\000\073\000\074\000\
\000\000\075\000\076\000\000\000\000\000\000\000\000\000\043\000\
\029\000\029\000\077\000\029\000\029\000\029\000\029\000\000\000\
\029\000\029\000\000\000\000\000\000\000\000\000\029\000\030\000\
\030\000\029\000\030\000\030\000\030\000\030\000\000\000\030\000\
\030\000\000\000\000\000\000\000\000\000\030\000\130\000\131\000\
\030\000\000\000\132\000\133\000\134\000\135\000\136\000\137\000\
\159\000\000\000\000\000\163\000\164\000\165\000\166\000\167\000\
\168\000\159\000"

let yycheck = "\032\000\
\080\000\088\000\035\000\001\000\026\001\027\001\028\001\040\000\
\029\000\042\000\029\000\021\001\011\001\012\001\036\001\085\000\
\049\000\039\001\062\000\071\000\041\000\037\001\041\000\056\000\
\039\001\077\000\012\001\071\000\043\001\062\000\063\000\003\001\
\004\001\077\000\086\000\087\000\080\000\011\001\012\001\119\000\
\021\001\040\001\086\000\087\000\043\001\089\000\045\001\080\000\
\118\000\041\001\083\000\039\001\139\000\140\000\040\001\043\001\
\108\000\043\001\040\001\045\001\112\000\043\001\040\001\045\001\
\108\000\043\001\040\001\045\001\112\000\043\001\114\000\045\001\
\152\000\022\000\107\000\119\000\001\001\002\001\037\001\039\001\
\029\000\030\000\115\000\127\000\044\001\129\000\119\000\018\001\
\002\001\038\000\033\001\039\001\041\000\029\001\138\000\128\000\
\044\001\042\001\047\000\037\001\144\000\041\001\182\000\183\000\
\053\000\039\001\055\000\039\001\152\000\058\000\044\001\039\001\
\026\001\027\001\028\001\064\000\044\001\197\000\036\001\152\000\
\034\001\040\001\036\001\011\001\012\001\039\001\178\000\179\000\
\077\000\011\001\012\001\130\000\131\000\045\001\178\000\179\000\
\085\000\012\001\182\000\183\000\042\001\041\001\039\001\039\001\
\039\001\015\001\016\001\017\001\018\001\182\000\183\000\053\000\
\040\001\197\000\039\001\043\001\058\000\045\001\040\001\044\001\
\040\001\043\001\032\001\045\001\197\000\040\001\040\001\037\001\
\043\001\118\000\045\001\001\001\002\001\003\001\004\001\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\001\001\002\001\003\001\004\001\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\054\000\
\041\001\014\001\040\001\039\001\059\000\043\001\037\001\045\001\
\015\001\016\001\017\001\018\001\039\001\042\001\040\001\039\001\
\011\001\043\001\043\001\045\001\041\001\012\001\039\001\043\001\
\040\001\040\001\040\001\045\001\040\001\043\001\037\001\045\001\
\001\001\002\001\043\001\040\001\005\001\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\001\001\002\001\011\001\012\001\
\005\001\006\001\007\001\008\001\009\001\010\001\011\001\012\001\
\001\001\002\001\040\001\040\001\005\001\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\040\001\043\001\040\001\040\001\
\014\001\041\001\043\001\040\001\045\001\041\001\043\001\002\001\
\045\001\042\001\040\001\040\001\043\001\024\001\043\001\043\001\
\045\001\043\001\013\001\043\001\000\000\042\001\042\001\040\001\
\019\001\020\001\043\001\042\001\045\001\041\001\000\000\026\001\
\027\001\028\001\042\001\041\001\002\001\042\001\040\001\034\001\
\035\001\036\001\042\001\040\001\039\001\010\000\042\001\013\001\
\043\001\015\001\016\001\017\001\018\001\019\001\020\001\042\001\
\042\001\040\001\040\001\127\000\026\001\027\001\028\001\002\001\
\129\000\138\000\089\000\002\001\034\001\035\001\036\001\037\001\
\255\255\039\001\013\001\255\255\255\255\255\255\013\001\255\255\
\019\001\020\001\011\001\012\001\019\001\020\001\255\255\026\001\
\027\001\028\001\255\255\026\001\027\001\028\001\255\255\034\001\
\035\001\036\001\255\255\034\001\039\001\036\001\011\001\012\001\
\039\001\255\255\013\001\255\255\255\255\255\255\255\255\040\001\
\019\001\020\001\043\001\255\255\045\001\255\255\255\255\026\001\
\027\001\028\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\036\001\255\255\040\001\039\001\255\255\043\001\255\255\
\045\001\022\001\023\001\255\255\025\001\026\001\027\001\028\001\
\255\255\030\001\031\001\255\255\255\255\255\255\255\255\036\001\
\022\001\023\001\039\001\025\001\026\001\027\001\028\001\255\255\
\030\001\031\001\255\255\255\255\255\255\255\255\036\001\022\001\
\023\001\039\001\025\001\026\001\027\001\028\001\255\255\030\001\
\031\001\255\255\255\255\255\255\255\255\036\001\001\001\002\001\
\039\001\255\255\005\001\006\001\007\001\008\001\009\001\010\001\
\129\000\255\255\255\255\132\000\133\000\134\000\135\000\136\000\
\137\000\138\000"

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
# 86 "jlite_parser.mly"
                            ( (_1, _2) )
# 443 "jlite_parser.ml"
               : Jlite_structs.mOOL_program))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'method_main) in
    Obj.repr(
# 90 "jlite_parser.mly"
                            ( ( _2, _4) )
# 451 "jlite_parser.ml"
               : 'class_main))
; (fun __caml_parser_env ->
    Obj.repr(
# 94 "jlite_parser.mly"
 ( None )
# 457 "jlite_parser.ml"
               : 'inheritence))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 95 "jlite_parser.mly"
                                  ( Some _2 )
# 464 "jlite_parser.ml"
               : 'inheritence))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'inheritence) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'varmth_varmth_decl_list) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'method_decl_list) in
    Obj.repr(
# 102 "jlite_parser.mly"
         ( (_2, _3,(fst _5), 
				(List.append (snd _5) _6)))
# 475 "jlite_parser.ml"
               : 'class_decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 107 "jlite_parser.mly"
 ( [] )
# 481 "jlite_parser.ml"
               : 'class_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_class_decl_list) in
    Obj.repr(
# 108 "jlite_parser.mly"
                            ( List.rev _1 )
# 488 "jlite_parser.ml"
               : 'class_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'class_decl) in
    Obj.repr(
# 113 "jlite_parser.mly"
                    ( [_1] )
# 495 "jlite_parser.ml"
               : 'non_zero_class_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_class_decl_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'class_decl) in
    Obj.repr(
# 114 "jlite_parser.mly"
                                       ( _2 :: _1)
# 503 "jlite_parser.ml"
               : 'non_zero_class_decl_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 119 "jlite_parser.mly"
 (  Public )
# 509 "jlite_parser.ml"
               : 'modifier))
; (fun __caml_parser_env ->
    Obj.repr(
# 120 "jlite_parser.mly"
                 ( Private )
# 515 "jlite_parser.ml"
               : 'modifier))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'mthd_param_list) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'var_decl_stmt_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 130 "jlite_parser.mly"
   ( { 
				modifier = Public;
				rettype = VoidT; 
				mOOLid = SimpleVarId "main"; 
				ir3id = (SimpleVarId "main"); 
				params = _4; 
				localvars = _7; stmts = _8;
			})
# 531 "jlite_parser.ml"
               : 'method_main))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 141 "jlite_parser.mly"
                (  SimpleVarId _1 )
# 538 "jlite_parser.ml"
               : 'var_id_rule))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 8 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 7 : 'var_id_rule) in
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'mthd_param_list) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'var_decl_stmt_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 151 "jlite_parser.mly"
   ( { 
				modifier=Public;
				rettype=_1; 
				mOOLid=_2;
				ir3id= _2;				
				params=_4; 
				localvars=_7; stmts=_8;
			})
# 556 "jlite_parser.ml"
               : 'method_decl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 9 : 'modifier) in
    let _2 = (Parsing.peek_val __caml_parser_env 8 : 'type_KWORD) in
    let _3 = (Parsing.peek_val __caml_parser_env 7 : 'var_id_rule) in
    let _5 = (Parsing.peek_val __caml_parser_env 5 : 'mthd_param_list) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'var_decl_stmt_list) in
    let _9 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 167 "jlite_parser.mly"
   ( { 
				modifier=_1;
				rettype=_2; 
				mOOLid=_3;
				ir3id= _3;				
				params=_5; 
				localvars=_8; stmts=_9;
			})
# 575 "jlite_parser.ml"
               : 'method_decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 178 "jlite_parser.mly"
 ( [] )
# 581 "jlite_parser.ml"
               : 'method_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_method_decl_list) in
    Obj.repr(
# 179 "jlite_parser.mly"
                             ( List.rev _1 )
# 588 "jlite_parser.ml"
               : 'method_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'method_decl) in
    Obj.repr(
# 183 "jlite_parser.mly"
                    ( [_1] )
# 595 "jlite_parser.ml"
               : 'non_zero_method_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_method_decl_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'method_decl) in
    Obj.repr(
# 184 "jlite_parser.mly"
                                         ( _2 :: _1)
# 603 "jlite_parser.ml"
               : 'non_zero_method_decl_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 188 "jlite_parser.mly"
              ( BoolT )
# 609 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 189 "jlite_parser.mly"
                 ( IntT )
# 615 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 190 "jlite_parser.mly"
                 ( StringT )
# 621 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 191 "jlite_parser.mly"
               ( VoidT )
# 627 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 192 "jlite_parser.mly"
                    (  ObjectT _1 )
# 634 "jlite_parser.ml"
               : 'type_KWORD))
; (fun __caml_parser_env ->
    Obj.repr(
# 197 "jlite_parser.mly"
 ( [] )
# 640 "jlite_parser.ml"
               : 'mthd_param_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_mthd_param_list) in
    Obj.repr(
# 198 "jlite_parser.mly"
                            ( List.rev _1 )
# 647 "jlite_parser.ml"
               : 'mthd_param_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 203 "jlite_parser.mly"
  ( [(_1, _2)] )
# 655 "jlite_parser.ml"
               : 'non_zero_mthd_param_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'non_zero_mthd_param_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'type_KWORD) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 205 "jlite_parser.mly"
  ( (_3, _4) :: _1)
# 664 "jlite_parser.ml"
               : 'non_zero_mthd_param_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 211 "jlite_parser.mly"
 ( [] )
# 670 "jlite_parser.ml"
               : 'var_decl_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_var_decl_stmt_list) in
    Obj.repr(
# 212 "jlite_parser.mly"
                               ( List.rev _1 )
# 677 "jlite_parser.ml"
               : 'var_decl_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'var_id_rule) in
    Obj.repr(
# 217 "jlite_parser.mly"
  ( [(_1, _2)] )
# 685 "jlite_parser.ml"
               : 'non_zero_var_decl_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'non_zero_var_decl_stmt_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'var_id_rule) in
    Obj.repr(
# 219 "jlite_parser.mly"
  ( (_2, _3) :: _1)
# 694 "jlite_parser.ml"
               : 'non_zero_var_decl_stmt_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 225 "jlite_parser.mly"
 ( ([],[]) )
# 700 "jlite_parser.ml"
               : 'varmth_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_varmth_decl_list) in
    Obj.repr(
# 227 "jlite_parser.mly"
  ( ((fst _1),(snd _1)) )
# 707 "jlite_parser.ml"
               : 'varmth_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'var_id_rule) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_varmth_decl_list) in
    Obj.repr(
# 232 "jlite_parser.mly"
   ( (((Public,(_1, _2)) :: (fst _4)), (snd _4)))
# 716 "jlite_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'modifier) in
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'type_KWORD) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'var_id_rule) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_varmth_decl_list) in
    Obj.repr(
# 234 "jlite_parser.mly"
   ( (((_1,(_2, _3)) :: (fst _5)), (snd _5)))
# 726 "jlite_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'method_decl) in
    Obj.repr(
# 236 "jlite_parser.mly"
   ( ([], [_1]))
# 733 "jlite_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'var_id_rule) in
    Obj.repr(
# 238 "jlite_parser.mly"
   ( ([(Public,(_1, _2))],[]) )
# 741 "jlite_parser.ml"
               : 'non_zero_varmth_decl_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 243 "jlite_parser.mly"
                                ( ReturnStmt _2 )
# 748 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 244 "jlite_parser.mly"
                             ( ReturnVoidStmt)
# 754 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : 'exp) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'non_zero_stmt_list) in
    let _10 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 247 "jlite_parser.mly"
                                               ( IfStmt (_3,_6,_10) )
# 763 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'exp) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'non_zero_stmt_list) in
    Obj.repr(
# 249 "jlite_parser.mly"
                                    ( WhileStmt (_3,_6) )
# 771 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'var_id_rule) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 250 "jlite_parser.mly"
                                     ( AssignStmt (_1, _3) )
# 779 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'var_id_rule) in
    Obj.repr(
# 252 "jlite_parser.mly"
                                       ( ReadStmt (_3) )
# 786 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'exp) in
    Obj.repr(
# 254 "jlite_parser.mly"
                                ( PrintStmt (_3) )
# 793 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'var_id_rule) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 256 "jlite_parser.mly"
   ( AssignFieldStmt ( FieldAccess ( _1, _3), _5) )
# 802 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'exp_list) in
    Obj.repr(
# 257 "jlite_parser.mly"
                                         ( MdCallStmt (MdCall ( _1, _3)) )
# 810 "jlite_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 261 "jlite_parser.mly"
 ( [] )
# 816 "jlite_parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_stmt_list) in
    Obj.repr(
# 262 "jlite_parser.mly"
                      ( _1 )
# 823 "jlite_parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 266 "jlite_parser.mly"
            ( [_1] )
# 830 "jlite_parser.ml"
               : 'non_zero_stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_stmt_list) in
    Obj.repr(
# 267 "jlite_parser.mly"
                             ( _1 :: _2)
# 838 "jlite_parser.ml"
               : 'non_zero_stmt_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 273 "jlite_parser.mly"
                                ( Some _2 )
# 845 "jlite_parser.ml"
               : 'cast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'bexp) in
    Obj.repr(
# 278 "jlite_parser.mly"
        ( _1 )
# 852 "jlite_parser.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 279 "jlite_parser.mly"
         ( _1 )
# 859 "jlite_parser.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'sexp) in
    Obj.repr(
# 280 "jlite_parser.mly"
         ( _1  )
# 866 "jlite_parser.ml"
               : 'exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'bexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'conj) in
    Obj.repr(
# 284 "jlite_parser.mly"
              ( BinaryExp (BooleanOp "||", _1, _3) )
# 874 "jlite_parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'conj) in
    Obj.repr(
# 285 "jlite_parser.mly"
           ( _1 )
# 881 "jlite_parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'conj) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'rexp) in
    Obj.repr(
# 289 "jlite_parser.mly"
                ( BinaryExp (BooleanOp "&&", _1, _3) )
# 889 "jlite_parser.ml"
               : 'conj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'rexp) in
    Obj.repr(
# 290 "jlite_parser.mly"
           ( _1 )
# 896 "jlite_parser.ml"
               : 'conj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 293 "jlite_parser.mly"
               ( BinaryExp (RelationalOp "==", _1, _3) )
# 904 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 294 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp "!=", _1, _3) )
# 912 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 295 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp ">", _1, _3) )
# 920 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 296 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp ">=", _1, _3) )
# 928 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 297 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp "<", _1, _3) )
# 936 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 298 "jlite_parser.mly"
                 ( BinaryExp (RelationalOp "<=", _1, _3) )
# 944 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'bgrd) in
    Obj.repr(
# 299 "jlite_parser.mly"
           ( _1)
# 951 "jlite_parser.ml"
               : 'rexp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'bgrd) in
    Obj.repr(
# 303 "jlite_parser.mly"
            ( UnaryExp (UnaryOp "!", _2) )
# 958 "jlite_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    Obj.repr(
# 304 "jlite_parser.mly"
               ( BoolLiteral (true) )
# 964 "jlite_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    Obj.repr(
# 305 "jlite_parser.mly"
                ( BoolLiteral (false) )
# 970 "jlite_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 306 "jlite_parser.mly"
           ( _1)
# 977 "jlite_parser.ml"
               : 'bgrd))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 310 "jlite_parser.mly"
                 ( BinaryExp (AritmeticOp "+",_1,_3) )
# 985 "jlite_parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 311 "jlite_parser.mly"
                    ( BinaryExp (AritmeticOp "-",_1,_3) )
# 993 "jlite_parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 312 "jlite_parser.mly"
           ( _1 )
# 1000 "jlite_parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 316 "jlite_parser.mly"
                   ( BinaryExp (AritmeticOp "*",_1,_3) )
# 1008 "jlite_parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 317 "jlite_parser.mly"
                    ( BinaryExp (AritmeticOp "+",_1,_3) )
# 1016 "jlite_parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 318 "jlite_parser.mly"
          ( _1 )
# 1023 "jlite_parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 322 "jlite_parser.mly"
                 ( IntLiteral ( _1 ) )
# 1030 "jlite_parser.ml"
               : 'ftr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ftr) in
    Obj.repr(
# 323 "jlite_parser.mly"
              ( UnaryExp (UnaryOp "-", _2) )
# 1037 "jlite_parser.ml"
               : 'ftr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 324 "jlite_parser.mly"
          ( _1 )
# 1044 "jlite_parser.ml"
               : 'ftr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 328 "jlite_parser.mly"
                ( StringLiteral ( _1 ) )
# 1051 "jlite_parser.ml"
               : 'sexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 329 "jlite_parser.mly"
          ( _1 )
# 1058 "jlite_parser.ml"
               : 'sexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 333 "jlite_parser.mly"
                        ( FieldAccess ( _1, _3) )
# 1066 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'atom) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'exp_list) in
    Obj.repr(
# 334 "jlite_parser.mly"
                                ( MdCall ( _1, _3) )
# 1074 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 335 "jlite_parser.mly"
                   ( ThisWord )
# 1080 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 336 "jlite_parser.mly"
                 ( NullWord )
# 1086 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'var_id_rule) in
    Obj.repr(
# 337 "jlite_parser.mly"
                   ( Var _1 )
# 1093 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    Obj.repr(
# 338 "jlite_parser.mly"
                                            ( ObjectCreate _2 )
# 1100 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'type_KWORD) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 339 "jlite_parser.mly"
                                 ( CastExp ( _4, _2) )
# 1108 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exp) in
    Obj.repr(
# 340 "jlite_parser.mly"
                      ( _2 )
# 1115 "jlite_parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 344 "jlite_parser.mly"
 ( [] )
# 1121 "jlite_parser.ml"
               : 'exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'non_zero_exp_list) in
    Obj.repr(
# 345 "jlite_parser.mly"
                     ( List.rev _1 )
# 1128 "jlite_parser.ml"
               : 'exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 349 "jlite_parser.mly"
           ( [_1] )
# 1135 "jlite_parser.ml"
               : 'non_zero_exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'non_zero_exp_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp) in
    Obj.repr(
# 350 "jlite_parser.mly"
                                ( _3 :: _1)
# 1143 "jlite_parser.ml"
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : Jlite_structs.mOOL_program)
;;
# 353 "jlite_parser.mly"

# 1170 "jlite_parser.ml"
