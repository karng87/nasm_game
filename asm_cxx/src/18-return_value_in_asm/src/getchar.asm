extern getchar

section .data
    prompt db "Press a key: "
    prompt_len equ $-prompt
    newline db 0x0A

    stdout equ 1
    sys_write equ 1
    
section .bss
    key resb 1

section .text
    global main
    main:
        mov rax, sys_write
        mov rdi, stdout
        mov rsi, prompt
        mov rdx, prompt_len
        syscall

        push rbp
        mov rbp, rsp

        call getchar

        pop rbp
        mov [key], rax

        mov rcx, 10
        .lp:
          push rcx

          mov rax, sys_write
          mov rdi, stdout
          mov rsi, key
          mov rdx, 1
          syscall
          pop rcx
            loop .lp

          mov rax, sys_write
          mov rdi, stdout
          mov rsi, newline
          mov rdx, 1
          syscall

          mov rax, 60
          mov rdi, 0
          syscall






