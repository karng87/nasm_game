;; /usr/include/asm-generic/fcntl.h
%include "inc/print.inc"

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

            mov rdi, rax
            call print_hex

            mov rdi, 0x_ffff_abcd_ef12_3456
            call print_hex

        end:
            mov rax, 60
            xor rdi, rdi
            syscall

