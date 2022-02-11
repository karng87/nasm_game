.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.LrBS_bytes:
	.string "main"
.section .data
.align 8
.align 1
.LrC2_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.LrBS_bytes
.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.LrC3_bytes:
	.string "Fibonacci"
.section .data
.align 8
.align 1
.LrC4_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.LrC3_bytes
.section .data
.align 8
.align 1
.globl Fibonacci_zdtrModule_closure
.type Fibonacci_zdtrModule_closure, @object
Fibonacci_zdtrModule_closure:
	.quad	ghczmprim_GHCziTypes_Module_con_info
	.quad	.LrC2_closure+1
	.quad	.LrC4_closure+1
	.quad	3
.section .data
.align 8
.align 1
.LrC5_closure:
	.quad	ghczmprim_GHCziTypes_Izh_con_info
	.quad	1
.section .data
.align 8
.align 1
.LrC6_closure:
	.quad	ghczmprim_GHCziTypes_Izh_con_info
	.quad	0
.section .data
.align 8
.align 1
.LuDo_srt:
	.quad	stg_SRT_2_info
	.quad	base_GHCziList_tail_closure
	.quad	Fibonacci_fibs_closure
	.quad	0
.section .data
.align 8
.align 1
.LuDp_srt:
	.quad	stg_SRT_4_info
	.quad	base_GHCziList_zzipWith_closure
	.quad	Fibonacci_fibs_closure
	.quad	.LsCO_closure
	.quad	.LsCP_closure
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.LuDo_srt-(.LsCP_info)+0
.LsCP_info:
.LcD3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .LcD4
.LcD5:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcD2
.LcD1:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	movl $Fibonacci_fibs_closure+2,%r14d
	movl $base_GHCziList_tail_closure,%ebx
	addq $-16,%rbp
	jmp stg_ap_p_fast
.LcD2:
	jmp *(%rbx)
.LcD4:
	jmp *-16(%r13)
	.size .LsCP_info, .-.LsCP_info
.section .data
.align 8
.align 1
.LsCP_closure:
	.quad	.LsCP_info
	.quad	0
	.quad	0
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	base_GHCziNum_zdfNumInt_closure-(.LsCO_info)+0
.LsCO_info:
.LcDc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .LcDd
.LcDe:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcDb
.LcDa:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	movl $base_GHCziNum_zdfNumInt_closure,%r14d
	addq $-16,%rbp
	jmp base_GHCziNum_zp_info
.LcDb:
	jmp *(%rbx)
.LcDd:
	jmp *-16(%r13)
	.size .LsCO_info, .-.LsCO_info
.section .data
.align 8
.align 1
.LsCO_closure:
	.quad	.LsCO_info
	.quad	0
	.quad	0
	.quad	0
.section .data
.align 8
.align 1
.LrC7_closure:
	.quad	ghczmprim_GHCziTypes_ZC_con_info
	.quad	.LrC5_closure+1
	.quad	.LrC8_closure
	.quad	0
.section .data
.align 8
.align 1
.globl Fibonacci_fibs_closure
.type Fibonacci_fibs_closure, @object
Fibonacci_fibs_closure:
	.quad	ghczmprim_GHCziTypes_ZC_con_info
	.quad	.LrC6_closure+1
	.quad	.LrC7_closure+2
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.LuDp_srt-(.LrC8_info)+0
.LrC8_info:
.LcDl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .LcDm
.LcDn:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .LcDk
.LcDj:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	movl $.LsCP_closure,%edi
	movl $Fibonacci_fibs_closure+2,%esi
	movl $.LsCO_closure,%r14d
	movl $base_GHCziList_zzipWith_closure,%ebx
	addq $-16,%rbp
	jmp stg_ap_ppp_fast
.LcDk:
	jmp *(%rbx)
.LcDm:
	jmp *-16(%r13)
	.size .LrC8_info, .-.LrC8_info
.section .data
.align 8
.align 1
.LrC8_closure:
	.quad	.LrC8_info
	.quad	0
	.quad	0
	.quad	0
.section .note.GNU-stack,"",@progbits
.ident "GHC 8.10.7"


