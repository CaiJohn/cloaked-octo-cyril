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
	mov v4,#5
	add v3,v1,#7
	stmfd sp!,{v3}
	stmfd sp!,{v1}
	mov a1,#4
	stmfd sp!,{a1}
	mov a4,v1
	mov a3,v4
	mov a2,v1
	mov a1,v2
	bl B_0
	add sp,sp,#12
	mov v1,a1
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
B_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#28
	mov v1,a2
	mov v5,a3
	str a4,[fp,#-28]
	ldr v4,[fp,#4]
	ldr v2,[fp,#8]
	ldr v3,[fp,#12]
	sub v1,v1,v5
	add v1,v1,v3
	ldr a1,[fp,#-28]
	add v3,a1,v4
	mul v1,v3,v1
	mov v3,#10
	mul v2,v3,v2
	add v1,v1,v2
	ldr a1,=L0
	bl printf(PLT)
	mov a1,v1
	b .B_0_exit
	
.B_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
