.data
	
L3:
	.asciz "Not NULL return\n"
	
L4:
	.asciz "NULL return\n"
	
L1:
	.asciz "\nSum of other 5 numbers:\n"
	
L0:
	.asciz "%i\n"
	
L2:
	.asciz "\nSum of 5 numbers:\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov a1,v2
	bl Compute_1
	mov v1,a1
	cmp v1,#0
	moveq v1,#1
	movne v1,#0
	cmp v1,#0
	bEQ .0
	ldr a1,=L4
	bl printf(PLT)
	b .1
	
.0:
	ldr a1,=L3
	bl printf(PLT)
	
.1:
	mov a1,#12
	bl _Znwj(PLT)
	mov v2,a1
	mov a1,#5
	stmfd sp!,{a1}
	mov a1,#4
	stmfd sp!,{a1}
	mov a4,#3
	mov a3,#2
	mov a2,#1
	mov a1,v2
	bl Compute_0
	add sp,sp,#8
	mov v1,a1
	ldr a1,=L2
	bl printf(PLT)
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	mov v1,#5
	rsb v1,v1,#0
	mov a1,#9
	stmfd sp!,{a1}
	mov a1,#8
	stmfd sp!,{a1}
	mov a4,#7
	mov a3,#6
	mov a2,v1
	mov a1,v2
	bl Compute_0
	add sp,sp,#8
	mov v1,a1
	ldr a1,=L1
	bl printf(PLT)
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a2
	mov v5,a3
	mov v4,a4
	ldr v3,[fp,#4]
	ldr v1,[fp,#8]
	add v2,v2,v5
	add v2,v2,v4
	add v2,v2,v3
	rsb v1,v1,#0
	sub v1,v2,v1
	mov a1,v1
	b .Compute_0_exit
	
.Compute_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,#0
	mov a1,v1
	b .Compute_1_exit
	
.Compute_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
