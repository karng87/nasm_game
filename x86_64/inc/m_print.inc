;; rbx, r12 ~ r15
p_test:
    .prologue:
        push rbp
        mov rbp, rsp

    .body
        push rdi
        mov rdi, '0x_'
          call p_char

        pop rdi
        push rdi
        call p_hexa2str
        call p_newline

        pop rdi
        push rdi
        call is_negative
        pop rdi
          test rax, rax
            jz .positive
        call g_2complement
          push rax
          mov rdi, '-'
          call p_char
          pop rdi

      .positive:
        call p_decimal2str 

    .epilogue:
        mov rsp, rbp
        pop rbp
        ret

exit:
    mov rax, 60
    mov rdi, 0
    syscall

g_trim:
      mov rax, rdi
      xor rcx, rcx
    .for:
      xor rdx, rdx
        div rsi
        inc rcx
          test rax, rax
          jz .end
      jmp .for
    .end:
      mov rax, rcx

    ret

is_negative:
      sar rdi, 63
        cmp dil, 0xff
          je .negative
      xor rax, rax
        jmp .end
    .negative:
        mov rax, 1
    .end:
      ret

g_2complement:
    mov rax, rdi
    not rax
    add rax, 1
    ret

p_decimal2str:
    push rbp
    mov rbp, rsp

    mov r8, rdi
    mov rsi, 10
    call g_trim
    sub rsp, rax ;;max 21
    mov r9, rax
    mov rdi, rax
    dec rdi

    mov rax, r8
    mov rcx, 10
    .for:
      xor rdx, rdx
      div rcx
          cmp rdx, 0xa
            jge .over_a
        add rdx, '0'
          jmp .next
     .over_a:
          add rdx, 55
    .next:
        mov [rsp + rdi], dl
        dec rdi
          test rax, rax
            jz .print
      jmp .for

    .print:
      mov rax, 1
      mov rdi, 1
      mov rsi, rsp
      mov rdx, r9
      syscall

    mov rsp, rbp
    pop rbp
    ret
      

p_hex2str:
    .prologue:
        push rbp
        mov rbp, rsp

        .body:
            mov r8, rdi
            mov rsi, 16
            call g_trim
            sub rsp, rax
            mov r9, rax
            mov rdi, rax
            dec rdi

            .for:
              mov rsi, r8
                  and rsi, 0xf
                    cmp rsi, 0xa
                      jge .over_a
                add rsi, '0'
                jmp .next
            .over_a:
                add rsi, 55
            .next:
                mov [rsp + rdi], sil
                  sar r8, 4

                test rdi, rdi
                  jz .print
                dec rdi
                jmp .for

            .print:
                mov rax, 1
                mov rdi, 1
                mov rsi, rsp
                mov rdx, r9
                syscall

    .epilogue:
        mov rsp, rbp
        pop rbp
        ret

p_str:
    push rbp
    mov rbp, rsp

    mov rdx, rsi
    mov rsi, rdi
    mov rax, 1
    mov rdi, 1
    syscall

    mov rsp, rbp
    pop rbp
    ret


p_num:
    push rbp
    mov rbp, rsp

    cmp rdi, 0xa
      jge .over_a

    add rdi, '0'
      jmp .print
      
    .over_a:
      add rdi, 55

    .print:
      push rdi
      mov rax, 1
      mov rdi, 1
      mov rsi, rsp
      mov rdx, 8
      syscall

    mov rsp, rbp
    pop rbp
    ret

p_char:
    push rbp
    mov rbp, rsp

    push rdi
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 8
    syscall

    mov rsp, rbp
    pop rbp
    ret

p_newline:
    push rbp
    mov rbp, rsp

    push 0xa
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 8
    syscall

    mov rsp, rbp
    pop rbp
    ret
