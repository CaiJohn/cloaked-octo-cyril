.data
	
L4:
	.asciz "%s\n"
	
L0:
	.asciz "B"
	
L6:
	.asciz " from peg \n"
	
L5:
	.asciz " to peg \n"
	
L8:
	.asciz "Move disk \n"
	
L2:
	.asciz "A"
	
L1:
	.asciz "C"
	
L7:
	.asciz "%i\n"
	
L3:
	.asciz "*EOL*\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,#10
	mov a1,#4
	bl _Znwj(PLT)
	mov v2,a1
	mov a2,v1
	mov a1,v2
	bl Hanoi_0
	ldr a4,=L0
	ldr a3,=L1
	ldr a2,=L2
	mov a1,v2
	bl Hanoi_1
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Hanoi_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a1
	mov v2,a2
	str v2,[v1,#0]
	
.Hanoi_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Hanoi_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v4,a1
	mov v2,a2
	mov v1,a3
	mov v3,a4
	ldr v5,[v4,#0]
	stmfd sp!,{v3}
	mov a4,v1
	mov a3,v2
	mov a2,v5
	mov a1,v4
	bl Hanoi_3
	add sp,sp,#4
	
.Hanoi_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Hanoi_2:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,a2
	mov v3,a3
	mov v2,a4
	ldr a1,=L8
	bl printf(PLT)
	mov a2,v1
	ldr a1,=L7
	bl printf(PLT)
	ldr a1,=L6
	bl printf(PLT)
	mov a2,v3
	ldr a1,=L4
	bl printf(PLT)
	ldr a1,=L5
	bl printf(PLT)
	mov a2,v2
	ldr a1,=L4
	bl printf(PLT)
	ldr a1,=L3
	bl printf(PLT)
	
.Hanoi_2_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Hanoi_3:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#28
	mov v5,a1
	str a2,[fp,#-28]
	mov v2,a3
	mov v1,a4
	ldr v3,[fp,#4]
	mov v4,#1
	ldr a1,[fp,#-28]
	cmp v4,a1
	moveq v4,#1
	movne v4,#0
	cmp v4,#0
	bEQ .0
	mov a4,v1
	mov a3,v2
	ldr a1,[fp,#-28]
	mov a2,a1
	mov a1,v5
	bl Hanoi_2
	b .Hanoi_3_exit
	
.0:
	mov a1,a1
	str a1,[fp,#-28]
	
.1:
	sub v4,a1,#1
	stmfd sp!,{v1}
	mov a4,v3
	mov a3,v2
	mov a2,v4
	mov a1,v5
	bl Hanoi_3
	add sp,sp,#4
	mov a4,v1
	mov a3,v2
	ldr a1,[fp,#-28]
	mov a2,a1
	mov a1,v5
	bl Hanoi_2
	mov v4,v4
	stmfd sp!,{v2}
	mov a4,v1
	mov a3,v3
	mov a2,v4
	mov a1,v5
	bl Hanoi_3
	add sp,sp,#4
	b .Hanoi_3_exit
	
.Hanoi_3_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
