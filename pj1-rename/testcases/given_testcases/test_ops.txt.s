.data
	
L0:
	.asciz "%i\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,#3
	add v1,v1,#3
	add v1,v1,#4
	add v1,v1,#5
	add v1,v1,#6
	add v1,v1,#7
	add v1,v1,#8
	add v1,v1,#9
	add v1,v1,#10
	add v1,v1,#11
	add v1,v1,#12
	add v1,v1,#13
	add v1,v1,#14
	add v1,v1,#15
	add v1,v1,#16
	add v1,v1,#17
	add v1,v1,#18
	add v1,v1,#19
	add v1,v1,#20
	mov a2,v1
	ldr a1,=L0
	bl printf(PLT)
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
