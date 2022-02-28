; nasm -felf64 %
; gcc %.o

extern printf

section .data
  fmt: db "NASM: %d",0xa,0

section .text
global main
main:
  push rbp
  lea rdi, [rel fmt] 
  mov rsi, 0xa
  call printf wrt ..plt
  pop rbp
  ret
