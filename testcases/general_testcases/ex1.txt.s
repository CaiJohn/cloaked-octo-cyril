.data
	
L0:
	.asciz "Square of d larger than sum of squares\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#32
	mov v2,a2
	mov v1,a3
	str a4,[fp,#-28]
	ldr a1,[fp,#4]
	str a1,[fp,#-32]
	mov a1,#8
	bl _Znwj(PLT)
	mov v5,a1
	mov v3,#3
	mul v3,v4,v3
	str v3,[v5,#4]
	ldr a1,[fp,#-28]
	mov a3,a1
	mov a2,v1
	mov a1,v5
	bl Compute_2
	mov v3,a1
	mov a2,v2
	mov a1,v5
	bl Compute_0
	mov v1,a1
	add v4,v3,v1
	ldr a1,[fp,#-32]
	mov a2,a1
	mov a1,v5
	bl Compute_0
	mov v1,a1
	cmp v1,v4
	movgt v1,#1
	movle v1,#0
	cmp v1,#0
	bEQ .0
	ldr a1,=L0
	bl printf(PLT)
	b .1
	
.0:
	ldr a1,=L0
	bl printf(PLT)
	
.1:
	
.2:
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Dummy_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v4,a1
	orr v2,v3,v1
	cmp v2,#0
	bEQ .3
	mov v2,#1
	mov a1,v2
	b .Dummy_0_exit
	
.3:
	cmp v3,#0
	bEQ .4
	rsb v3,v1,#1
	b .3
	
.4:
	mov a1,v4
	bl Dummy_1
	mov v1,a1
	str v1,[v4,#0]
	
.5:
	mov a1,v4
	bl Dummy_1
	mov v1,a1
	mov v2,#3
	rsb v2,v2,#0
	mov a2,v2
	mov a1,v1
	bl Compute_0
	mov v1,a1
	mov a1,v1
	b .Dummy_0_exit
	
.Dummy_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Dummy_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov a1,#8
	bl _Znwj(PLT)
	mov v2,a1
	str v2,[v1,#0]
	ldr v1,[v1,#0]
	mov a1,v1
	b .Dummy_1_exit
	
.Dummy_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a2
	mul v1,v1,v1
	mov a1,v1
	b .Compute_0_exit
	
.Compute_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a2
	mov v2,a3
	add v1,v1,v2
	mov a1,v1
	b .Compute_1_exit
	
.Compute_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v3,a1
	mov v1,a2
	mov v4,a3
	ldr v2,[v3,#0]
	cmp v2,#0
	bEQ .6
	ldr v2,[v3,#4]
	mov a1,v2
	b .Compute_2_exit
	
.6:
	mov v2,#1
	str v2,[v3,#0]
	mov a2,v1
	mov a1,v3
	bl Compute_0
	mov v1,a1
	mov a2,v4
	mov a1,v3
	bl Compute_0
	mov v2,a1
	mov a3,v2
	mov a2,v1
	mov a1,v3
	bl Compute_1
	mov v1,a1
	mov a1,v1
	b .Compute_2_exit
	
.Compute_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
