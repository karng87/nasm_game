;; rbx, r12 ~ r15
section .text
global main
main:
    mov rdi, 0xffff_ffff_ffff_ffff
    mov rsi, 2
    mov rdx, "fd.txt"

    call io_d2s

exit:
    mov rax, 60
    mov rdi, 0
    syscall
    ret

g_fd:
    push rdi
    mov rax, 2
    mov rdi, rsp
    mov rsi, 0b_010_001_000_010
    mov rdx, 0b_110_000_000
    syscall
      cmp rax, 0
        jl .err
    jmp .end
    .err:
      mov rdi, "E:g_fd"
      mov rsi, 1
      call io_char
      call exit
    .end:
    ret

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

io_d2s:
    .prologue:
        push rbp
        mov rbp, rsp

    .body:
        mov r8, rdi   ;; data
        mov r9, rsi   ;; fd
        ;mov r11, rdx

        cmp rsi, 1
          je .ns1
        cmp rsi, 2
          jge .fileio
        mov rdi, "E:io_d2s"
        mov rsi, 1
        call io_char
        call exit
          ;jmp .epilogue

      .fileio:
        test rdi, rdi
          jnz .g_fd
        mov rdi, "E:fname"
        mov rsi, 1
        call io_char
        call exit
          ;jmp .epologue

      .g_fd:
        mov rdi, rdx
        call g_fd
        mov r9, rax
        
      .ns1:
        mov rdi, r8
        call is_negative
          cmp rax, 1
            jne .ns2
        mov rdi, r8
        call g_2complement
        mov r8, rax
          mov rdi, '-'
          mov rsi, r9
            call io_char

      .ns2:
          mov rdi, 10
          call g_trim
          sub rsp, rax ;;max 21
          mov r10, rax
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
            mov rdi, r9
            mov rsi, rsp
            mov rdx, r10
            syscall

    .epilogue:
        mov rsp, rbp
        pop rbp
        ret

p_x2s:
    .prologue:
        push rbp
        mov rbp, rsp

        .body:
            mov r8, rdi

            mov rdi, '0x_'
            mov rsi, 1
            call io_char

            mov rdi, r8
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
                add rsi, 87
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

p_ptr:
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

io_char:
    push rbp
    mov rbp, rsp

      push rdi
      mov rax, 1
      mov rdi, rsi
      mov rsi, rsp
      mov rdx, 8
      syscall
      pop rax

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
