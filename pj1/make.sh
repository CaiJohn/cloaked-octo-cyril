#! /bin/sh

ocamlc -c optimization_flags.ml
ocamlc -c jlite_structs.ml
ocamlyacc jlite_parser.mly
ocamlc -c jlite_parser.mli
ocamllex jlite_lexer.mll
ocamlc -c jlite_lexer.ml
ocamlc -c jlite_parser.ml
ocamlc -c ir3_structs.ml
ocamlc -c jlite_annotatedtyping.ml
ocamlc -c jlite_toir3.ml
ocamlc -c jlite_simple_annotatedtyping.ml
ocamlc -c arm_structs.ml
ocamlc -c ir3_structs_new.ml
ocamlc -c common_subexpression.ml
ocamlc -c copy_propagation.ml
ocamlc -c ir3_bbl_generator.ml
ocamlc -c global_common_subexpression.ml
ocamlc -c liveness_analysis.ml
ocamlc -c register_allocation.ml
ocamlc -c assign_register.ml
ocamlc -c ir3_to_arm.ml
ocamlc -c ir3_filter.ml
ocamlc -c peephole.ml
ocamlc -c ldr_str_optimizer.ml
ocamlc -c jlite_main.ml

ocamlc -o jlite_compiler optimization_flags.cmo arm_structs.cmo jlite_structs.cmo jlite_annotatedtyping.cmo jlite_simple_annotatedtyping.cmo jlite_lexer.cmo jlite_parser.cmo ir3_structs.cmo jlite_toir3.cmo ir3_structs_new.cmo common_subexpression.cmo copy_propagation.cmo ir3_bbl_generator.cmo global_common_subexpression.cmo liveness_analysis.cmo ir3_filter.cmo peephole.ml register_allocation.cmo str.cma assign_register.cmo ir3_to_arm.cmo ldr_str_optimizer.cmo jlite_main.cmo
