;; rbx, r12 ~ r15
section .bss
section .data
section .text
global main
  main:

      mov rdi, '0x_'
      call print_char

    mov rdi, 0xffff
    push rdi
    call int2hexastr
    call print_newline

    pop rdi
    push rdi
    call is_negative
    pop rdi
      test rax, rax
        jz .positive
    call get_2complement
      push rax
      mov rdi, '-'
      call print_char
      pop rdi

    .positive:
    call int2decimalstr

      mov rax, 60
      mov rdi, 0
      syscall

trim:
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

get_2complement:
    mov rax, rdi
    not rax
    add rax, 1
    ret

int2decimalstr:
    push rbp
    mov rbp, rsp

    mov r8, rdi
    mov rsi, 10
    call trim
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
      

int2hexastr:
    .prologue:
        push rbp
        mov rbp, rsp

        .body:
            mov r8, rdi
            mov rsi, 16
            call trim
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

print_str:
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


print_num:
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

print_char:
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

print_newline:
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
