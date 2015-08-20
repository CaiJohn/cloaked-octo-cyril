.data
	
L0:
	.asciz "Goodbye cruel world!\n"
	
L1:
	.asciz "%i\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	add v4,v1,#1
	mov v2,v1
	mov v3,v1
	mov a2,v1
	ldr a1,=L1
	bl printf(PLT)
	mov a2,v3
	ldr a1,=L1
	bl printf(PLT)
	mov a2,v4
	ldr a1,=L1
	bl printf(PLT)
	mov a2,v2
	ldr a1,=L1
	bl printf(PLT)
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
