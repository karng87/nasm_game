%include "inc/hex2int_stack.inc"
section .data
  msg: db "hello world",0xa, 0
section .bss
  arg: resq 1
  argc: resq 1
  argv: resq 1

section .text
  global main
  main:
        mov [argc], rdi
        mov [argv], rsi
        call hex2int_stack

      .while:
        mov rax, [argv]
        mov rsi, [rax]
        mov [arg], rsi
          inc qword[argv]
          dec qword[argc]
            mov rbx, 0

      .iterator:
        mov cl, [rsi]
          test cl, cl
            jz .print
        inc rbx
        inc rsi
          jmp .iterator

      .print:

        mov rax, 1
        mov rdi, 1
        mov rsi, [arg]
        mov rdx, rbx
        syscall
        
        ;call print_newline

          cmp qword[argc], 0
          je .end
        jmp .while

      .end:
         mov rax, 60
         xor rdi, rdi
         syscall
