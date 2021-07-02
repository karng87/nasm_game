section .data
    codes: db "hello\n"
    len: equ $-codes

section .bss

section .text
    global main
    main:
        mov rax, 1
        mov rdi, 1
        mov rsi, codes
        mov rdx, len
        syscall

        mov rax, 60
        mov rdi, 0
        syscall

