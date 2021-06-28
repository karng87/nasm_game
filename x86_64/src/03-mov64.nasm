section .data
    sample: db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x11, 0x22
    sample2: dq 0x_1122_3344_5566_7788
    sample3: times 8 db 0x00

section .bss ;; block starting symbol
section .text
    global main
    main:
        ;; mov immediate data to register
        mov rax, 0x_aaaa_aaaa_bbbb_bbbb
        mov eax, 0x_aaaa_aaaa

        mov rax, 0x_aaaa_aaaa_bbbb_bbbb
        mov al, 0x_11

        mov rax, 0x_aaaa_aaaa_bbbb_bbbb
        mov ah, 0x_cc

        mov rax, 0x_aaaa_aaaa_bbbb_bbbb
        mov ax, 0x_dddd

        ;; mov from register to register
        mov rbp, rax
        mov r10, rbp

        mov r11d, r10d
        mov r12w, r11w
        mov r13b, r12b

        ;; mov from memory into register
        mov rsi, [sample2]
        mov r14d, [sample]
        mov r15w, [sample]
        mov dil, [sample]  ;; dil = 8bit rdi

        ;; mov from register into memory
        mov rax, [sample2]
        mov byte[sample], al
        mov word[sample], ax
        mov dword[sample], eax
        mov qword[sample], rax

        ;; lea demo
        lea rax, [sample]
        lea rbx, [rax]

        ;; xchg demo
        mov rax, 0x_1234_5678_90ab_cdef
        mov rbx, 0x_9999_9999_9999_9999
        xchg rax, rbx

        mov rax, 60
        mov rdi, 0
        syscall





