;; rbx, r12 ~ r15
%include "x64_print.inc"
section .text
global main
main:

    mov rbx, [rsp+8]
    xor rcx, rcx

    mov rdx, [rsp]

    .for:
    cmp byte[rbx+rcx], 0x00
        jz .out
    inc rcx
    jmp .for

    .out:
    push rcx
    mov rdi, 1
    mov rdx, rcx
    call io_x2s

    mov rax, 1
    mov rdi, 1
    mov rsi, rbx
    pop rdx
    syscall

    call exit
