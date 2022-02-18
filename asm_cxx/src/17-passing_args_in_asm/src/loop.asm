; nasm -felf64 loop.asm
; clang -no-pie loop.o
; gcc -no-pie loop.o
extern printf

section .data
    fmt db "%d", 0x0A, 0

section .bss

section .text
    global main
    main:
      mov rax, 0

      .lp:
        inc rax
        push rax

        mov rdi, fmt
        mov rsi, rax
        mov rax, 0
        call printf
        pop rax
          cmp rax, 100
          jl .lp

        mov rax, 60
        mov rdi, 0
        syscall

      
