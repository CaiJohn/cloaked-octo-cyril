.data
	
L1:
	.asciz "Size of array is at least 1\n"
	
L0:
	.asciz "%i\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov a1,#8
	bl _Znwj(PLT)
	mov v2,a1
	mov a2,#100
	mov a1,v2
	bl IntArray_0
	mov a3,#3
	mov a2,#1
	mov a1,v2
	bl IntArray_2
	mov a3,#7
	mov a2,#5
	mov a1,v2
	bl IntArray_2
	mov a3,#13
	mov a2,#11
	mov a1,v2
	bl IntArray_2
	mov a3,#19
	mov a2,#17
	mov a1,v2
	bl IntArray_2
	mov a3,#29
	mov a2,#23
	mov a1,v2
	bl IntArray_2
	mov a3,#37
	mov a2,#31
	mov a1,v2
	bl IntArray_2
	mov a2,#0
	mov a1,v2
	bl IntArray_1
	mov v1,a1
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	mov a2,#1
	mov a1,v2
	bl IntArray_1
	mov v1,a1
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	mov a2,#5
	mov a1,v2
	bl IntArray_1
	mov v1,a1
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	mov a2,#11
	mov a1,v2
	bl IntArray_1
	mov v1,a1
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	mov a2,#17
	mov a1,v2
	bl IntArray_1
	mov v1,a1
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	mov a2,#23
	mov a1,v2
	bl IntArray_1
	mov v1,a1
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	mov a2,#31
	mov a1,v2
	bl IntArray_1
	mov v1,a1
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
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
	bEQ .0
	ldr a1,=L1
	bl printf(PLT)
	b .2
	
.0:
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
	
.1:
	cmp v2,v3
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .2
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
	b .1
	
.2:
	
.IntArray_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
IntArray_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,a2
	ldr v4,[v2,#4]
	mov v2,#0
	
.3:
	cmp v2,v1
	movlt v3,#1
	movge v3,#0
	cmp v3,#0
	bEQ .4
	mov a1,v4
	bl ArrayNode_2
	mov v4,a1
	add v2,v2,#1
	b .3
	
.4:
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
	mov v4,a3
	ldr v5,[v2,#4]
	mov v2,#0
	
.5:
	cmp v2,v1
	movlt v3,#1
	movge v3,#0
	cmp v3,#0
	bEQ .6
	mov a1,v5
	bl ArrayNode_2
	mov v5,a1
	add v2,v2,#1
	b .5
	
.6:
	mov a2,v4
	mov a1,v5
	bl ArrayNode_1
	
.IntArray_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
