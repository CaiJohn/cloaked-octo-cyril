all:jlite_parser clean

jlite_parser:jlite_lexer.cmo jlite_parser.cmo jlite_structs.cmo jlite_main.ml
	ocamlc jlite_structs.cmo jlite_lexer.cmo jlite_parser.cmo jlite_main.ml -o jlite_parser

jlite_parser.cmo:jlite_parser.ml jlite_parser.cmi jlite_structs.cmo
	ocamlc -c jlite_structs.cmo jlite_parser.ml
jlite_parser.cmi:jlite_parser.mli jlite_structs.cmo
	ocamlc -c jlite_structs.cmo jlite_parser.mli
jlite_parser.mli:jlite_parser.mly
	ocamlyacc jlite_parser.mly
jlite_parser.ml:jlite_parser.mly
	ocamlyacc jlite_parser.mly

jlite_lexer.cmo:jlite_lexer.ml jlite_parser.cmo
	ocamlc -c jlite_parser.cmo jlite_lexer.ml
jlite_lexer.ml:jlite_lexer.mll
	ocamllex jlite_lexer.mll

jlite_structs.cmo:jlite_structs.ml
	ocamlc -c jlite_structs.ml



.PHONY:clean
clean:
	rm *.cmi *.cmo *.mli jlite_parser.ml jlite_lexer.ml