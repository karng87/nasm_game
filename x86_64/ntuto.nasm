%include "inc/hex2int-0.0.3.inc"

section .data
    ptr_num: dq num
    msg: db "Hello ", 0xa

section .bss
    num: resb 17

section .text
  global main
  main:
            mov rdi, 123456789
            call hex2int3

            mov rax, 1
            mov rdi, 1
            mov rsi, decimal
            mov rdx, 17
            syscall

            mov rax, 60
            xor rdi, rdi
            syscall

