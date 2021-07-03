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
            mov rsi, 0b_010_000_000_010 ;; O_CREAT:100o O_TRUNC:1000o
            mov rdx, 0b_110_000_000
            syscall

            mov rdi, 0x_ffff_aaaa_bbbb_5678
            mov rcx, 64
        iterator:
            push rdi
            sub rcx, 4
            push rcx
            sar rdi, cl
            and rdi, 0x0f
            cmp rdi, 0x_0A
              ja print_a

        print_i:
            add dil, '0'
            jmp print

        print_a:
            mov al, 'A' 
            sub al, 0x0a
            add dil, al

        print:
            sub rsp, 1
            mov byte[rsp], dil
            mov rax, 1
            mov rdi, 1
            mov rsi, rsp 
            mov rdx, 1
            syscall
            pop rcx 
            pop rdi
              test rcx, rcx
              jnz iterator
            


        end:
            mov rax, 60
            xor rdi, rdi
            syscall

