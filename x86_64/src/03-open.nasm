;; /usr/include/asm-generic/fcntl.h
section .data
      fname: db "tmp.txt", 0
      msg: dq 0x48, 0x45, 0x4c, 0x4c,0xA
      msg_len: equ $-msg

section .bss
      sign: resb 1
      fd: resq 1

section .text
  global main
      main:
            mov rax, 2
            mov rdi, fname
            mov rsi, 0b_010_001_000_010 ;; O_CREAT:100o O_TRUNC:1000o
            mov rdx, 0b_110_000_000
            syscall

      numchar:
            push rax

            add rax, 0x30
              cmp rax, 0x30
                jg positive
            pop r8
            mov rax, 0x30
            sub rax, r8

            sub rsp, 1
            mov byte[rsp], "-"
            sub rsp, 8
            mov qword[rsp], rax
            jmp end

       positive:
            sub rsp, 1
            mov byte[rsp], "+"
            sub rsp, 8
            mov qword[rsp], rax
       end:

            mov rax, 1
            ;pop rsi
            mov rdi, 1

            lea rsi, [rsp+8]
            mov rdx, 1
            syscall

            mov rax, 1
            mov rdi, 1
            lea rsi, [rsp]
            mov rdx, 1
            syscall


            mov rax, 60
            xor rdi, rdi
            syscall
