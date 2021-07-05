%include "inc/print.inc"
section .text
global main
main:

      mov rdi, 0x_0001_0001
      call print_decimal
      mov rax, 60
      mov rdi, 0
      syscall
