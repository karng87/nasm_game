section .data
    msg: db "Hello World!", 0xA
    mlen equ $-msg

section .bss
section .text
    global main
    main:
          jmp Begin
          
          mov rax, 0x10
          xor rbx, rbx
          
        Begin:
          mov rax, 5

        PrintHW:
          push rax

          mov rax, 1
          mov rdi, 1
          mov rsi, msg
          mov rdx, mlen
          syscall

          pop rax
          dec rax
            jnz PrintHW ;; loop PrintHw : dec rcx => cmp rcx, 0 => jg

          mov rax, 60
          mov rdi, 0
          syscall
