;; argument
;;    rdi, rsi, rdx, rcx, r8, r9, stack
;;    r10:: used for passing a function's static chain pointer
;;    r11:: temporary resister
;; callee saved register
;;    rbx, rbp, rsp, r12 ~ r15
print_decimal:
        .prolog:
            push rbp
            mov rbp, rsp

        .body:
            xor r10, r10
            mov rcx, 64
            push rdi
            sar rdi, 63
              cmp rdi, 1
                jz .negative
          .positive:
            mov rdi, "+"
            push rcx
            call print_char
            pop rcx
          .lp_p:
            pop rdi
            push rdi
            sub rcx, 4
            sar rdi, cl
            and rdi, 0xf
              cmp dil, 9
                jg .over9
            add dil, "0"
            ;; 0x_1234_5678_90ab_cdef
            add rdi, r10
            xor r10, r10
            push rcx
            call print_char
            pop rcx
            jmp .testshift

          .over9:
            sub dil, 0xa
            add rdi, r10
            xor r10, r10
            mov r10, 1
            push rcx
              call print_char
            pop rcx
          .testshift:
              test rcx, rcx
                jne .lp_p
            jmp .epilog

          .negative:
              mov r11, "-"
            
        .epilog:
            mov rsp, rbp
            pop rbp
            ret

print_hex:
        .prolog:
            push rbp
            mov rbp, rsp

        .bdoy:
            push rdi

            mov rdi, "0x"
            call print_char

            pop rdi
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
      .prolog:
          push rbp
          mov rbp, rsp
      .body:
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
        
