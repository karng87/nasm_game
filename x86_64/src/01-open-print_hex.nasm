;; /usr/include/asm-generic/fcntl.h

%include "inc/x64_print.inc"

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
            mov rsi, 0b_010_000_000_010 ;;O_TRUNC==02000 ;;O_CREAT=0100 ;;RDWR==02
            mov rdx, 0b_110_000_000
            syscall

            mov rdi, rax
            call p_hexa2str

            mov rdi, 0x_ffff_aaaa_1111_2222
            call p_hexa2str

        end:
            mov rax, 60
            xor rdi, rdi
            syscall

