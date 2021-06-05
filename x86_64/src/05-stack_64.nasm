bits 64

section .data
    sample: db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x11, 0x22
section .bss
section .text
    global main
    main:
        mov rax, 0x_1122_3344_5566_7788
        push rax

        push sample

        push qword[sample]

        pop r15
        pop r14
        pop rbx

        mov rax, 60
        mov rdi, 0
        syscall
