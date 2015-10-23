all:mOOL_compiler clean

mOOL_compiler:mOOL_lexer.cmo mOOL_parser.cmo mOOL_structs.cmo mOOL_annotatedtyping.cmo ir3mOOL_structs.cmo mOOLtoir3.cmo arm_structs.cmo ir3_structs_new.cmo assign_register.cmo ir3_to_arm.cmo ir3_filter.cmo peephole.cmo ir3_bbl_generator.cmo register_allocation.cmo liveness_analysis.cmo ldr_str_optimizer.cmo common_subexpression.cmo copy_propagation.cmo optimization_flags.cmo mOOL_simple_annotatedtyping.cmo global_common_subexpression.cmo optimization_flags.cmo mOOL_main.cmo
	ocamlc -o mOOL_compiler optimization_flags.cmo arm_structs.cmo mOOL_structs.cmo mOOL_annotatedtyping.cmo mOOL_simple_annotatedtyping.cmo mOOL_lexer.cmo mOOL_parser.cmo ir3mOOL_structs.cmo mOOLtoir3.cmo ir3_structs_new.cmo common_subexpression.cmo copy_propagation.cmo ir3_bbl_generator.cmo global_common_subexpression.cmo liveness_analysis.cmo ir3_filter.cmo peephole.ml register_allocation.cmo str.cma assign_register.cmo ir3_to_arm.cmo ldr_str_optimizer.cmo mOOL_main.cmo
# ocamlc -annot optimization_flags.cmo str.cma mOOL_structs.cmo mOOL_lexer.cmo mOOL_parser.cmo mOOL_annotatedtyping.cmo ir3mOOL_structs.cmo ir3_filter.cmo peephole.cmo mOOLtoir3.cmo arm_structs.cmo ir3_structs_new.cmo assign_register.cmo ir3_to_arm.cmo mOOL_main.ml ir3_bbl_generator.cmo register_allocation.cmo liveness_analysis.cmo ldr_str_optimizer.cmo common_subexpression.cmo copy_propagation.cmo optimization_flags.cmo global_common_subexpression.cmo mOOL_simple_annotatedtyping.cmo mOOL_main.cmo -o mOOL_compiler

mOOL_main.cmo:mOOL_main.ml
	ocamlc -annot -c mOOL_simple_annotatedtyping.cmo mOOL_main.ml

global_common_subexpression.cmo:ir3_structs_new.cmo ir3_bbl_generator.cmo global_common_subexpression.ml
	ocamlc -annot -c ir3_structs_new.cmo ir3_bbl_generator.cmo global_common_subexpression.ml

mOOL_simple_annotatedtyping.cmo:mOOL_simple_annotatedtyping.ml
	ocamlc -annot -c mOOL_simple_annotatedtyping.ml

optimization_flags.cmo:optimization_flags.ml
	ocamlc -annot -c optimization_flags.ml


copy_propagation.cmo:ir3_structs_new.cmo copy_propagation.ml
	ocamlc -annot -c ir3_structs_new.cmo copy_propagation.ml

common_subexpression.cmo:ir3_structs_new.cmo common_subexpression.ml
	ocamlc -annot -c ir3_structs_new.cmo common_subexpression.ml

ldr_str_optimizer.cmo:ir3_structs_new.cmo ir3_bbl_generator.cmo assign_register.cmo arm_structs.cmo ldr_str_optimizer.ml
	ocamlc -annot -c ir3_structs_new.cmo ir3_bbl_generator.cmo assign_register.cmo arm_structs.cmo ldr_str_optimizer.ml

peephole.cmo:ir3mOOL_structs.cmo mOOL_structs.cmo
	ocamlc -annot -c ir3_structs.cmo mOOL_structs.cmo peephole.ml

register_allocation.cmo:register_allocation.ml
	ocamlc -annot -c register_allocation.ml

ir3_bbl_generator.cmo:ir3_structs_new.cmo arm_structs.cmo ir3_bbl_generator.ml
	ocamlc -annot -c ir3_structs_new.cmo arm_structs.cmo ir3_bbl_generator.ml

ir3_to_arm.cmo:ir3_to_arm.ml arm_structs.cmo mOOL_structs.cmo ir3_structs_new.cmo assign_register.cmo
	ocamlc -annot -c assign_register.cmo ir3_structs_new.cmo mOOL_structs.cmo arm_structs.cmo ir3_to_arm.ml

ir3_filter.cmo:ir3mOOL_structs.cmo mOOL_structs.cmo ir3_filter.ml
	ocamlc -annot -c ir3mOOL_structs.cmo mOOL_structs.cmo ir3_filter.ml

arm_structs.cmo:arm_structs.ml
	ocamlc -annot -c arm_structs.ml

ir3_structs_new.cmo:ir3mOOL_structs.cmo mOOL_structs.cmo arm_structs.cmo ir3_structs_new.ml
	ocamlc -annot -c ir3mOOL_structs.cmo mool_structs.cmo ir3_structs_new.ml

assign_register.cmo:ir3_structs_new.cmo arm_structs.cmo assign_register.ml
	ocamlc -annot -c ir3_structs_new.cmo arm_structs.cmo assign_register.ml

liveness_analysis.cmo:ir3_structs_new.cmo liveness_analysis.ml
	ocamlc -annot -c ir3_structs_new.cmo liveness_analysis.ml

mOOL_parser.cmo:mOOL_parser.ml mOOL_parser.cmi mOOL_structs.cmo
	ocamlc -annot -c mOOL_structs.cmo mOOL_parser.ml
mOOL_parser.cmi:mOOL_parser.mli mOOL_structs.cmo
	ocamlc -c mOOL_structs.cmo mOOL_parser.mli
mOOL_parser.mli:mOOL_parser.mly
	ocamlyacc mOOL_parser.mly
mOOL_parser.ml:mOOL_parser.mly
	ocamlyacc mOOL_parser.mly

mOOL_lexer.cmo:mOOL_lexer.ml mOOL_parser.cmo
	ocamlc -annot -c mOOL_parser.cmo mOOL_lexer.ml
mOOL_lexer.ml:mOOL_lexer.mll
	ocamllex mOOL_lexer.mll

mOOL_structs.cmo:mOOL_structs.ml
	ocamlc -annot -c mOOL_structs.ml

mOOL_annotatedtyping.cmo:mOOL_annotatedtyping.ml mOOL_structs.cmo
	ocamlc -annot -c mOOL_structs.cmo mOOL_annotatedtyping.ml


mOOLtoir3.cmo:mOOLtoir3.ml mOOL_structs.cmo ir3mOOL_structs.cmo
	ocamlc -annot -c mOOL_structs.cmo ir3mOOL_structs.cmo mOOLtoir3.ml

ir3mOOL_structs.cmo:mOOL_structs.cmo ir3mOOL_structs.ml
	ocamlc -annot -c mOOL_structs.cmo ir3mOOL_structs.ml

.PHONY:clean
clean:
	rm *.cmi *.cmo *.mli mOOL_parser.ml mOOL_lexer.ml
