bits 64
section .data
    var1 dq 1
    var2 dq 0x11223344_55667788
    var3 dq 0xffffffff_ffffffff
    var4 dq 0

section .bss
section .text
    global main
        main:
            
            ;; register based additon
            mov rax, 0x01
            add rax, 0x01

            mov rax, 0xffffffff_ffffffff
            add rax, 0x01

            mov rax, 0x09
            sub rax, 0x04

            ;; memory based addition
            mov rax, qword[var1]
            add qword[var4], rax

            add qword[var4], 0x02

            ;; clear /set /complement carry flag
            clc   ;; clear carry flag:        CF=0
            stc   ;; set carry flag:          CF=1
            cmc   ;; complements carry flag:  CF=NOT(CF)

            ;; add with carry
            mov rax, 0
            stc
            adc rax, 0x1
            stc
            adc rax, 0x2    ;; Dest = Dest + Source + Carry Flag

            ;; subtract with borrow
            mov rax, 0x10
            sub rax, 0x5
            stc
            sbb rax, 0x4    ;; Dest = Dest - Source - Carry Flag

            inc rax
            dec rax

            mov rax, 60
            mov rdi, 0
            syscall
