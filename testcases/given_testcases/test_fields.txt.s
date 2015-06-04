.data
	
L0:
	.asciz "%i\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov a1,#4
	bl _Znwj(PLT)
	mov v2,a1
	mov a2,#5
	mov a1,v2
	bl FieldAccess_0
	mov v3,a1
	mov v1,#7
	str v1,[v2,#0]
	ldr v1,[v2,#0]
	add v1,v1,v3
	add v1,v1,v1
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
FieldAccess_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a2
	mov v1,#6
	add v1,v1,v2
	mov a1,v1
	b .FieldAccess_0_exit
	
.FieldAccess_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
