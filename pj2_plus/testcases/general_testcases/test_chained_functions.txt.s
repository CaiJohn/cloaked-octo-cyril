.data
	
L0:
	.asciz "%i\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#32
	mov v3,#1
	mov a2,#2
	str a2,[fp,#-32]
	mov a1,#3
	str a1,[fp,#-28]
	mov v5,#4
	mov v2,#5
	add v1,v3,a2
	add v1,v1,a1
	add v1,v1,v5
	add v4,v1,v2
	mov a1,#4
	bl _Znwj(PLT)
	mov v1,a1
	mov a2,v3
	mov a1,v1
	bl Compute_0
	mov v1,a1
	ldr a1,[fp,#-32]
	mov a3,a1
	mov a2,v3
	mov a1,v1
	bl Compute_1
	mov v1,a1
	ldr a1,[fp,#-28]
	mov a4,a1
	ldr a1,[fp,#-32]
	mov a3,a1
	mov a2,v3
	mov a1,v1
	bl Compute_2
	mov v1,a1
	stmfd sp!,{v5}
	ldr a1,[fp,#-28]
	mov a4,a1
	ldr a1,[fp,#-32]
	mov a3,a1
	mov a2,v3
	mov a1,v1
	bl Compute_3
	add sp,sp,#4
	mov v1,a1
	stmfd sp!,{v2}
	stmfd sp!,{v5}
	ldr a1,[fp,#-28]
	mov a4,a1
	ldr a1,[fp,#-32]
	mov a3,a1
	mov a2,v3
	mov a1,v1
	bl Compute_4
	add sp,sp,#8
	mov v1,a1
	ldr v1,[v1,#0]
	add v1,v1,#3
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	mov a2,v4
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,a2
	str v1,[v2,#0]
	mov a1,v2
	b .Compute_0_exit
	
.Compute_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v2,a1
	mov v1,a2
	mov v3,a3
	ldr v4,[v2,#0]
	add v1,v4,v1
	add v1,v1,v3
	str v1,[v2,#0]
	mov a1,v2
	b .Compute_1_exit
	
.Compute_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v3,a1
	mov v2,a2
	mov v5,a3
	mov v4,a4
	ldr v1,[v3,#0]
	add v1,v1,v2
	add v1,v1,v5
	add v1,v1,v4
	str v1,[v3,#0]
	mov a1,v3
	b .Compute_2_exit
	
.Compute_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#28
	mov v3,a1
	mov v1,a2
	mov v5,a3
	str a4,[fp,#-28]
	ldr v4,[fp,#4]
	ldr v2,[v3,#0]
	add v1,v2,v1
	add v1,v1,v5
	ldr a1,[fp,#-28]
	add v1,v1,a1
	add v1,v1,v4
	str v1,[v3,#0]
	mov a1,v3
	b .Compute_3_exit
	
.Compute_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_4:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#32
	mov v4,a1
	mov v2,a2
	mov v3,a3
	str a4,[fp,#-32]
	ldr v5,[fp,#4]
	ldr a1,[fp,#8]
	str a1,[fp,#-28]
	ldr v1,[v4,#0]
	add v1,v1,v2
	add v1,v1,v3
	ldr a2,[fp,#-32]
	add v1,v1,a2
	add v1,v1,v5
	ldr a1,[fp,#-28]
	add v1,v1,a1
	str v1,[v4,#0]
	mov a1,v4
	b .Compute_4_exit
	
.Compute_4_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
