.data
	
L0:
	.asciz "Goodbye again and again cruel world!\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov a1,#4
	bl _Znwj(PLT)
	mov v2,a1
	mov v1,#1
	mov a3,#7
	mov a2,v1
	mov a1,v2
	bl B_0
	mov v1,a1
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
B_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov a1,v1
	b .B_0_exit
	
.B_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
