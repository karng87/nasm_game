;; argument
;;    rdi, rsi, rdx, rcx, r8, r9, stack
;;    r10:: used for passing a function's static chain pointer
;;    r11:: temporary resister
;; callee saved register
;;    rbx, rbp, rsp, r12 ~ r15

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
           xor r9, r9

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

          mov rdi, 18
       .iterator:
          
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
          mov r9b, sil

            test r13, r13
              jz .return
          sal r9, 8
          jmp .iterator
        .return:
          mov qword[rbx+1], r9

      .epilog:
      pop r15
      pop r14
      pop r13
      pop r12

      pop rbx

      mov rsp, rbp
      pop rbp
      ret

