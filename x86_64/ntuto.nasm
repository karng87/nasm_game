;; /usr/include/asm-generic/fcntl.h
%include "inc/print_hex.inc"

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
            mov rax, 1
            mov rdi, 1
            mov rsi, msg
            mov rdx, msg_len
            syscall

            mov rdi, rax
            call print_hex

        end:
            mov rax, 60
            xor rdi, rdi
            syscall

