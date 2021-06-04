section .data
    str: db "Hello, world!", 0x0A, 0
    str_length equ $-str

    STDIN  equ 0
    STDOUT equ 1
    STDERR equ 2

    SYS_read  equ 0
    SYS_write equ 1
    SYS_exit  equ 60

    EXIT_OK equ 0

section .bss
    
section .text
    global _start

    _start:
        mov rax, SYS_write 
        mov rdi, STDOUT
        mov rsi, str
        mov rdx, str_length
        syscall

        mov rax, SYS_exit
        syscall


