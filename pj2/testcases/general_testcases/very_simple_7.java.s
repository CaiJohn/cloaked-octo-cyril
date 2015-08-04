.data
	
L0:
	.asciz "Goodbye again and again cruel world!\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,#1
	add v2,v1,#3
	cmp v1,v2
	movgt v1,#1
	movle v1,#0
	cmp v1,#0
	bEQ .0
	
.0:
	
.1:
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
