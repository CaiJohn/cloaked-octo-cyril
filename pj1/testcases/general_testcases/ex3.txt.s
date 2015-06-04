.data
	
L0:
	.asciz "Square of d larger than sum of squares\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#28
	mov v2,a2
	mov v1,a3
	mov v5,a4
	ldr v4,[fp,#4]
	mov a1,#12
	bl _Znwj(PLT)
	mov v3,a1
	mov a1,#12
	bl _Znwj(PLT)
	mov a1,a1
	str a1,[fp,#-28]
	mov a3,v5
	mov a2,v1
	ldr a1,[fp,#-28]
	mov a1,a1
	bl Compute_3
	mov v5,a1
	mov a1,#12
	bl _Znwj(PLT)
	mov v1,a1
	mov a2,v2
	mov a1,v1
	bl Compute_1
	mov v1,a1
	add v2,v5,v1
	mov a2,v4
	mov a1,v3
	bl Compute_1
	mov v1,a1
	mov a3,v4
	mov a2,#0
	mov a1,v3
	bl Compute_2
	mov v1,a1
	cmp v1,v2
	movgt v2,#1
	movle v2,#0
	cmp v3,#0
	movne v1,#1
	moveq v1,#0
	and v1,v2,v1
	cmp v1,#0
	bEQ .0
	ldr a1,=L0
	bl printf(PLT)
	b .1
	
.0:
	ldr a1,=L0
	bl printf(PLT)
	
.1:
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,#0
	str v1,[v2,#8]
	
.Compute_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,a2
	mov a3,#2
	mov a2,#1
	mov a1,v2
	bl Compute_3
	mov v2,a1
	mul v1,v2,v1
	mov a1,v1
	b .Compute_1_exit
	
.Compute_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a3
	mov a1,v1
	b .Compute_2_exit
	
.Compute_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,a2
	mov v3,a3
	
.2:
	cmp v1,v3
	movgt v1,#1
	movle v1,#0
	mov v4,#0
	and v1,v1,v4
	cmp v1,#0
	bEQ .5
	ldr v1,[v2,#0]
	cmp v1,#0
	bEQ .3
	ldr v1,[v2,#4]
	mov a1,v1
	b .Compute_3_exit
	
.3:
	mov v1,#1
	str v1,[v2,#0]
	mov a1,#12
	bl _Znwj(PLT)
	mov v4,a1
	mov a2,v3
	mov a1,v2
	bl Compute_1
	mov v1,a1
	mov a3,v1
	mov a2,v4
	mov a1,v2
	bl Compute_2
	mov v1,a1
	mov a1,v1
	b .Compute_3_exit
	
.5:
	mov v1,#1
	mov a1,v1
	b .Compute_3_exit
	
.Compute_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
