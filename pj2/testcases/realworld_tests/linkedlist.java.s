.data
	
L10:
	.asciz "Print Start\n"
	
L0:
	.asciz "removing everything...\n"
	
L5:
	.asciz "Add 8 at index = 0\n"
	
L9:
	.asciz "Print End\n"
	
L7:
	.asciz "remove index = 2\n"
	
L3:
	.asciz "Node at index 20 = \n"
	
L2:
	.asciz "Node not found\n"
	
L1:
	.asciz "%i\n"
	
L8:
	.asciz "Adding 1 2 3 4 5\n"
	
L6:
	.asciz "Add 10 at the end\n"
	
L4:
	.asciz "Node at index 3 = \n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov a1,#8
	bl _Znwj(PLT)
	mov v2,a1
	mov a1,v2
	bl LinkedList_0
	ldr a1,=L8
	bl printf(PLT)
	mov a2,#1
	mov a1,v2
	bl LinkedList_1
	mov a2,#2
	mov a1,v2
	bl LinkedList_1
	mov a2,#3
	mov a1,v2
	bl LinkedList_1
	mov a2,#4
	mov a1,v2
	bl LinkedList_1
	mov a2,#5
	mov a1,v2
	bl LinkedList_1
	mov a1,v2
	bl LinkedList_6
	ldr a1,=L7
	bl printf(PLT)
	mov a2,#2
	mov a1,v2
	bl LinkedList_4
	mov a1,v2
	bl LinkedList_6
	ldr a1,=L6
	bl printf(PLT)
	mov a2,#10
	mov a1,v2
	bl LinkedList_1
	mov a1,v2
	bl LinkedList_6
	ldr a1,=L5
	bl printf(PLT)
	mov a3,#0
	mov a2,#8
	mov a1,v2
	bl LinkedList_2
	mov a1,v2
	bl LinkedList_6
	mov a2,#3
	mov a1,v2
	bl LinkedList_3
	mov v3,a1
	ldr a1,=L4
	bl printf(PLT)
	cmp v3,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .0
	ldr a1,=L2
	bl printf(PLT)
	b .1
	
.0:
	mov a1,v3
	bl Node_2
	mov v1,a1
	mov a2,v1
	ldr a1,=L1
	bl printf(PLT)
	
.1:
	mov a2,#20
	mov a1,v2
	bl LinkedList_3
	mov v3,a1
	ldr a1,=L3
	bl printf(PLT)
	cmp v3,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .2
	ldr a1,=L2
	bl printf(PLT)
	b .3
	
.2:
	mov a1,v3
	bl Node_2
	mov v1,a1
	mov a2,v1
	ldr a1,=L1
	bl printf(PLT)
	
.3:
	ldr a1,=L0
	bl printf(PLT)
	
.4:
	mov a1,v2
	bl LinkedList_5
	mov v1,a1
	cmp v1,#0
	movgt v1,#1
	movle v1,#0
	cmp v1,#0
	bEQ .5
	mov a2,#0
	mov a1,v2
	bl LinkedList_4
	b .4
	
.5:
	mov a1,v2
	bl LinkedList_6
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Node_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v3,a2
	mov v1,#0
	str v1,[v2,#0]
	str v3,[v2,#4]
	
.Node_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Node_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v3,a2
	mov v1,a3
	str v1,[v2,#0]
	str v3,[v2,#4]
	
.Node_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Node_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	ldr v1,[v1,#4]
	mov a1,v1
	b .Node_2_exit
	
.Node_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Node_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov v2,a2
	str v2,[v1,#4]
	
.Node_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Node_4:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	ldr v1,[v1,#0]
	mov a1,v1
	b .Node_4_exit
	
.Node_4_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Node_5:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,a2
	str v1,[v2,#0]
	
.Node_5_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
LinkedList_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov a1,#8
	bl _Znwj(PLT)
	mov v2,a1
	str v2,[v1,#0]
	ldr v2,[v1,#0]
	mov v3,#1
	rsb v3,v3,#0
	mov a2,v3
	mov a1,v2
	bl Node_0
	mov v2,#0
	str v2,[v1,#4]
	
.LinkedList_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
LinkedList_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v3,a1
	mov v1,a2
	mov a1,#8
	bl _Znwj(PLT)
	mov v2,a1
	mov a2,v1
	mov a1,v2
	bl Node_0
	ldr v4,[v3,#0]
	
.6:
	mov a1,v4
	bl Node_4
	mov v1,a1
	cmp v1,#0
	movne v1,#1
	moveq v1,#0
	cmp v1,#0
	bEQ .7
	mov a1,v4
	bl Node_4
	mov v4,a1
	b .6
	
.7:
	mov a2,v2
	mov a1,v4
	bl Node_5
	ldr v1,[v3,#4]
	add v1,v1,#1
	str v1,[v3,#4]
	
.LinkedList_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
LinkedList_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#32
	mov v5,a1
	mov v3,a2
	mov v1,a3
	mov a1,#8
	bl _Znwj(PLT)
	mov v2,a1
	mov a2,v3
	mov a1,v2
	bl Node_0
	ldr a2,[v5,#0]
	str a2,[fp,#-32]
	mov v3,#0
	
.8:
	cmp v3,v1
	movlt a1,#1
	movge a1,#0
	str a1,[fp,#-28]
	ldr a1,[fp,#-32]
	mov a1,a1
	bl Node_4
	mov v4,a1
	cmp v4,#0
	movne v4,#1
	moveq v4,#0
	ldr a1,[fp,#-28]
	and v4,a1,v4
	cmp v4,#0
	bEQ .9
	ldr a1,[fp,#-32]
	mov a1,a1
	bl Node_4
	mov a2,a1
	str a2,[fp,#-32]
	add v3,v3,#1
	b .8
	
.9:
	ldr a1,[fp,#-32]
	mov a1,a1
	bl Node_4
	mov v1,a1
	mov a2,v1
	mov a1,v2
	bl Node_5
	mov a2,v2
	ldr a1,[fp,#-32]
	mov a1,a1
	bl Node_5
	ldr v1,[v5,#4]
	add v1,v1,#1
	str v1,[v5,#4]
	
.LinkedList_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
LinkedList_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov v2,a2
	cmp v2,#0
	movlt v3,#1
	movge v3,#0
	cmp v3,#0
	bEQ .10
	mov v3,#0
	mov a1,v3
	b .LinkedList_3_exit
	
.10:
	ldr v1,[v1,#0]
	mov a1,v1
	bl Node_4
	mov v4,a1
	
.11:
	mov v3,#0
	
.12:
	cmp v3,v2
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .15
	mov a1,v4
	bl Node_4
	mov v1,a1
	cmp v1,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .13
	mov v1,#0
	mov a1,v1
	b .LinkedList_3_exit
	
.13:
	mov v3,v3
	
.14:
	mov a1,v4
	bl Node_4
	mov v4,a1
	add v3,v3,#1
	b .12
	
.15:
	mov a1,v4
	b .LinkedList_3_exit
	
.LinkedList_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
LinkedList_4:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v3,a1
	mov v2,a2
	cmp v2,#0
	movlt v4,#1
	movge v4,#0
	mov a1,v3
	bl LinkedList_5
	mov v1,a1
	cmp v2,v1
	movge v1,#1
	movlt v1,#0
	orr v1,v4,v1
	cmp v1,#0
	bEQ .16
	mov v1,#0
	mov a1,v1
	b .LinkedList_4_exit
	
.16:
	
.17:
	ldr v4,[v3,#0]
	mov v5,#0
	
.18:
	cmp v5,v2
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .21
	mov a1,v4
	bl Node_4
	mov v1,a1
	cmp v1,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .19
	mov v1,#0
	mov a1,v1
	b .LinkedList_4_exit
	
.19:
	add v5,v5,#1
	
.20:
	mov a1,v4
	bl Node_4
	mov v4,a1
	b .18
	
.21:
	mov a1,v4
	bl Node_4
	mov v1,a1
	mov a1,v1
	bl Node_4
	mov v1,a1
	mov a2,v1
	mov a1,v4
	bl Node_5
	ldr v1,[v3,#4]
	sub v1,v1,#1
	str v1,[v3,#4]
	mov v1,#1
	mov a1,v1
	b .LinkedList_4_exit
	
.LinkedList_4_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
LinkedList_5:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	ldr v1,[v1,#4]
	mov a1,v1
	b .LinkedList_5_exit
	
.LinkedList_5_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
LinkedList_6:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	ldr v1,[v1,#0]
	mov a1,v1
	bl Node_4
	mov v1,a1
	ldr a1,=L10
	bl printf(PLT)
	
.22:
	cmp v1,#0
	movne v2,#1
	moveq v2,#0
	cmp v2,#0
	bEQ .23
	mov a1,v1
	bl Node_2
	mov v2,a1
	mov a2,v2
	ldr a1,=L1
	bl printf(PLT)
	mov a1,v1
	bl Node_4
	mov v1,a1
	b .22
	
.23:
	ldr a1,=L9
	bl printf(PLT)
	b .LinkedList_6_exit
	
.LinkedList_6_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
