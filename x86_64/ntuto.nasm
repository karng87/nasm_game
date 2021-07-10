%include "inc/print.inc"
section .data
  msg: db "hello world",0xa, 0
section .bss
  ptr_1: resb 1


section .text
  global main
  main:
    push rbp
    mov rbp, rsp
        
        call print_decimal

        push rsi
        mov rcx, rsi
        mov rsi, [rcx]
        mov [ptr_1], rsi
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
        mov rsi, [ptr_1]
        mov rdx, rbx
        syscall

        mov rdi, 0xa
        call print_char

        mov rax, msg
        mov [ptr_1], rax
        mov rbx, 0

      .iterator1:
        mov cl, [rax]
          test cl, cl
            jz .print1
        inc rbx
        inc rax
          jmp .iterator1

      .print1:

        mov rax, 1
        mov rdi, 1
        mov rsi, [ptr_1]
        mov rdx, rbx
        syscall

        jmp .exit

      .exit:
    pop rsi
    mov rsp, rbp
    pop rbp
    ret
            mov rax, 60
            xor rdi, rdi
            syscall
