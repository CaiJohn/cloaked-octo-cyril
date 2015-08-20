.data
	
L1:
	.asciz "true\n"
	
L0:
	.asciz "false\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,#4
	mov v3,#5
	mov v5,#1
	mov v2,#0
	and v4,v5,v2
	orr v4,v4,v2
	orr v2,v5,v2
	orr v4,v4,v2
	cmp v1,v3
	movlt v2,#1
	movge v2,#0
	and v2,v2,v4
	cmp v2,#0
	bEQ .0
	ldr a1,=L1
	bl printf(PLT)
	b .1
	
.0:
	ldr a1,=L0
	bl printf(PLT)
	
.1:
	cmp v1,v3
	movgt v1,#1
	movle v1,#0
	orr v1,v4,v1
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
	
BoolOps_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a2
	mov v1,#6
	add v1,v1,v2
	mov a1,v1
	b .BoolOps_0_exit
	
.BoolOps_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
