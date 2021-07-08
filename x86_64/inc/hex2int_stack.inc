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

            
           push rdi ;; arg
           push rsi ;; p_num sign, deciaml

           mov rbx, [rsp]
           mov rbx, [rbx]
       .chekck_sign:
           sar rdi, 63
           cmp dil, 0xff
             je .negative
          .positive:

           mov byte[rbx], "+"
           jmp .check_num
          .negative:
           mov byte[rbx], "-"

       .mod_num:
          
          
          

    .epilog:
      pop r15
      pop r14
      pop r13
      pop r12

      pop rbx

      mov rsp, rbp
      pop rbp
      ret
