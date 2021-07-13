;; rbx, r12 ~ r15
section .text
global main
main:
    mov rdi, 1
    mov rsi, "fd.txt"
    mov rdx, 0x7fff_ffff_ffff_ffff

    call io_d2s

exit:
    mov rax, 60
    mov rdi, 0
    syscall
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

io_char:
    .prologue:
      push rbp
      mov rbp, rsp

    .body:
      push rsi
      mov rax, 1
      ;mov rdi, rdi
      mov rsi, rsp
      mov rdx, 8
      syscall

    .epilogue:
      mov rsp, rbp
      pop rbp
      ret

g_fd:
    .prologue:
      push rbp
      mov rbp, rsp

    .body:
        push rdi  ;; fine name
        mov rax, 2
        mov rdi, rsp
        mov rsi, 0b_010_001_000_010
        mov rdx, 0b_110_000_000
        syscall
        pop rdi
          cmp rax, 0
            jg .end
        .err:
          mov rdi, 1
          mov rsi, "E:g_fd"
          call io_char
          call exit
    .end:
      mov rsp, rbp
      pop rbp
      ret 

;;; io_d2s ( rdi, rsi, rdx )
;;          rdi:: fd num
;;          rsi:: file name
;;          rdx:: to write a number
io_d2s:
    .prologue:
        push rbp
        mov rbp, rsp

    .body:
        mov r8, rdi   ;; fd
        ;mov r9, rsi  ;; file name
        mov r10, rdx   ;; data

        cmp rdi, 1
          je .stdout
        cmp rdi, 2
          jge .io_file
              mov rdi, 1
              mov rsi, "E:io_d2s"
              call io_char
              call exit
      .io_file:
        test rsi, rsi
          jnz .filename
              mov rdi, 1
              mov rsi, "E:fname"
              call io_char
              call exit
      .filename:
        mov rdi, rsi
        call g_fd
        mov r8, rax
        
      .stdout:
        mov rdi, r10
        call is_negative
          cmp rax, 1
            jne .not_negative
        mov rdi, r10
        call g_2complement
        mov r10, rax
          mov rdi, r8
          mov rsi, '-'
            call io_char

      .not_negative:
          mov rdi, r10
          mov rsi, 10
            call g_trim
              sub rsp, rax ;;max 21
              mov r11, rax
              mov rdi, rax
              dec rdi
      .init:
          mov rax, r10
          mov rcx, 10
      .for:
          xor rdx, rdx
          div rcx
            cmp rdx, 0xa
              jge .over_a
          add rdx, '0'
          jmp .next
      .over_a:
          add rdx, 87
      .next:
          mov [rsp + rdi], dl
          dec rdi
            test rax, rax
              jz .print
          jmp .for

      .print:
          mov rax, 1
          mov rdi, r8
          mov rsi, rsp
          mov rdx, r11
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
