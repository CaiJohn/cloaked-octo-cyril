
(* ===================================================== *)
(* ============== CS4212 Compiler Design ============== *)
(* 		 Structures for AST of MOOL language 		 	 *)
(* ===================================================== *)

(* MOOL types, expressions, and statements are represented by Ocaml Variant Types *)
(* Ocaml Variant Types can contain more than one kind of value *)
(* Instantianting such a type is done through the corresponding type constructor *)
(* Ex : BinaryExp (ComparisonOp "<=",  IntLiteral 2, Var x) *)
(* Accesing such a type is done through the "match with" construct 
	as can be seen in the code below *)
	
type class_name = string

type mOOL_op = 
	| BooleanOp of string
	| RelationalOp of string
	| AritmeticOp of string
	| UnaryOp of string

type mOOL_type =
  | IntT
  | BoolT
  | StringT
  | ObjectT of class_name 
  | VoidT
  (* Reserved for type checking. Please do not instantiate during parsing *)
  | Unknown 
  
type var_id = 
	| SimpleVarId of string
	(* Reserved for type checking. Please do not instantiate during parsing *)
	| TypedVarId of typed_var_id
	
(* Ocaml Type representing a mOOL variable id annotated with its type and scope *)
(* The scope can be class, parameter or local variable *)
and typed_var_id = string * mOOL_type * int

type mOOL_exp =
  | UnaryExp of mOOL_op * mOOL_exp
  | BinaryExp of mOOL_op * mOOL_exp * mOOL_exp
  | FieldAccess of mOOL_exp * var_id
  | ObjectCreate of class_name
  | MdCall of mOOL_exp * (mOOL_exp list) 
  | BoolLiteral of bool
  | IntLiteral of int
  | StringLiteral of string
  | ThisWord 
  | NullWord
  | Var of var_id
    (* Reserved for type checking. Please do not instantiate during parsing *)
  | TypedExp of mOOL_exp * mOOL_type 

and mOOL_stmt = 
	| IfStmt of mOOL_exp * (mOOL_stmt list) * (mOOL_stmt list)
	| WhileStmt of mOOL_exp * (mOOL_stmt list)
	| ReadStmt of var_id
	| PrintStmt of mOOL_exp
	| AssignStmt of var_id * mOOL_exp
	| AssignFieldStmt of mOOL_exp * mOOL_exp
	| MdCallStmt of mOOL_exp
	| ReturnStmt of mOOL_exp
	| ReturnVoidStmt

(* Ocaml Tuple Type representing a mOOL variable declaration *)
type var_decl = mOOL_type * var_id

(* Ocaml Record Type representing a mOOL method declaration *)
(* MdDecl -> <Type> <id> ( <FmlList> ) { <VarDecl>* <Stmt>* *)	
and md_decl =
	{ 
	  (* ID of the method in the original MOOL Program *)
	  mOOLid: var_id;
	  (* Unique ID of the method in the whole MOOL Program *)
	  (* Mutable value intially equal to mOOLid *)
	  (* After overloading checking ir3id becomes cname_n *)
	  (* where n is the index of method in the list cname methods *)
	  mutable ir3id: var_id ;
	  rettype: mOOL_type;
	  params:(var_decl list);
	  localvars:(var_decl list);
	  stmts:(mOOL_stmt list) 
	 }
  
(* Ocaml Tuple Type representing a mOOL class declaration *)
(* ClassDecl -> class <cname> {<VarDecl>* <MdDecl>} *)	  
and class_decl = class_name * (var_decl list) * (md_decl list)

(* Ocaml Tuple Type representing a mOOL main class declaration *)
and class_main = class_name * md_decl
  
(* Ocaml Tuple Type representing a mOOL program *)
and mOOL_program = class_main * (class_decl list)
	
(* ===================================================== *)
(*  Functions for printing the AST *)
(* ===================================================== *)

(* Mutable value for pretty printing and indentation *)
(* Denotes the number of indentation tabs *)
let indent = ref 0

let indent_inc() : string = 
	 indent:= (!indent + 1);""
	
let indent_dec() : string = 
	indent := (!indent - 1); ""	
	
(* display a a number of indentation tabs *)
let rec print_tab(): string = 
	let rec recursive_function n: string = 
		if (n <= 0) then "" else "  "^ (recursive_function (n -1))
	in recursive_function (abs !indent)
	
(* The following function traverses a list, 
	applies a function to each element and concatenates the results *)
let string_of_list lst func delim  = 
	String.concat delim (List.map func lst)
	
(* The following function pretty prints a block of statements *)
let string_of_indented_stmt_list s f xs = 
	let stmtBegin = print_tab() ^ "{\n" in
	let indentI = indent_inc() in
	let stmtList = String.concat s (List.map f xs)in 
	let indentD = indent_dec() in 
	let stmtEnd = "\n" ^ print_tab() ^ "}" in 
		stmtBegin ^ indentI ^ stmtList ^ indentD ^ stmtEnd

(* display a mOOL operator *)
let string_of_mOOL_op (e:mOOL_op):string =
  match e with
    | BooleanOp s | AritmeticOp s
	| RelationalOp s | UnaryOp s -> s
	
(* display a MOOL type *)
let string_of_mOOL_type (e:mOOL_type):string =
  match e with
    | IntT -> "Int"
	| BoolT -> "Bool"
    | StringT -> "String"
	| VoidT -> "void"
	| ObjectT c -> c
	| Unknown -> ""
	
(* display a MOOL var_id *)
let string_of_var_id (e:var_id):string =
  match e with
    | SimpleVarId id -> id
	| TypedVarId (id,t,s) -> 
	 "(" ^ id
	 ^":"^ (string_of_mOOL_type t) 
	 ^"," ^ (string_of_int s) ^ ")"	
	 
(* display a MOOL expr in postfix form *)
let string_of_mOOL_expr (e:mOOL_exp):string =
  let rec helper_func e =
  match e with
    | UnaryExp (op,arg) -> 
		"(" ^ string_of_mOOL_op op ^")["
		^(helper_func arg)^"]"
    | BinaryExp (op,arg1,arg2) -> 
		"[" ^(helper_func arg1)^","
		^(helper_func arg2)^"](" 
		^ string_of_mOOL_op op ^ ")"
	| FieldAccess (e,id) -> 
		(helper_func e) ^"." ^ string_of_var_id id
    | ObjectCreate c -> "new " ^ c ^ "()"
    | MdCall  (e,args) -> 
		"["^(helper_func e)
		^"("^(string_of_list args helper_func ",")^ ")]"
	| BoolLiteral v -> (string_of_bool v)
    | IntLiteral v -> (string_of_int v)
	| StringLiteral v -> "\"" ^ v ^ "\"" 
	| ThisWord -> "this"
	| NullWord -> "null"
    | Var v -> string_of_var_id v
	| TypedExp (e,t) -> 
		(helper_func e) ^":" 
		^ (string_of_mOOL_type t)
  in helper_func e
  
(* display a MOOL statement *)
let string_of_mOOL_stmt (s:mOOL_stmt):string =
  let rec helper_func s =
  match s with
	| IfStmt (e, stmts1, stmts2) -> 
		let ifExpr = 
			print_tab() ^ "If(" ^ (string_of_mOOL_expr e) ^")\n" in
		let thenBranch = 
			(string_of_indented_stmt_list "\n" helper_func stmts1) in 
		let elseExpr = 
			"\n" ^ print_tab() ^ "else\n" in
		let elseBranch = 
			(string_of_indented_stmt_list "\n" helper_func stmts2) in 
		ifExpr ^ thenBranch ^ elseExpr ^ elseBranch
	| WhileStmt (e, stmts) ->  
        print_tab() ^ "While(" ^ (string_of_mOOL_expr e) ^ ")\n"  
        ^ (string_of_indented_stmt_list "\n" helper_func stmts)
	| ReturnStmt e ->  
		print_tab() ^ "Return " ^ (string_of_mOOL_expr e)^";"
	| ReturnVoidStmt ->  
		print_tab() ^ "Return;"
    | AssignStmt (id,e) ->  
		print_tab() ^ string_of_var_id id 
		^"="^(string_of_mOOL_expr e)^";"
    | ReadStmt id -> 
		print_tab() ^ "readln(" 
		^ string_of_var_id id ^");"
	| PrintStmt e -> 
		print_tab() ^ "println(" 
		^ (string_of_mOOL_expr e) ^");"
	| AssignFieldStmt (id,e) ->  
		print_tab() ^ (string_of_mOOL_expr id)
		^"="^(string_of_mOOL_expr e)^";"
	| MdCallStmt (e) ->  
		print_tab() ^ (string_of_mOOL_expr e)^";"
  in helper_func s
  
(* display a MOOL variable declaration *)
let string_of_var_decl ((t,id):var_decl) : string = 
	print_tab() ^ (string_of_mOOL_type t) 
	^ " " ^ string_of_var_id id

(* display a MOOL method argument declaration *)  
let string_of_arg_decl ((t,id):var_decl) : string = 
	(string_of_mOOL_type t) ^ " " 
	^ string_of_var_id id
		
(* display a MOOL method declaration *)
let string_of_md_decl (m:md_decl) : string = 
	let methodHeader = 
		print_tab() ^ (string_of_mOOL_type m.rettype) 
		^ " " ^ string_of_var_id m.mOOLid ^ 
		"(" ^ (string_of_list m.params string_of_arg_decl ",") ^ ")" 
		^"{\n" in
	let indentI = indent_inc() in
	let methodVariables = 
		(string_of_list m.localvars string_of_var_decl ";\n") 
		^ (if ((List.length m.localvars) >  0) 
			then ";\n" else "") in
	let methodStmts = 
		(string_of_list m.stmts string_of_mOOL_stmt "\n")
		^ (if ((List.length m.stmts) >  0) 
			then "\n" else "") in
	let indentD = indent_dec() in
	let methodEnd = print_tab() ^ "}\n" in
		methodHeader ^ indentI 
		^ methodVariables ^ methodStmts 
		^ indentD ^ methodEnd

(* display a MOOL Main Class declaration *)
let string_of_class_main ((c,md):class_main) : string = 
	let classHeader = "class " ^ c ^ "{\n" ^ indent_inc() in 
	let classBody = string_of_md_decl md in
	let classEnd = indent_dec()^ "\n}" in
		classHeader ^ classBody  ^ classEnd
	
(* display a MOOL Class declaration *)
let string_of_class_decl 
	((c,var_list, md_list):class_decl) : string = 
	let classHeader = 
		"class " ^ c ^ "{\n" ^ indent_inc() in
	let classBody = 
		(string_of_list var_list string_of_var_decl ";\n" )  
		^ (if ((List.length var_list) >  0) 
			then ";\n" else "") ^ "\n" 
		^ (string_of_list md_list string_of_md_decl "\n\n"  ) in
	let classEnd = indent_dec()^ "\n}" in
		classHeader ^ classBody  ^ classEnd
						
(* display a MOOL program *)
let string_of_mOOL_program 
	((mainclass, classes):mOOL_program) : string = 
	"\n======= MOOL Program =======\n\n" 
	^ (string_of_class_main mainclass) ^ " \n\n" 
	^ (string_of_list classes string_of_class_decl "\n")
	^ "\n\n======= End of MOOL Program =======\n\n"
