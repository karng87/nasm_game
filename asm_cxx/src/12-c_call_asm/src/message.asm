section .data
    str: db "Oh, no! This line repeates!", 0x_0A
    str_length equ $-str

    SYS_write equ  1;
    STDOUT    equ 1;

section .bss

section .text
    global message

    message:
        mov rax, SYS_write
        mov rdi, STDOUT
        mov rsi, str
        mov rdx, str_length
        syscall
        ret

