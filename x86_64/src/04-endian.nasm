section .data
    msg: db "Hello, Nasm!", 0x0A
    msg_len: equ $-msg
    var1: db 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88
    var2: db 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11

section .bss
section .text
    global main
    main:
        ;; write (stdout, *buff, count)
        mov rax, 1
        mov rdi, 1
        mov rsi, msg
        mov rdx, msg_len
        syscall

        mov rax, [var1]
        mov rbx, [var2]

        ;; exit(0)
        mov rax, 60
        mov rdi, 0
        syscall
