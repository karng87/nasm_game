.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.Lr15h_bytes:
	.string "main"
.section .data
.align 8
.align 1
.Lr15r_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.Lr15h_bytes
.section .rodata.str,"aMS",@progbits,1
.align 1
.align 1
.Lr15s_bytes:
	.string "Fibonacci"
.section .data
.align 8
.align 1
.Lr15t_closure:
	.quad	ghczmprim_GHCziTypes_TrNameS_con_info
	.quad	.Lr15s_bytes
.section .data
.align 8
.align 1
.globl Fibonacci_zdtrModule_closure
.type Fibonacci_zdtrModule_closure, @object
Fibonacci_zdtrModule_closure:
	.quad	ghczmprim_GHCziTypes_Module_con_info
	.quad	.Lr15r_closure+1
	.quad	.Lr15t_closure+1
	.quad	3
.section .data
.align 8
.align 1
.Lu16j_srt:
	.quad	stg_SRT_3_info
	.quad	base_GHCziList_tail_closure
	.quad	base_GHCziList_zzipWith_closure
	.quad	base_GHCziNum_zdfNumInt_closure
	.quad	0
.section .text
.align 8
.align 8
	.quad	1
	.long	16
	.long	base_GHCziList_tail_closure-(.Ls15C_info)+0
.Ls15C_info:
.Lc15Z:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .Lc160
.Lc161:
	movq $stg_upd_frame_info,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	movl $base_GHCziList_tail_closure,%ebx
	addq $-16,%rbp
	jmp stg_ap_p_fast
.Lc160:
	jmp *-16(%r13)
	.size .Ls15C_info, .-.Ls15C_info
.section .text
.align 8
.align 8
	.quad	0
	.long	15
	.long	base_GHCziNum_zdfNumInt_closure-(.Ls15B_info)+0
.Ls15B_info:
.Lc166:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .Lc167
.Lc168:
	movq $stg_upd_frame_info,-16(%rbp)
	movq %rbx,-8(%rbp)
	movl $base_GHCziNum_zdfNumInt_closure,%r14d
	addq $-16,%rbp
	jmp base_GHCziNum_zp_info
.Lc167:
	jmp *-16(%r13)
	.size .Ls15B_info, .-.Ls15B_info
.section .text
.align 8
.align 8
	.quad	1
	.long	16
	.long	.Lu16j_srt-(.Ls15A_info)+0
.Ls15A_info:
.Lc169:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .Lc16a
.Lc16b:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja .Lc16d
.Lc16c:
	movq $stg_upd_frame_info,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq $.Ls15C_info,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rbx
	movq $.Ls15B_info,-8(%r12)
	leaq -8(%r12),%rcx
	movq %rbx,%rdi
	movq %rax,%rsi
	movq %rcx,%r14
	movl $base_GHCziList_zzipWith_closure,%ebx
	addq $-16,%rbp
	jmp stg_ap_ppp_fast
.Lc16d:
	movq $40,904(%r13)
.Lc16a:
	jmp *-16(%r13)
	.size .Ls15A_info, .-.Ls15A_info
.section .text
.align 8
.align 8
	.quad	4294967301
	.quad	2
	.long	14
	.long	0
.globl Fibonacci_fibonacci_info
.type Fibonacci_fibonacci_info, @function
Fibonacci_fibonacci_info:
.Lc16e:
.Lc16g:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja .Lc16i
.Lc16h:
	leaq -62(%r12),%rax
	leaq -38(%r12),%rbx
	leaq -16(%r12),%rcx
	movq $ghczmprim_GHCziTypes_ZC_con_info,-64(%r12)
	movq $stg_INTLIKE_closure+273,-56(%r12)
	movq %rcx,-48(%r12)
	movq $ghczmprim_GHCziTypes_ZC_con_info,-40(%r12)
	movq $stg_INTLIKE_closure+257,-32(%r12)
	movq %rax,-24(%r12)
	movq $.Ls15A_info,-16(%r12)
	movq %rbx,(%r12)
	movq %r14,%rsi
	movq %rbx,%r14
	movl $base_GHCziList_znzn_closure,%ebx
	jmp stg_ap_pp_fast
.Lc16i:
	movq $72,904(%r13)
.Lc16f:
	movl $Fibonacci_fibonacci_closure,%ebx
	jmp *-8(%r13)
	.size Fibonacci_fibonacci_info, .-Fibonacci_fibonacci_info
.section .data
.align 8
.align 1
.globl Fibonacci_fibonacci_closure
.type Fibonacci_fibonacci_closure, @object
Fibonacci_fibonacci_closure:
	.quad	Fibonacci_fibonacci_info
	.quad	base_GHCziList_znzn_closure
	.quad	.Lu16j_srt
	.quad	0
.section .data
.align 8
.align 1
.Lu16P_srt:
	.quad	stg_SRT_3_info
	.quad	base_GHCziReal_fromIntegral_closure
	.quad	base_ForeignziCziTypes_zdfIntegralCInt_closure
	.quad	base_GHCziNum_zdfNumInt_closure
	.quad	0
.section .data
.align 8
.align 1
.Lu16Q_srt:
	.quad	stg_SRT_3_info
	.quad	base_GHCziBase_zi_closure
	.quad	Fibonacci_fibonacci_closure
	.quad	.Lu16P_srt
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	15
	.long	.Lu16P_srt-(.Ls15E_info)+0
.Ls15E_info:
.Lc16H:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .Lc16I
.Lc16J:
	movq $stg_upd_frame_info,-16(%rbp)
	movq %rbx,-8(%rbp)
	movl $base_GHCziNum_zdfNumInt_closure,%esi
	movl $base_ForeignziCziTypes_zdfIntegralCInt_closure,%r14d
	movl $base_GHCziReal_fromIntegral_closure,%ebx
	addq $-16,%rbp
	jmp stg_ap_pp_fast
.Lc16I:
	jmp *-16(%r13)
	.size .Ls15E_info, .-.Ls15E_info
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.Lu16Q_srt-(.Ls15F_info)+0
.Ls15F_info:
.Lc16K:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .Lc16L
.Lc16M:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja .Lc16O
.Lc16N:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .Lc16C
.Lc16B:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	movq $.Ls15E_info,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	movl $Fibonacci_fibonacci_closure+1,%r14d
	movl $base_GHCziBase_zi_closure,%ebx
	addq $-16,%rbp
	jmp stg_ap_pp_fast
.Lc16C:
	jmp *(%rbx)
.Lc16O:
	movq $16,904(%r13)
.Lc16L:
	jmp *-16(%r13)
	.size .Ls15F_info, .-.Ls15F_info
.section .data
.align 8
.align 1
.Ls15F_closure:
	.quad	.Ls15F_info
	.quad	0
	.quad	0
	.quad	0
.section .data
.align 8
.align 1
.Lu17a_srt:
	.quad	stg_SRT_3_info
	.quad	base_GHCziReal_fromIntegral_closure
	.quad	base_ForeignziCziTypes_zdfNumCInt_closure
	.quad	base_GHCziReal_zdfIntegralInt_closure
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.Lu17a_srt-(.Ls15D_info)+0
.Ls15D_info:
.Lc177:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .Lc178
.Lc179:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .Lc176
.Lc175:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	movl $base_ForeignziCziTypes_zdfNumCInt_closure,%esi
	movl $base_GHCziReal_zdfIntegralInt_closure,%r14d
	movl $base_GHCziReal_fromIntegral_closure,%ebx
	addq $-16,%rbp
	jmp stg_ap_pp_fast
.Lc176:
	jmp *(%rbx)
.Lc178:
	jmp *-16(%r13)
	.size .Ls15D_info, .-.Ls15D_info
.section .data
.align 8
.align 1
.Ls15D_closure:
	.quad	.Ls15D_info
	.quad	0
	.quad	0
	.quad	0
.section .data
.align 8
.align 1
.Lu17q_srt:
	.quad	stg_SRT_3_info
	.quad	base_GHCziBase_zi_closure
	.quad	.Ls15D_closure
	.quad	.Ls15F_closure
	.quad	0
.section .text
.align 8
.align 8
	.quad	0
	.long	21
	.long	.Lu17q_srt-(Fibonacci_fibonaccizuhs_info)+0
.globl Fibonacci_fibonaccizuhs_info
.type Fibonacci_fibonaccizuhs_info, @function
Fibonacci_fibonaccizuhs_info:
.Lc17n:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb .Lc17o
.Lc17p:
	subq $8,%rsp
	movq %r13,%rax
	movq %rbx,%rsi
	movq %rax,%rdi
	xorl %eax,%eax
	call newCAF
	addq $8,%rsp
	testq %rax,%rax
	je .Lc17m
.Lc17l:
	movq $stg_bh_upd_frame_info,-16(%rbp)
	movq %rax,-8(%rbp)
	movl $.Ls15F_closure,%esi
	movl $.Ls15D_closure,%r14d
	movl $base_GHCziBase_zi_closure,%ebx
	addq $-16,%rbp
	jmp stg_ap_pp_fast
.Lc17m:
	jmp *(%rbx)
.Lc17o:
	jmp *-16(%r13)
	.size Fibonacci_fibonaccizuhs_info, .-Fibonacci_fibonaccizuhs_info
.section .data
.align 8
.align 1
.globl Fibonacci_fibonaccizuhs_closure
.type Fibonacci_fibonaccizuhs_closure, @object
Fibonacci_fibonaccizuhs_closure:
	.quad	Fibonacci_fibonaccizuhs_info
	.quad	0
	.quad	0
	.quad	0
.section .data
.align 8
.globl Fibonacci_zdfstableZZC0ZZCmainZZCFibonacciZZCfibonaccizzuhs_closure
.equiv Fibonacci_zdfstableZZC0ZZCmainZZCFibonacciZZCfibonaccizzuhs_closure,Fibonacci_fibonaccizuhs_closure
.section .note.GNU-stack,"",@progbits
.ident "GHC 8.10.7"


