.data
	
L1:
	.asciz "Value 2 not found!\n"
	
L5:
	.asciz "Max value is\n"
	
L9:
	.asciz "Element not found!\n"
	
L6:
	.asciz "Min value is\n"
	
L2:
	.asciz "Value 8 found\n"
	
L8:
	.asciz "= In Order =\n"
	
L4:
	.asciz "%i\n"
	
L7:
	.asciz "============\n"
	
L0:
	.asciz "Value 2 found\n"
	
L3:
	.asciz "Value 8 not found!\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov a1,#0
	bl _Znwj(PLT)
	mov v3,a1
	mov v2,#0
	mov a3,#5
	mov a2,v2
	mov a1,v3
	bl BST_2
	mov v2,a1
	mov v1,#1
	rsb v1,v1,#0
	mov a3,v1
	mov a2,v2
	mov a1,v3
	bl BST_2
	mov v2,a1
	mov a3,#3
	mov a2,v2
	mov a1,v3
	bl BST_2
	mov v2,a1
	mov v1,#14
	rsb v1,v1,#0
	mov a3,v1
	mov a2,v2
	mov a1,v3
	bl BST_2
	mov v2,a1
	mov a3,#8
	mov a2,v2
	mov a1,v3
	bl BST_2
	mov v2,a1
	mov a3,#10
	mov a2,v2
	mov a1,v3
	bl BST_2
	mov v2,a1
	mov a3,#9
	mov a2,v2
	mov a1,v3
	bl BST_2
	mov v2,a1
	mov a3,#6
	mov a2,v2
	mov a1,v3
	bl BST_2
	mov v2,a1
	ldr a1,=L8
	bl printf(PLT)
	mov a2,v2
	mov a1,v3
	bl BST_5
	ldr a1,=L7
	bl printf(PLT)
	mov a3,#5
	mov a2,v2
	mov a1,v3
	bl BST_3
	mov v2,a1
	mov v1,#1
	rsb v1,v1,#0
	mov a3,v1
	mov a2,v2
	mov a1,v3
	bl BST_3
	mov v2,a1
	ldr a1,=L8
	bl printf(PLT)
	mov a2,v2
	mov a1,v3
	bl BST_5
	ldr a1,=L7
	bl printf(PLT)
	mov a2,v2
	mov a1,v3
	bl BST_0
	mov v1,a1
	ldr a1,=L6
	bl printf(PLT)
	ldr v1,[v1,#0]
	mov a2,v1
	ldr a1,=L4
	bl printf(PLT)
	mov a2,v2
	mov a1,v3
	bl BST_1
	mov v1,a1
	ldr a1,=L5
	bl printf(PLT)
	ldr v1,[v1,#0]
	mov a2,v1
	ldr a1,=L4
	bl printf(PLT)
	mov a3,#8
	mov a2,v2
	mov a1,v3
	bl BST_4
	mov v1,a1
	cmp v1,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .0
	ldr a1,=L3
	bl printf(PLT)
	b .1
	
.0:
	ldr a1,=L2
	bl printf(PLT)
	
.1:
	mov a3,#2
	mov a2,v2
	mov a1,v3
	bl BST_4
	mov v1,a1
	cmp v1,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .2
	ldr a1,=L1
	bl printf(PLT)
	b .3
	
.2:
	ldr a1,=L0
	bl printf(PLT)
	
.3:
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
BST_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v3,a1
	mov v2,a2
	cmp v2,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .4
	mov v1,#0
	mov a1,v1
	b .BST_0_exit
	
.4:
	ldr v1,[v2,#4]
	cmp v1,#0
	movne v1,#1
	moveq v1,#0
	cmp v1,#0
	bEQ .5
	ldr v1,[v2,#4]
	mov a2,v1
	mov a1,v3
	bl BST_0
	mov v1,a1
	mov a1,v1
	b .BST_0_exit
	
.5:
	mov a1,v2
	b .BST_0_exit
	
.BST_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
BST_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v3,a2
	cmp v3,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .7
	mov v1,#0
	mov a1,v1
	b .BST_1_exit
	
.7:
	ldr v1,[v3,#8]
	cmp v1,#0
	movne v1,#1
	moveq v1,#0
	cmp v1,#0
	bEQ .8
	ldr v1,[v3,#8]
	mov a2,v1
	mov a1,v2
	bl BST_1
	mov v1,a1
	mov a1,v1
	b .BST_1_exit
	
.8:
	mov a1,v3
	b .BST_1_exit
	
.BST_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
BST_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v4,a2
	mov v3,a3
	cmp v4,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .10
	mov a1,#12
	bl _Znwj(PLT)
	mov v1,a1
	str v3,[v1,#0]
	mov v5,#0
	str v5,[v1,#4]
	mov v5,#0
	str v5,[v1,#8]
	mov a1,v1
	b .BST_2_exit
	
.10:
	mov v3,v3
	
.11:
	ldr v1,[v4,#0]
	cmp v3,v1
	movgt v1,#1
	movle v1,#0
	cmp v1,#0
	bEQ .12
	ldr v1,[v4,#8]
	mov a3,v3
	mov a2,v1
	mov a1,v2
	bl BST_2
	mov v1,a1
	str v1,[v4,#8]
	b .14
	
.12:
	ldr v1,[v4,#0]
	cmp v3,v1
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .13
	ldr v1,[v4,#4]
	mov a3,v3
	mov a2,v1
	mov a1,v2
	bl BST_2
	mov v1,a1
	str v1,[v4,#4]
	b .14
	
.13:
	
.14:
	mov a1,v4
	b .BST_2_exit
	
.BST_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
BST_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v3,a2
	mov v4,a3
	cmp v3,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .15
	ldr a1,=L9
	bl printf(PLT)
	b .20
	
.15:
	ldr v1,[v3,#0]
	cmp v4,v1
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .16
	ldr v1,[v3,#4]
	mov a3,v4
	mov a2,v1
	mov a1,v2
	bl BST_3
	mov v1,a1
	str v1,[v3,#4]
	b .20
	
.16:
	ldr v1,[v3,#0]
	cmp v4,v1
	movgt v1,#1
	movle v1,#0
	cmp v1,#0
	bEQ .17
	ldr v1,[v3,#8]
	mov a3,v4
	mov a2,v1
	mov a1,v2
	bl BST_3
	mov v1,a1
	str v1,[v3,#8]
	b .20
	
.17:
	ldr v1,[v3,#8]
	cmp v1,#0
	movne v4,#1
	moveq v4,#0
	ldr v1,[v3,#4]
	cmp v1,#0
	movne v1,#1
	moveq v1,#0
	and v1,v4,v1
	cmp v1,#0
	bEQ .18
	ldr v1,[v3,#8]
	mov a2,v1
	mov a1,v2
	bl BST_0
	mov v1,a1
	ldr v4,[v1,#0]
	str v4,[v3,#0]
	ldr v4,[v3,#8]
	ldr v1,[v1,#0]
	mov a3,v1
	mov a2,v4
	mov a1,v2
	bl BST_3
	mov v1,a1
	str v1,[v3,#8]
	b .20
	
.18:
	ldr v1,[v3,#4]
	cmp v1,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .19
	ldr v3,[v3,#8]
	b .20
	
.19:
	ldr v3,[v3,#4]
	
.20:
	mov a1,v3
	b .BST_3_exit
	
.BST_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
BST_4:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v4,a2
	mov v3,a3
	cmp v4,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .21
	mov v1,#0
	b .24
	
.21:
	ldr v1,[v4,#0]
	cmp v3,v1
	movgt v1,#1
	movle v1,#0
	cmp v1,#0
	bEQ .22
	ldr v1,[v4,#8]
	mov a3,v3
	mov a2,v1
	mov a1,v2
	bl BST_4
	mov v1,a1
	b .24
	
.22:
	ldr v1,[v4,#0]
	cmp v3,v1
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .23
	ldr v1,[v4,#4]
	mov a3,v3
	mov a2,v1
	mov a1,v2
	bl BST_4
	mov v1,a1
	b .24
	
.23:
	mov v1,v4
	
.24:
	mov a1,v1
	b .BST_4_exit
	
.BST_4_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
BST_5:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov v3,a2
	cmp v3,#0
	moveq v2,#1
	movne v2,#0
	cmp v2,#0
	bEQ .25
	b .BST_5_exit
	
.25:
	ldr v2,[v3,#4]
	mov a2,v2
	mov a1,v1
	bl BST_5
	ldr v2,[v3,#0]
	mov a2,v2
	ldr a1,=L4
	bl printf(PLT)
	ldr v2,[v3,#8]
	mov a2,v2
	mov a1,v1
	bl BST_5
	
.26:
	
.BST_5_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
