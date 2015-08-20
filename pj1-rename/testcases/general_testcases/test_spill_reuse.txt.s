.data
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#28
	mov v1,#1
	mov v4,#2
	mov a1,#4
	bl _Znwj(PLT)
	mov v2,a1
	mov a1,#4
	bl _Znwj(PLT)
	mov v3,a1
	mov a1,#4
	bl _Znwj(PLT)
	mov v5,a1
	ldr a1,[v3,#0]
	str a1,[fp,#-28]
	ldr v3,[v5,#0]
	add v3,a1,v3
	ldr v5,[v5,#0]
	add v3,v3,v5
	str v3,[v2,#0]
	str v1,[v2,#0]
	str v4,[v2,#0]
	str v1,[v2,#0]
	str v1,[v2,#0]
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Compute_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a2
	mov v2,a3
	add v1,v1,v2
	mov a1,v1
	b .Compute_0_exit
	
.Compute_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
