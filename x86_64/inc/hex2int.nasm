;; argument
;;    rdi, rsi, rdx, rcx, r8, r9, stack
;;    r10:: used for passing a function's static chain pointer
;;    r11:: temporary resister
;; callee saved register
;;    rbx, rbp, rsp, r12 ~ r15
;; python:
          ;; hex(), int(), bin()

section .bss
      sign: resb 1
      num: resb 19

section .text
  global main
  main:
    mov rdi, 0x_8fff_ffff_ffff_ffff
    call to_decimal_str

    mov rax, 60
    mov rdi, 0
    syscall

 to_decimal_str:
    .prolog:
      push rbp
      mov rbp, rsp

      push rbx

      push r12
      push r13
      push r14
      push r15

       .check_sign:
          call print_sign

       .for_i:
       ;; 0x_0123_4567_89ab_cdef
          xor rcx, rcx
          mov rbx, 18
          mov r8, 1

       .iterator:
          xor rdx, rdx
          mov rcx, 10
              div rcx
          mov byte[num+rbx], dl
          test r8, r8
            jz .print

          dec rbx
            test rbx, rbx
              jnz .one_more
                mov r8,0
          .one_more:

          jmp .iterator

        .print:
          mov rdi, num
          mov rsi, 19
          call print_buf

      .epilog:
      pop r15
      pop r14
      pop r13
      pop r12

      pop rbx

      mov rsp, rbp
      pop rbp
      ret

print_sign:
      push rdi
      sar rdi, 63
      cmp rdi, -1
      je .negative
   .positive:
      mov rdi, "+"
      mov [sign], dil
      jmp .print
   .negative:
      mov rdi, "-"
      mov [sign], dil
      pop rax
      not rax
      inc rax
      push rax
   .print:
      call print_char
      call print_newline
      pop rdi
      call print_rdi
    .end: 
      ret
      
print_rdi:
    call int2str
    push rax
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 8
    syscall
    pop rax
    ret

print_buf:
    mov rax, 1
    mov rdx, rsi
    mov rsi, rdi
    mov rdi, 1
    syscall
    ret


int2str:
  push rdi

  .for:
    pop rdi
    test rdi, rdi
      jz .end
    push rdi
    and rdi, 0xf
    cmp rdi, 0xa
      jge .over_a
    add rdi, '0'
    jmp .next
  .over_a:
    add rdi, 55
  .next:
    mov sil, dil
    shl sil, 4
    pop rdi
    shr rdi, 4
    push rdi
    jmp .for
  .end:
    mov rax, rsi
    ret

print_char:
    push rdi
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    pop rdi
    ret

print_newline:
      push rdi
      mov rdi, 0xa
      call print_rdi
      pop rdi
      ret
