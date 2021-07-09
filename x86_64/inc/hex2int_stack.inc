;; argument
;;    rdi, rsi, rdx, rcx, r8, r9, stack
;;    r10:: used for passing a function's static chain pointer
;;    r11:: temporary resister
;; callee saved register
;;    rbx, rbp, rsp, r12 ~ r15

section .data
      cnt: db 0
      position: db 16
      weight: dq 1
section .bss
      tmp: resq 1

section .text

 hex2int_stack:
    .prolog:
      push rbp
      mov rbp, rsp

      push rbx

      push r12
      push r13
      push r14
      push r15

            
           mov r8, rdi ;; arg
           mov rbx, [rsi];; p_num sign, deciaml

       .chekck_sign:
           push r8
           sar r8, 63
           cmp r8b, 0xff
             je .negative
          .positive:

           mov byte[rbx], "+"
           jmp .for_i
          .negative:
           mov byte[rbx], "-"
           pop r8
           not r8
           add r8, 1
           push r8

       .for_i:

          pop r8
          mov r10, 1 ;; div
          mov r11, 1
          mov r13, 1

          xor rdi, rdi
       .iterator:
          test r13, r13
          jz .return
          
          mov r11, r10
          mov rax, r11

          mov rcx, 10
          xor rdx, rdx
              mul rcx
          mov r10, rax

          mov rax, r8
          xor rdx, rdx
              div r10
                test rax, rax
                  jnz .con
                mov r13, 0

       .con:
          mov rax, rdx
          xor rdx, rdx
              div r11
          mov rsi, rax
            cmp sil, "9"
              jg .over_a
          add rsi, '0'
          jmp .mcopy
        .over_a:
          add rsi, 'A'
        .mcopy:
          inc rdi
          mov [rbx+rdi], sil
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

