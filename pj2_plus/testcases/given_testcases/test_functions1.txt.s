.data
	
L4:
	.asciz "Square of d larger than sum of squares\n"
	
L2:
	.asciz " equal to:\n"
	
L0:
	.asciz "\n\n"
	
L1:
	.asciz "%i\n"
	
L3:
	.asciz "\nFactorial of:\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,#1
	mov v5,#2
	mov v2,#3
	mov v4,#4
	mov a1,#8
	bl _Znwj(PLT)
	mov v3,a1
	mov a3,v5
	mov a2,v1
	mov a1,v3
	bl Compute_2
	mov v5,a1
	mov a2,v2
	mov a1,v3
	bl Compute_0
	mov v1,a1
	add v2,v5,v1
	mov a2,v4
	mov a1,v3
	bl Compute_0
	mov v1,a1
	cmp v1,v2
	movgt v1,#1
	movle v1,#0
	cmp v1,#0
	bEQ .0
	ldr a1,=L4
	bl printf(PLT)
	b .1
	
.0:
	ldr a1,=L4
	bl printf(PLT)
	
.1:
	mov a2,#4
	mov a1,v3
	bl Compute_3
	mov v2,a1
	ldr a1,=L3
	bl printf(PLT)
	ldr a1,=L1
	mov a2,#4
	bl printf(PLT)
	ldr a1,=L2
	bl printf(PLT)
	mov a2,v2
	ldr a1,=L1
	bl printf(PLT)
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a2
	mul v1,v1,v1
	mov a1,v1
	b .Compute_0_exit
	
.Compute_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a2
	mov v2,a3
	add v1,v1,v2
	mov a1,v1
	b .Compute_1_exit
	
.Compute_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v3,a1
	mov v1,a2
	mov v4,a3
	ldr v2,[v3,#0]
	cmp v2,#0
	bEQ .2
	ldr v2,[v3,#4]
	mov a1,v2
	b .Compute_2_exit
	
.2:
	mov v2,#1
	str v2,[v3,#0]
	mov a2,v1
	mov a1,v3
	bl Compute_0
	mov v2,a1
	mov a2,v4
	mov a1,v3
	bl Compute_0
	mov v1,a1
	mov a3,v1
	mov a2,v2
	mov a1,v3
	bl Compute_1
	mov v1,a1
	mov a1,v1
	b .Compute_2_exit
	
.Compute_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov v3,a2
	cmp v3,#1
	movlt v2,#1
	movge v2,#0
	cmp v2,#0
	bEQ .4
	mov v2,#1
	mov a1,v2
	b .Compute_3_exit
	
.4:
	sub v2,v3,#1
	mov a2,v2
	mov a1,v1
	bl Compute_3
	mov v1,a1
	mul v2,v3,v1
	mov a1,v2
	b .Compute_3_exit
	
.Compute_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
