;; rbx, r12 ~ r15
section .bss
section .data
section .text
global _start
  _start:

      mov rdi, '0x_'
      call print_char

    mov rdi, 0xffff_ffff_ffff_ffff
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
      mov rdi, rax

    .positive:
    call int2decimalstr

      mov rax, 60
      mov rdi, 0
      syscall

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
    mov rcx, 10

    mov rdi, 20
    sub rsp, 21;; 1.8 x 10^19

    .for:
      mov rax, r8
      xor rdx, rdx
      div rcx
        mov r8, rax
        mov rsi, rdx
          cmp rsi, 0xa
            jge .over_a
        add rsi, '0'
          jmp .next
     .over_a:
          add rsi, 55
    .next:
        mov [rsp + rdi], sil
        dec rdi
          test rax, rax
            jz .print
      jmp .for

    .print:
      mov rax, 1
      mov rdi, 1
      mov rsi, rsp
      mov rdx, 21
      syscall

    mov rsp, rbp
    pop rbp
    ret
      

int2hexastr:
    push rbp
    mov rbp, rsp

    mov r8, rdi
    mov r9, 8

    mov rdi, 15

    sub rsp, 16

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
      mov rdx, 16
      syscall

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
