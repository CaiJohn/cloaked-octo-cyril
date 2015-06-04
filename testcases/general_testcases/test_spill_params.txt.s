.data
	
L2:
	.asciz "a:\n"
	
L1:
	.asciz "b:\n"
	
L0:
	.asciz "%i\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#28
	mov v2,#1
	mov v3,#2
	mov a1,#3
	str a1,[fp,#-28]
	mov v4,#4
	mov v1,#5
	add v3,v2,v3
	add v3,v3,a1
	add v3,v3,v4
	add v5,v3,v1
	add v3,v5,v5
	add v1,v5,v3
	sub v5,v1,v5
	mov a1,#8
	bl _Znwj(PLT)
	mov v1,a1
	mov a1,#9
	stmfd sp!,{a1}
	stmfd sp!,{v4}
	stmfd sp!,{v3}
	stmfd sp!,{v5}
	mov a4,v2
	ldr a1,[fp,#-28]
	mov a3,a1
	mov a2,#1
	mov a1,v1
	bl Cls_0
	add sp,sp,#16
	mov a1,#8
	bl _Znwj(PLT)
	mov v1,a1
	mov a1,v1
	bl Cls_1
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Cls_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#36
	mov v4,a1
	mov v2,a2
	mov v5,a3
	str a4,[fp,#-32]
	ldr a1,[fp,#4]
	str a1,[fp,#-36]
	ldr a1,[fp,#8]
	str a1,[fp,#-28]
	ldr v3,[fp,#12]
	ldr v1,[fp,#16]
	add v2,v2,v5
	ldr a2,[fp,#-32]
	add v2,v2,a2
	ldr a3,[fp,#-36]
	add v2,v2,a3
	ldr a1,[fp,#-28]
	add v2,v2,a1
	str v2,[v4,#0]
	add v1,v3,v1
	str v1,[v4,#4]
	ldr a1,=L2
	bl printf(PLT)
	ldr v1,[v4,#0]
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	ldr a1,=L1
	bl printf(PLT)
	ldr v1,[v4,#4]
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	
.Cls_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Cls_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov a1,#7
	stmfd sp!,{a1}
	mov a1,#6
	stmfd sp!,{a1}
	mov a1,#5
	stmfd sp!,{a1}
	mov a1,#4
	stmfd sp!,{a1}
	mov a4,#3
	mov a3,#2
	mov a2,#1
	mov a1,v1
	bl Cls_0
	add sp,sp,#16
	
.Cls_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
