section .data
    var1: dq 0x_1111_1111_1111_1111
    var2: dq 0

section .bss
section .text
    global main
    main:
        ;; NOT
        mov rax, qword[var2]
        not rax

        mov rbx, qword[var1]
        not rbx

        mov rax, qword[var2]
        mov rbx, qword[var1]
        and rbx, rax

        mov rbx, qword[var1]
        and rbx, qword[var1]

        mov rax, qword[var2]
        mov rbx, qword[var1]
        or rbx, rax

        mov rbx, qword[var1]
        or rbx, qword[var1]

        mov rax, 0x_0101_0101_0101_0101
        mov rbx, 0x_1010_1010_1010_1010
        xor rax, rbx

        xor rax, rax
        xor qword[var1], rax

        mov rax, 60
        mov rdi, 0
        syscall
