;%include "x64_io.inc"

section .text
  global _start
 _start:
      pop r8
      or r8, 0x30
      push r8
      mov rax, 1
      mov rdi, 1
      mov rsi, rsp
      mov rdx, 1
      syscall
      pop rsi

      mov rax, 60
      xor rdi, rdi
      syscall
