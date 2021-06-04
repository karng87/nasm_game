section .data
    ivalue dq 0xAA
    fvalue dd 3.14159

section .bss

section .text
    global func_i
    func_i:
        mov rax, [ivalue]
        ret

    global func_f
    func_f:
        movss xmm0, dword[fvalue]
        ret
