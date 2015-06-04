.data
	
L0:
	.asciz "===== After Sort =====\n"
	
L1:
	.asciz "===== Before Sort =====\n"
	
L3:
	.asciz "Size of array is at least 1\n"
	
L2:
	.asciz "%i\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov a1,#8
	bl _Znwj(PLT)
	mov v1,a1
	mov a1,#0
	bl _Znwj(PLT)
	mov v2,a1
	mov a1,#0
	bl _Znwj(PLT)
	mov v3,a1
	mov a2,#100
	mov a1,v1
	bl IntArray_0
	ldr a1,=L1
	bl printf(PLT)
	mov a3,#100
	mov a2,v1
	mov a1,v2
	bl Util_1
	mov a3,#100
	mov a2,v1
	mov a1,v2
	bl Util_2
	ldr a1,=L0
	bl printf(PLT)
	mov a3,#100
	mov a2,v1
	mov a1,v3
	bl ShellSort_0
	mov a3,#100
	mov a2,v1
	mov a1,v2
	bl Util_2
	b .main_exit
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Util_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a2
	mov v2,a3
	mov v5,#0
	mov v3,#0
	
.0:
	cmp v3,v1
	movle v4,#1
	movgt v4,#0
	cmp v4,#0
	bEQ .1
	add v3,v3,v2
	add v5,v5,#1
	b .0
	
.1:
	sub v1,v5,#1
	mov a1,v1
	b .Util_0_exit
	
.Util_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Util_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a2
	mov v4,a3
	mov v3,#0
	
.2:
	cmp v3,v4
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .3
	add v1,v4,v4
	add v1,v1,v4
	add v5,v3,v3
	add v5,v5,v3
	sub v1,v1,v5
	mov a3,v1
	mov a2,v3
	mov a1,v2
	bl IntArray_2
	add v3,v3,#1
	b .2
	
.3:
	
.Util_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Util_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a2
	mov v4,a3
	mov v2,#0
	
.4:
	cmp v2,v4
	movlt v3,#1
	movge v3,#0
	cmp v3,#0
	bEQ .5
	mov a2,v2
	mov a1,v1
	bl IntArray_1
	mov v3,a1
	mov a2,v3
	ldr a1,=L2
	bl printf(PLT)
	add v2,v2,#1
	b .4
	
.5:
	
.Util_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
ShellSort_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#40
	str a2,[fp,#-32]
	str a3,[fp,#-28]
	mov a1,#0
	bl _Znwj(PLT)
	mov v3,a1
	mov a3,#2
	ldr a1,[fp,#-28]
	mov a2,a1
	mov a1,v3
	bl Util_0
	mov a3,a1
	str a3,[fp,#-36]
	
.6:
	cmp a3,#1
	movge v1,#1
	movlt v1,#0
	cmp v1,#0
	bEQ .11
	mov v4,a3
	
.7:
	ldr a1,[fp,#-28]
	cmp v4,a1
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .10
	mov a2,v4
	ldr a1,[fp,#-32]
	mov a1,a1
	bl IntArray_1
	mov a4,a1
	str a4,[fp,#-40]
	ldr a3,[fp,#-36]
	sub v2,v4,a3
	
.8:
	cmp v2,#0
	movge v5,#1
	movlt v5,#0
	mov a2,v2
	ldr a1,[fp,#-32]
	mov a1,a1
	bl IntArray_1
	mov v1,a1
	ldr a4,[fp,#-40]
	cmp a4,v1
	movlt v1,#1
	movge v1,#0
	and v1,v5,v1
	cmp v1,#0
	bEQ .9
	ldr a3,[fp,#-36]
	add v1,v2,a3
	mov a2,v2
	ldr a1,[fp,#-32]
	mov a1,a1
	bl IntArray_1
	mov v5,a1
	mov a3,v5
	mov a2,v1
	ldr a1,[fp,#-32]
	mov a1,a1
	bl IntArray_2
	ldr a3,[fp,#-36]
	sub v2,v2,a3
	b .8
	
.9:
	ldr a3,[fp,#-36]
	add v1,v2,a3
	ldr a1,[fp,#-40]
	mov a3,a1
	mov a2,v1
	ldr a1,[fp,#-32]
	mov a1,a1
	bl IntArray_2
	add v4,v4,#1
	b .7
	
.10:
	mov a3,#2
	ldr a1,[fp,#-36]
	mov a2,a1
	mov a1,v3
	bl Util_0
	mov a3,a1
	str a3,[fp,#-36]
	b .6
	
.11:
	
.ShellSort_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
ArrayNode_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	ldr v1,[v1,#0]
	mov a1,v1
	b .ArrayNode_0_exit
	
.ArrayNode_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
ArrayNode_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov v2,a2
	str v2,[v1,#0]
	
.ArrayNode_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
ArrayNode_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	ldr v1,[v1,#4]
	mov a1,v1
	b .ArrayNode_2_exit
	
.ArrayNode_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
ArrayNode_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,a2
	str v1,[v2,#4]
	
.ArrayNode_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
IntArray_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v3,a2
	cmp v3,#1
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .12
	ldr a1,=L3
	bl printf(PLT)
	b .14
	
.12:
	str v3,[v2,#0]
	mov a1,#8
	bl _Znwj(PLT)
	mov v1,a1
	str v1,[v2,#4]
	ldr v1,[v2,#4]
	mov a2,#0
	mov a1,v1
	bl ArrayNode_1
	ldr v4,[v2,#4]
	mov v2,#1
	
.13:
	cmp v2,v3
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .14
	mov a1,#8
	bl _Znwj(PLT)
	mov v1,a1
	mov a2,#0
	mov a1,v1
	bl ArrayNode_1
	mov a2,v1
	mov a1,v4
	bl ArrayNode_3
	mov v4,v1
	add v2,v2,#1
	b .13
	
.14:
	
.IntArray_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
IntArray_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov v2,a2
	ldr v4,[v1,#4]
	mov v3,#0
	
.15:
	cmp v3,v2
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .16
	mov a1,v4
	bl ArrayNode_2
	mov v4,a1
	add v3,v3,#1
	b .15
	
.16:
	mov a1,v4
	bl ArrayNode_0
	mov v1,a1
	mov a1,v1
	b .IntArray_1_exit
	
.IntArray_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
IntArray_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,a2
	mov v3,a3
	ldr v4,[v2,#4]
	mov v2,#0
	
.17:
	cmp v2,v1
	movlt v5,#1
	movge v5,#0
	cmp v5,#0
	bEQ .18
	mov a1,v4
	bl ArrayNode_2
	mov v4,a1
	add v2,v2,#1
	b .17
	
.18:
	mov a2,v3
	mov a1,v4
	bl ArrayNode_1
	
.IntArray_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
