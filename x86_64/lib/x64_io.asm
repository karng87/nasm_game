;; nasm -felf64
;; gcc -shared -o libmyasmprint.so x64_io.o

;; rbx, r12 ~ r15
global p_newline
global p_mem
global p_char
global p_negative
global p_decimal
global p_hexadecimal

global fp_newline
global fp_char
global fp_men
global fp_negative
global fp_deciaml
global fp_hexadecimal

global get_nullIndex
global get_trimIndex
global get_fd

global is_negative

test:
    mov rdi, "fd.txt"
    call get_fd
    mov rdi, rax
    mov rdx, 0x7fff_ffff_ffff_ffff
    call fp_hexadecimal

    mov rdi, 0x7fff_ffff_ffff_ffff
    call p_decimal
    ret

exit:
    mov rax, 60
    mov rdi, 0
    syscall

get_nullIndex:
        xor rax, rax
        .for:
              cmp byte[rdi], 0x00
                je .out
            inc rax
            inc rdi
            jmp .for
        .out:  
            push rax
            mov rdi, rax
            call p_hexadecimal
            mov rdi, ":"
            call p_char 
            pop rax
        ret

get_trimIndex:
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
    
p_newline:
    push 0xa
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 8
    syscall
    pop rax
    ret

fp_newline:
    push 0xa
    mov rax, 1
    ;mov rdi, rdi
    mov rsi, rsp
    mov rdx, 8
    syscall
    pop rax
    ret

p_mem:
    push rbx
      mov rbx, rdi
      call get_nullIndex
          mov rdx, rax
          mov rax, 1
          mov rdi, 1
          mov rsi, rbx
          syscall
    pop rbx
    ret

fp_mem:
    push rbx
      mov rbx, rdi
      call get_nullIndex
          mov rdx, rax
          mov rax, 1
          mov rdi, rsi
          mov rsi, rbx
          syscall
    pop rbx
    ret


p_char:
    push rdi
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 8
    syscall
    pop rax
    .end:
      ret

fp_char:
    push rsi
    ;mov rdi, rdi
    mov rax, 1
    mov rsi, rsp 
    mov rdx, 8
    syscall

    pop rax
    ret

get_fd:
    push rdi
    mov rax, 2
    mov rdi, rsp
    mov rsi, 0b_010_001_000_010
    mov rdi, 0b_110_000_000
    syscall

    pop rdi
    ret


check_fd:
      cmp rdi, 1
        je .stdout
      cmp rdi, 2
        je .io_file
           mov rsi, "E:io_d2s"
           call p_char
           call exit
      .io_file:
        test rsi, rsi
          jnz .filename
              mov rsi, "E:fname"
              call p_char
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

        mov rsi, "E:g_fd"
        call p_char
        call exit
      .stdout:
        mov rax, 1
      .end:
        ret


get_2complement:
    mov rax, rdi
    not rax
    add rax, 1
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
p_negative:
        push r8
        push r10

        mov r8, rdi
        mov r10, rsi

        mov rdi, r10
        call is_negative
          cmp rax, 1
            jne .end
        mov rdi, r10
        call get_2complement
        mov r10, rax

          cmp r8, 1
            je .p_c
        mov rdi, r8
        mov rsi, '-'
        call fp_char
          jmp .end

        .p_c:
        mov rdi, '-'
        call p_char

      .end:
          mov rax, r10
          pop r10
          pop r8
          ret

;;; io_d2s ( rdi, rsi, rdx )
;;          rdi:: fd num
;;          rsi:: file name
;;          rdx:: to write a number
p_decimal:
    .prologue:
        push rbp
        mov rbp, rsp

    .body:
        mov r10, rdi

        mov rdi, 1
        mov rsi, r10
        call p_negative
        mov r10, rax

    .get_count:
        mov rdi, r10
        mov rsi, 10
          call get_trimIndex
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
          mov rdi, 1
          mov rsi, rsp
          mov rdx, r11
          syscall
          mov rax, [rsp]

    .epilogue:
        mov rsp, rbp
        pop rbp
        ret

fp_decimal:
    .prologue:
        push rbp
        mov rbp, rsp

    .body:
        mov r8, rdi   ;; fd
        mov r10, rsi   ;; data

        mov rdi, r8
        mov rsi, r10
        call p_negative
        mov r10, rax

    .get_count:
        mov rdi, r10
        mov rsi, 10
          call get_trimIndex
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
          mov rax, [rsp]

    .epilogue:
        mov rsp, rbp
        pop rbp
        ret

p_hexadecimal:
    .prologue:
        push rbp
        mov rbp, rsp

    .body:
        mov r10, rdi   ;; data

          mov rdi, '0x'
          call p_char

    .get_count:
        mov rdi, r10
        mov rsi, 16
          call get_trimIndex
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
         mov rdi, 1
         mov rsi, rsp
         mov rdx, r11
         syscall
         mov rax, [rsp]

    .epilogue:
        mov rsp, rbp
        pop rbp
        ret

fp_hexadecimal:
    .prologue:
        push rbp
        mov rbp, rsp

    .body:
        mov r8, rdi   ;; fd
        mov r10, rsi   ;; data

          mov rdi, r8
          mov rsi, '0x'
          call fp_char
    .get_count:
        mov rdi, r10
        mov rsi, 16
          call get_trimIndex
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
         mov rax, [rsp]

    .epilogue:
        mov rsp, rbp
        pop rbp
        ret


