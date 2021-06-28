section .data

section .bss
        buffer: resb 10
    

section .text
        global main
        main:
            mov rax, 0
            mov rdi, 0
            mov rsi, buffer
            mov rdx, 10
            syscall

            mov rax, 60
            mov rdi, 0
            syscall
