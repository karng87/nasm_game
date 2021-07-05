print_hex:
            push rbp
            mov rbp, rsp
            mov rcx, 64

        .iterator:
            push rdi
            sub rcx, 4
            push rcx

            sar rdi,cl        ;; only cl
            and rdi, 0x0f
            cmp rdi, 0x_0A
              jge .print_a

        .print_i:
            add rdi, '0'
            jmp .print

        .print_a:
            mov al, 'A' 
            sub al, 0x0a
            add dil, al

        .print:
            call print_char
            pop rcx
            pop rdi
              test rcx, rcx
                jnz .iterator

            mov rdi, 0xA
            call print_char 

       .epilogue:
            mov rsp, rbp
            pop rbp

            ret

print_char:
        push rbp
        mov rbp, rsp

        push rdi

        mov rax, 1
        mov rdi, 1

        lea rsi, [rsp]
        mov rdx, 8
        syscall
        pop rdi

    epilog:
        mov rsp, rbp
        pop rbp
        ret
        
