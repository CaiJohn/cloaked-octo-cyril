.data
	
L1:
	.asciz "d < -10000\n"
	
L0:
	.asciz "d < 10000\n"
	
L2:
	.asciz "%i\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	ldr v2,=1025
	mov v1,#1020
	add v2,v1,v2
	ldr v1,=3000
	add v1,v2,v1
	ldr v2,=1230000
	mov a2,v2
	ldr a1,=L2
	bl printf(PLT)
	ldr v2,=12345
	rsb v3,v2,#0
	ldr v2,=10000
	rsb v2,v2,#0
	cmp v3,v2
	movlt v2,#1
	movge v2,#0
	cmp v2,#0
	bEQ .0
	ldr a1,=L1
	bl printf(PLT)
	b .1
	
.0:
	ldr a1,=L0
	bl printf(PLT)
	
.1:
	mov a1,#4
	bl _Znwj(PLT)
	mov v3,a1
	ldr v4,=32455
	ldr v2,=10000
	stmfd sp!,{v2}
	mov a1,#1000
	stmfd sp!,{a1}
	mov a4,v4
	mov a3,v1
	mov a2,#2
	mov a1,v3
	bl Compute_0
	add sp,sp,#8
	ldr v1,[v3,#0]
	str v1,[v3,#0]
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a2
	mov v4,a3
	mov v5,a4
	ldr v2,[fp,#4]
	ldr v3,[fp,#8]
	add v1,v1,v4
	add v1,v1,v5
	add v1,v1,v2
	add v1,v1,v3
	mov a2,v1
	ldr a1,=L2
	bl printf(PLT)
	
.Compute_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
