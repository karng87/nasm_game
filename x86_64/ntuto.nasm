%include "inc/hex2int_stack.inc"
section .data
    p_num: dq sign 
    msg: db "Hello msg!", 0

section .bss
    sign: resb 1
    num: resb 16
section .text
  global main
  main:
            mov rdi, 0x_ffff_aaaa_ffff_ffff
            ;mov rdi, 0x_ffff_ffff
            lea rsi, [p_num]
            call hex2int_stack
            ;mov rbx, [rsi]
            ;mov byte[rbx], "+"

            mov rax, 1
            mov rdi, 1
            mov rsi, [p_num]
            mov rdx, 17
            syscall
            mov rax, 60
            xor rdi, rdi
            syscall

