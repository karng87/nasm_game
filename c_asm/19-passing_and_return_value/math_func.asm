section .data
section .bss
section .text
    global add
    add:
        add rdi, rsi
        mov rax, rdi
        ret

    global sub
    sub:
        sub rdi, rsi
        mov rax, rdi
        ret

    global mul
    mul:
        mov rax, rdi
        mul rsi
        ret

    global div_i
    div_i:
        cvtsi2ss xmm0, rdi
        cvtsi2ss xmm1, rsi
        divss xmm0, xmm1
        ret

    global div_f
    div_f:
        divss xmm0, xmm1
        ret


