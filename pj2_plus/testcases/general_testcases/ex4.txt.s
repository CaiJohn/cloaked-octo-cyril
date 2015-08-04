.data
	
L0:
	.asciz "Hello!\n"
	.text
	.global main
	
main:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov a1,#4
	bl _Znwj(PLT)
	mov v2,a1
	
.0:
	cmp v2,#0
	movne v1,#1
	moveq v1,#0
	and v3,v1,v3
	mov a1,v2
	bl Foo_0
	mov v1,a1
	and v1,v3,v1
	cmp v1,#0
	bEQ .1
	
.1:
	mov a1,v2
	bl Foo_0
	mov v1,a1
	mov v3,#1
	orr v3,v3,v1
	mov a1,#4
	bl _Znwj(PLT)
	mov v4,a1
	mov v1,#1
	orr v1,v1,#1
	mov v5,#1
	orr v1,v1,v5
	orr v1,v1,#0
	str v1,[v4,#0]
	cmp v2,#0
	movne v4,#1
	moveq v4,#0
	mov a1,v2
	bl Foo_0
	mov v1,a1
	and v4,v4,v1
	ldr v1,[v2,#0]
	rsb v1,v1,#1
	orr v1,v4,v1
	cmp v1,#0
	bEQ .2
	
.2:
	
.3:
	mov v4,#0
	mov a1,v2
	bl Foo_0
	mov v1,a1
	rsb v1,v1,#1
	and v1,v4,v1
	orr v1,v3,v1
	cmp v1,#0
	bEQ .4
	
.4:
	
.main_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Foo_0:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	mov v1,#0
	mov a1,v1
	b .Foo_0_exit
	
.Foo_0_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
	
Foo_1:
	stmfd sp!,{v1,v2,v3,v4,v5,fp,lr}
	add fp,sp,#24
	sub sp,fp,#24
	ldr a1,=L0
	bl printf(PLT)
	
.Foo_1_exit:
	sub sp,fp,#24
	ldmfd sp!,{v1,v2,v3,v4,v5,fp,pc}
