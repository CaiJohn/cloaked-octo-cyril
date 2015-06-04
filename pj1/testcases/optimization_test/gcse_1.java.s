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
	sub sp,fp,#52
	mov v3,#5
	cmp v3,#7
	movlt v1,#1
	movge v1,#0
	cmp v1,#0
	bEQ .0
	ldr a1,[fp,#-28]
	ldr a2,[fp,#-44]
	add a3,a1,a2
	str a3,[fp,#-32]
	ldr a3,[fp,#-52]
	mul v2,a3,v4
	sub a3,v5,#6
	str a3,[fp,#-36]
	mov v5,#8
	b .1
	
.0:
	ldr a1,[fp,#-28]
	ldr a2,[fp,#-44]
	add a3,a1,a2
	str a3,[fp,#-36]
	sub v2,v5,#6
	
.1:
	add v1,a1,a2
	ldr a3,[fp,#-52]
	mul a2,a3,v4
	str a2,[fp,#-48]
	sub a4,v5,#6
	str a4,[fp,#-40]
	mov a2,v3
	ldr a1,=L1
	bl printf(PLT)
	ldr a2,[fp,#-32]
	mov a2,a2
	ldr a1,=L1
	bl printf(PLT)
	ldr a1,[fp,#-28]
	mov a2,a1
	ldr a1,=L1
	bl printf(PLT)
	ldr a1,[fp,#-44]
	mov a2,a1
	ldr a1,=L1
	bl printf(PLT)
	mov a2,v2
	ldr a1,=L1
	bl printf(PLT)
	ldr a3,[fp,#-52]
	mov a2,a3
	ldr a1,=L1
	bl printf(PLT)
	mov a2,v4
	ldr a1,=L1
	bl printf(PLT)
	ldr a3,[fp,#-36]
	mov a2,a3
	ldr a1,=L1
	bl printf(PLT)
	mov a2,v5
	ldr a1,=L1
	bl printf(PLT)
	mov a2,v1
	ldr a1,=L1
	bl printf(PLT)
	ldr a2,[fp,#-48]
	mov a2,a2
	ldr a1,=L1
	bl printf(PLT)
	ldr a4,[fp,#-40]
	mov a2,a4
	ldr a1,=L1
	bl printf(PLT)
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
