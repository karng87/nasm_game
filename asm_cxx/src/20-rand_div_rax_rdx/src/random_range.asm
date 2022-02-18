extern rand
section .data
section .bss
    span resq 1
    l_limit resq 1

section .text
    global random_range
    random_range:
        mov [l_limit], rdi
        sub rsi, rdi
        mov [span], rsi

        call rand

        div qword[span]
        mov rax, rdx
        add rax, [l_limit]

        ret
        

