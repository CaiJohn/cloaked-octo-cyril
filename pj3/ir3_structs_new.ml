(* ================================================================ *)
(* =================== CS4212 Compiler Design ===================== *)
(*  Structures for new IR3 (for code generation) of MOOL language  *)
(* ================================================================ *)

open Ir3mOOL_structs
open MOOL_structs (* Not very good practicing *)
open Arm_structs

(* IR3 types, expressions, and statements are represented by Ocaml Variant Types *)
(* Ocaml Variant Types can contain more than one kind of value *)
(* Instantianting such a type is done through the corresponding type constructor *)
(* Ex : BinaryExp3 (ComparisonOp "<=",  IntLiteral3 2, Var3 x) *)
(* Accesing such a type is done through the "match with" construct 
	as can be seen in the code below *)
	
(*type ir3_op = MOOL_structs.mOOL_op*)
type reg_or_mem =
  | Reg of string
  | Mem of string


type ir3_op_new = ir3_op
type id3_new = (string * reg_or_mem)
type cname3_new = string
type label3_new = int

type ir3_type_new = ir3_type


type idc3_new = 
  | IntLiteral3_new of int
  | BoolLiteral3_new of bool
  | StringLiteral3_new of string
  | Var3_new of id3_new

type ir3_exp_new =
  | BinaryExp3_new of ir3_op_new * idc3_new * idc3_new
  | UnaryExp3_new of ir3_op_new * idc3_new
  | FieldAccess3_new of id3_new * id3_new
  | Idc3Expr_new of idc3_new
  | MdCall3_new of id3_new * (idc3_new list) 
  | ObjectCreate3_new of string

type ir3_stmt_new = 
	| Label3_new of label3_new
	| IfStmt3_new of ir3_exp_new * label3_new 
	| AnnoIfStmt3_new of arm_instr list
	| GoTo3_new of label3_new 
	| ReadStmt3_new of id3_new
	| PrintStmt3_new of idc3_new
	| AssignStmt3_new of id3_new * ir3_exp_new
	| AssignDeclStmt3_new of ir3_type_new * id3_new * ir3_exp_new
	| AssignFieldStmt3_new of ir3_exp_new * ir3_exp_new
	| MdCallStmt3_new of ir3_exp_new
	| ReturnStmt3_new of id3_new
	| ReturnVoidStmt3_new
	| LD of string * string
	| ST of string * string

type ir3_analysis =
  {
    statement : ir3_stmt_new;
    liveness_set : string list

  }

(* Ocaml Tuple Type representing an IR3 variable declaration *)
type var_decl3_new = ir3_type_new * id3_new

(* Ocaml Record Type representing an IR3 method declaration *)
(* MdDecl -> <Type> <id> ( <FmlList> ) { <VarDecl>* <Stmt>* *)	
type md_decl3_new =
  { 
    id3: id3_new;	
    rettype3: ir3_type_new;
    params3:(var_decl3_new list);
    localvars3:(var_decl3_new list);
    ir3stmts:(ir3_stmt_new list) ;
	stacksize: int;
	anno_param3: reg_or_mem list;
	
  }
  
(* Ocaml Tuple Type representing an IR3 class declaration *)
(* ClassDecl -> class <cname> {<VarDecl>* <MdDecl>} *)	  
type cdata3_new = cname3_new * (var_decl3_new list)

(* Ocaml Tuple Type representing an IR3 program *)
type ir3_program_new = (cdata3_new list) * (md_decl3_new) * (md_decl3_new list)

(* ===================================================== *)
let id3_to_id3_new 
	(input:id3):id3_new=
	(input,Reg "!!!UNSET")

let idc3_to_idc3_new
	(input:idc3):(idc3_new) =
	match input with
	| IntLiteral3 i -> IntLiteral3_new i
  	| BoolLiteral3 b -> BoolLiteral3_new b
  	| StringLiteral3 s -> StringLiteral3_new s
  	| Var3 v -> Var3_new (id3_to_id3_new v)

let ir3_exp_to_ir3_new_exp
	(input:ir3_exp):ir3_exp_new=
	match input with
	| BinaryExp3 (o,i1,i2) ->BinaryExp3_new (o,idc3_to_idc3_new i1,idc3_to_idc3_new i2)
  	| UnaryExp3 (o,i) -> UnaryExp3_new (o,idc3_to_idc3_new i)
 	| FieldAccess3 (i1,i2) ->  FieldAccess3_new (id3_to_id3_new i1,id3_to_id3_new i2)
  	| Idc3Expr i -> Idc3Expr_new (idc3_to_idc3_new i)
  	| MdCall3 (i,ilst) -> MdCall3_new (id3_to_id3_new i,List.map (fun i -> idc3_to_idc3_new i) ilst)
  	| ObjectCreate3 s -> ObjectCreate3_new s

let ir3_stmt_to_ir3_stmt_new
	(input:ir3_stmt):ir3_stmt_new=
	match input with
	| Label3 l -> Label3_new l
	| IfStmt3 (e,l) -> IfStmt3_new (ir3_exp_to_ir3_new_exp e,l) 
	| GoTo3 l -> GoTo3_new l 
	| ReadStmt3 i -> ReadStmt3_new (id3_to_id3_new i)
	| PrintStmt3 i -> PrintStmt3_new (idc3_to_idc3_new i)
	| AssignStmt3 (i,e) -> AssignStmt3_new (id3_to_id3_new i,ir3_exp_to_ir3_new_exp e)
	| AssignDeclStmt3 (t,i,e) -> AssignDeclStmt3_new (t,id3_to_id3_new i,ir3_exp_to_ir3_new_exp e)
	| AssignFieldStmt3 (e1,e2) -> AssignFieldStmt3_new (ir3_exp_to_ir3_new_exp e1,ir3_exp_to_ir3_new_exp e2)
	| MdCallStmt3 e -> MdCallStmt3_new (ir3_exp_to_ir3_new_exp e)
	| ReturnStmt3 i -> ReturnStmt3_new (id3_to_id3_new i)
	| ReturnVoidStmt3 -> ReturnVoidStmt3_new

let var_decl3_to_var_decl3_new
	(input:var_decl3):var_decl3_new=
	match input with
	| (t,i) -> (t,id3_to_id3_new i)

let md_decl3_to_md_decl3_new
	(input:md_decl3):md_decl3_new=
	match input with
	| { Ir3mOOL_structs.id3=i; Ir3mOOL_structs.rettype3=t; Ir3mOOL_structs.params3=vlst; Ir3mOOL_structs.localvars3=lvlst; Ir3mOOL_structs.ir3stmts=ir3stmtlst }->
		{
			id3=id3_to_id3_new i;
			rettype3=t;
			params3=List.map (fun v->var_decl3_to_var_decl3_new v) vlst;
			localvars3=List.map (fun v->var_decl3_to_var_decl3_new v) lvlst;
			ir3stmts=List.map (fun s->ir3_stmt_to_ir3_stmt_new s) ir3stmtlst;
			stacksize=0;
			anno_param3=[];
		}

let cdata3_to_cdata3_new
	(input:cdata3):cdata3_new=
	match input with
	| (c,vlst) -> (c,List.map (fun v->var_decl3_to_var_decl3_new v) vlst)


let ir3_program_to_ir3_program_new
	(input:ir3_program):(ir3_program_new)=
	match input with
	| (clst,m,mdlst) ->
		(List.map (fun c->cdata3_to_cdata3_new c) clst,md_decl3_to_md_decl3_new m,List.map (fun m->md_decl3_to_md_decl3_new m) mdlst)

(* ===================================================== *)
(*  Functions for printing the IR3 *)
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
	let rec helper_func n: string = 
		if (n <= 0) then "" else "  "^ (helper_func (n -1))
	in helper_func (abs !indent)
	
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
	let stmtEnd = "\n" ^ print_tab() ^ "} \n" in 
		stmtBegin ^ indentI 
		^ stmtList ^ indentD ^ stmtEnd
		
(* display an IR3 operator *)
let string_of_ir3_op_new (e:ir3_op_new):string =
  match e with
    | BooleanOp s | AritmeticOp s
	| RelationalOp s | UnaryOp s -> s
	
(* display an IR3 type *)
let rec string_of_ir3_type_new (e:ir3_type_new):string =
  match e with
    | BoolT -> "Bool"
    | IntT -> "Int"
    | StringT -> "String"
	| VoidT -> "void"
	| ObjectT c -> c
	| Unknown -> ""

let string_of_reg_or_mem (e:reg_or_mem):string =
    match e with
    | Reg r -> "(REG:"^r^")"
    | Mem m -> "(MEM:"^m^")"
    
(* display an id or constant: IRC3 *)
let rec string_of_idc3_new e:string =
  match e with
    | BoolLiteral3_new v -> (string_of_bool v)
    | IntLiteral3_new v -> (string_of_int v)
	| StringLiteral3_new v -> "\"" ^ v ^ "\"" 
    | Var3_new (v, m) -> v ^ string_of_reg_or_mem m
	
(* display an IR3 expr in prefix form *)
let string_of_ir3_exp_new (e:ir3_exp_new):string =
  match e with
    | UnaryExp3_new (op,arg) -> 
		"(" ^ string_of_ir3_op_new op ^ ")[" ^(string_of_idc3_new arg)^"]"
    | BinaryExp3_new (op,arg1,arg2) -> 
		"[" ^(string_of_idc3_new arg1)^","
		^(string_of_idc3_new arg2)^"](" 
		^ string_of_ir3_op_new op ^ ")"
	| FieldAccess3_new ((id1,m1),(id2,m2)) -> id1^(string_of_reg_or_mem m1)^"."^id2^(string_of_reg_or_mem m2)
    | ObjectCreate3_new c -> "new " ^ c ^ "()"
    | MdCall3_new ((id,_),args) -> 
		"["^ id
		^"("^(string_of_list args string_of_idc3_new ",")^ ")]"
	| Idc3Expr_new e -> (string_of_idc3_new e)
  
  
(* display an IR3 statement *)
let string_of_ir3_stmt_new (s:ir3_stmt_new):string =
  match s with
	| Label3_new l -> " Label " ^ (string_of_int l) ^ ":"
    | IfStmt3_new (e, l) -> 
		print_tab() ^ "If(" ^ (string_of_ir3_exp_new e) 
		^") goto " ^ (string_of_int l) ^";"
	| GoTo3_new  (l) -> 
		print_tab() ^ "goto " ^ (string_of_int l) ^ ";"
	| ReadStmt3_new (idc,m) -> print_tab() ^ "readln(" ^ idc ^ (string_of_reg_or_mem m) ^");"
	| PrintStmt3_new idc -> print_tab() 
		^ "println(" ^ (string_of_idc3_new idc) ^");"
    | AssignStmt3_new ((id,m),e) ->  
		print_tab() ^ id^(string_of_reg_or_mem m)^"="^(string_of_ir3_exp_new e)^";"
	| AssignFieldStmt3_new (id,e) ->  
		print_tab() ^ (string_of_ir3_exp_new id) ^"="
		^(string_of_ir3_exp_new e)^";"
	| AssignDeclStmt3_new (t, (id,m), e) -> 
		print_tab() ^ (string_of_ir3_type_new t) ^ id ^ (string_of_reg_or_mem m)^ "="
		^(string_of_ir3_exp_new e)^";"
	| MdCallStmt3_new (e) ->  
		print_tab() ^ (string_of_ir3_exp_new e)^";"
    | ReturnStmt3_new (id,m) ->  
		print_tab() ^ "Return "^ id ^(string_of_reg_or_mem m)^";"
	| ReturnVoidStmt3_new ->  
		print_tab() ^ "Return;"
    | LD (str1, str2) ->
        print_tab() ^ "LD "^str1^", "^str2^";"
    | ST (str1, str2) ->
        print_tab() ^ "ST "^str1^", "^str2^";"
    | AnnoIfStmt3_new lst ->
        print_tab() ^string_of_list lst string_of_arm_instr "\n"

(* display an IR3 variable declaration *)
let string_of_var_decl3_new ((t,(id,_)):var_decl3_new) : string = 
	print_tab() ^ (string_of_ir3_type_new t) ^ " " ^ id

(* display an IR3 method argument declaration *)  
let string_of_arg_decl3_new ((t,(id,_)):var_decl3_new) : string = 
	(string_of_ir3_type_new t) ^ " " ^ id
		
(* display an IR3 method declaration *)
let string_of_meth_decl3_new (m:md_decl3_new) : string =
	let (mid,reg) = m.id3 in
	let methodHeader = 
		print_tab() ^ (string_of_ir3_type_new m.rettype3) 
		^ " " ^ mid ^ 
		"(" ^ (string_of_list m.params3 string_of_arg_decl3_new "," ) ^ ")" 
		^"{\n" in
	let indentI = indent_inc() in
	let methodVariables = 
		(string_of_list m.localvars3 string_of_var_decl3_new ";\n") 
		^ (if ((List.length m.localvars3) >  0) then ";\n" else "") in
	let methodStmts = 
		(string_of_list m.ir3stmts string_of_ir3_stmt_new "\n")
		^ (if ((List.length m.ir3stmts) >  0) then "\n" else "") in
	let indentD = indent_dec() in
	let methodEnd = print_tab() ^ "}\n" in
		methodHeader ^ indentI 
		^ methodVariables ^ methodStmts 
		^ indentD ^ methodEnd

(* display an IR3 Class declaration *)
let string_of_cdata3_new
	((c,var_list):cdata3_new) : string = 
	let classHeader = 
		"class " ^ c ^ "{\n" ^ indent_inc() in
	let classBody = 
		(string_of_list var_list string_of_var_decl3_new ";\n")  
		^ (if ((List.length var_list) >  0) then ";\n" else "") 
	in let classEnd = indent_dec()^ "}" in
		classHeader ^ classBody  ^ classEnd
						
(* display an IR3 program *)
let string_of_ir3_program_new 
	((cdata3lst, mainmd3, md3lst):ir3_program_new) : string = 
	"======= IR3 Program New =======\n\n" 
	^ "======= CData3 New======= \n\n" ^ 
		(string_of_list cdata3lst string_of_cdata3_new "\n\n" )
	^ "\n\n" ^ "=======  CMtd3 New ======= \n\n"
		^ (string_of_meth_decl3_new mainmd3) ^ "\n"
		^ (string_of_list md3lst string_of_meth_decl3_new "\n" )
	^ "\n======= End of IR3 Program New =======\n\n"
 
