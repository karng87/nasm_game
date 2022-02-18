; nasm -felf64 main.nasm
; gcc main.o message.c or, gcc -c message.c ; gcc -oa.out main.o message.o

extern message

section .data

section .bss

section .text
    global main
    main:
        mov rcx, 5
        .lp:
          push rcx
          call message
          pop rcx
          loop .lp

        mov rax, 60
        mov rdi, 0
        syscall
    
