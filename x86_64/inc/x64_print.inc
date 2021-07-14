;; rbx, r12 ~ r15
test:
    mov rdi, 2
    mov rsi, "fd.txt"
    mov rdx, 0x7fff_ffff_ffff_ffff
    call io_d2s

    mov rdi, 2
    mov rsi, "fd.txt"
    mov rdx, 0x7fff_ffff_ffff_ffff

    call io_x2s

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

check_fd:
      cmp rdi, 1
        je .stdout
      cmp rdi, 2
        je .io_file
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
        push rsi  ;; fine name
        mov rax, 2
        mov rdi, rsp
        mov rsi, 0b_010_001_000_010
        mov rdx, 0b_110_000_000
        syscall
        pop rdi
          cmp rax, 0
            jg .end

        mov rdi, 1
        mov rsi, "E:g_fd"
        call io_char
        call exit
      .stdout:
        mov rax, 1
      .end:
        ret

check_negative:
        push r8
        push r10

        mov r8, rdi
        mov r10, rsi

        mov rdi, r10
        call is_negative
          cmp rax, 1
            jne .end
        mov rdi, r10
        call g_2complement
        mov r10, rax

        mov rdi, r8
        mov rsi, '-'
          call io_char
      .end:
          mov rax, r10
          pop r10
          pop r8
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

        call check_fd
        mov r8, rax

        mov rdi, r8
        mov rsi, r10
        call check_negative
        mov r10, rax

    .get_count:
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

io_x2s:
    .prologue:
        push rbp
        mov rbp, rsp

    .body:
        mov r8, rdi   ;; fd
        ;mov r9, rsi  ;; file name
        mov r10, rdx   ;; data

        call check_fd
        mov r8, rax

        mov rdi, r8
        mov rsi, '0x_'
        call io_char

    .get_count:
        mov rdi, r10
        mov rsi, 16
          call g_trim
            sub rsp, rax ;;max 21
            mov r11, rax
            mov rdi, rax
            dec rdi

     .for:
       mov rsi, r10
           and rsi, 0xf
             cmp rsi, 0xa
               jge .over_a
         add rsi, '0'
         jmp .next
     .over_a:
         add rsi, 87
     .next:
         mov [rsp + rdi], sil
           sar r10, 4
              test rdi, rdi
                jz .print
         dec rdi
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

io_ptr:
    mov rax, 1
    ;mov rdi, rdi
    ;mov rsi, rsi
    ;mov rdx, rdx
    syscall
    ret

io_num:
    cmp rsi, 0xa
      jge .over_a

    add rsi, '0'
      jmp .print
      
    .over_a:
      add rsi, 87

    .print:
      push rsi
      mov rax, 1
      ;mov rdi, rdi
      mov rsi, rsp
      mov rdx, 8
      syscall
      pop rax
    ret

io_newline:
    push 0xa
    mov rax, 1
    ;mov rdi, rdi
    mov rsi, rsp
    mov rdx, 8
    syscall
  
    pop rax
    ret
