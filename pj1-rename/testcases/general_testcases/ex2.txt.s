.data
	
L0:
	.asciz "Square of d larger than sum of squares\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#28
	mov v3,a2
	mov v2,a3
	str a4,[fp,#-28]
	ldr v5,[fp,#4]
	mov a1,#12
	bl _Znwj(PLT)
	mov v1,a1
	mov a1,#8
	bl _Znwj(PLT)
	mov v4,a1
	mov a3,#0
	mov a2,v4
	mov a1,v1
	bl Dummy_2
	mov a3,v1
	mov a2,#0
	mov a1,v1
	bl Dummy_2
	mov a1,#8
	bl _Znwj(PLT)
	mov v4,a1
	mov a2,v4
	mov a1,v1
	bl Dummy_0
	mov a1,#8
	bl _Znwj(PLT)
	mov v4,a1
	ldr a1,[fp,#-28]
	mov a3,a1
	mov a2,v2
	mov a1,v4
	bl Compute_3
	mov v2,a1
	mov a2,v3
	mov a1,v4
	bl Compute_0
	mov v3,a1
	add v3,v2,v3
	mov a2,v5
	mov a1,v4
	bl Compute_0
	mov v2,a1
	ldr v1,[v1,#0]
	mov a3,v2
	mov a2,v3
	mov a1,v1
	bl Compute_1
	cmp v2,v3
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
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Dummy_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	
.Dummy_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Dummy_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	
.Dummy_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Dummy_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	
.Dummy_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Dummy_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v3,a2
	ldr v1,[v2,#0]
	ldr v2,[v2,#8]
	mov a4,#3
	mov a3,v3
	mov a2,v2
	mov a1,v1
	bl Compute_2
	mov v1,a1
	mov a1,v1
	b .Dummy_3_exit
	
.Dummy_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Dummy_4:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,#0
	cmp v1,#0
	bEQ .2
	mov v1,#1
	mov a1,v1
	b .Dummy_4_exit
	
.2:
	mov a1,v2
	bl Dummy_5
	mov v1,a1
	str v1,[v2,#0]
	
.3:
	mov a1,v2
	bl Dummy_5
	mov v1,a1
	mov a2,#3
	mov a1,v1
	bl Compute_0
	mov v1,a1
	mov a1,v1
	b .Dummy_4_exit
	
.Dummy_4_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Dummy_5:
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
	b .Dummy_5_exit
	
.Dummy_5_exit:
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
	mov v1,a2
	mov v2,a3
	mov v3,a4
	cmp v1,v2
	movgt v4,#1
	movle v4,#0
	cmp v2,v3
	movle v1,#1
	movgt v1,#0
	and v1,v4,v1
	mov a1,v1
	b .Compute_2_exit
	
.Compute_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v3,a1
	mov v1,a2
	mov v4,a3
	ldr v2,[v3,#0]
	cmp v2,#0
	bEQ .4
	ldr v2,[v3,#4]
	mov a1,v2
	b .Compute_3_exit
	
.4:
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
	b .Compute_3_exit
	
.Compute_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
