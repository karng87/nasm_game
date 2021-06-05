section .data
    var1: dq 0x_1111_1111_1111_1111
    var2: dq 0

section .bss
section .text
    global main
    main:
        ;; bit 
        mov rax, 0x0000_0000_ffff_ffff
        sal rax, 32
        sal rax, 1

        clc
        mov rax, 0x_0000_0000_ffff_ffff
        shr rax, 1
        shr rax, 31

        clc
        mov rax, 0x_0000_0000_ffff_ffff
        sar rax, 1
        clc
        mov rax, 0x_ffff_ffff_ffff_ffff
        sar rax, 1

        clc
        mov rax, 0x_0123_4567_89ab_cdef
        ror rax, 8
        ror rax, 12
        ror rax, 44

        mov rax, 60
        mov rdi, 0
        syscall
