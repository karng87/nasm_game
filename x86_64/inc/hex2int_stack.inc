;; argument
;;    rdi, rsi, rdx, rcx, r8, r9, stack
;;    r10:: used for passing a function's static chain pointer
;;    r11:: temporary resister
;; callee saved register
;;    rbx, rbp, rsp, r12 ~ r15
;; python:
          ;; hex(), int(), bin()

section .data
      cnt: db 0
      position: db 16
      weight: dq 1
section .bss
      int_num: resb 20
      tmp: resq 1

section .text
  global main
  main:
    mov rsi, 0x_8fff_ffff_ffff_ffff
    call hex2int_stack
    mov rax, 60
    syscall

 hex2int_stack:
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
          push rax

       .for_i:
       ;; 0x_0123_4567_89ab_cdef

          pop r8
          mov r9, 1
          mov r10, 1000000000000000000 ;; e18

       .iterator:
          
          mov rax, r8
          xor rdx, rdx
              div r10
          xor rdx, rdx
            div r9
              cmp rax, 0
                je .skip
          mov rsi, rax
          add rsi, '0'
            call print_hex

        .skip:
          mov rax, r10
          xor rbx, rbx
          mov cl, 10
            div cl
          mov r10, rax
          mov rax, r9
          xor rbx, rbx
          mov cl, 10
          mul cl
          mov r9, rax
            test r10, r10
              jz .return
          jmp .iterator

        .return:
          mov rax, 17

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
      cmp r8b, 0xff
      je .negative
   .positive:
      mov rdi, "+"
      jmp .print
   .negative:
      mov rdi, "-"
      pop rax
      not rax
      inc rax
      push rax
   .print:
      push rdi
      mov rax, 1
      mov rdi, 1
      mov rsi, rsp
      mov rdx, 1
      pop rdi
      pop rax
    .end 
      ret

      
print_hex:
        cmp dil, 0xa
          jge .over_a
        add dil, '0'
        jmp .print
    .over_a:
        add dil, 55
    .print:
        push dil
        mov rax,1
        mov rdi,1
        mov rsi, rsp
        mov rdx, 1
        syscall
        pop rax
    ret


print_char:
      push rdi
      mov rax, 1
      mov rdi, 1
      mov rsi, rsp
      mov rdx, 1
      syscall
      pop rax
      ret

print_newline:
      mov rdi, 0xa
      call print_char
      ret
    

