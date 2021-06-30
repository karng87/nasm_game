section .data
        codes:
            db  '0123456789ABCDEF'

section .text
        global main
        main:

            mov rax, 0x_1122_3344_5566_7788 ;64bit
            mov rdi, 1
            mov rdx, 1
            mov rcx, 64 ; 0x_0000_0000_0110_0100

          lp:
            push rax
            sub rcx, 4  ;0x_0110_0000
            sar rax, cl ; rax = 0x_0000_0000_0000_1122 = 0b_0001_0001_0010_0010
            and rax, 0b_1111 ; 0b_0001_0001_0000_0000
            lea rsi, [codes + rax]
            mov rax, 1
            push rcx
            syscall

            pop rcx
            pop rax
            test rcx, rcx ; test Op have no destination only try and watch flags, only 0 then ZF = 0
            jnz lp

            mov rax, 60
            mov rdi, 0
            syscall
            
