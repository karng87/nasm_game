;section .data
.section .rodata
    str: .byte "Hello, world!", 0x0A, 0
    str_length equ $-str

    STDIN  equ 0
    STDOUT equ 1
    STDERR equ 2

    SYSCALL_READ  equ 0
    SYSCALL_WRITE equ 1
    SYSCALL_EXIT  equ 60

    EXIT_OK equ 0

section .bss
section .text
    global main

    main:
        mov rax, SYSCALL_WRITE 
        mov rdi, STDOUT
        mov rsi, str
        mov rdx, str_length
        syscall

        mov rax, SYSCALL_EXIT
        syscall


