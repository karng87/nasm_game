; https://www.tutorialspoint.com/cprogramming/c_overview.htm

extern printf

section .data
fmt: db "Nasm %s!",10,0
.arg1: db "printf Lee",0
section .text
global main
main:
  push rbp
  lea rdi, [rel fmt]
  lea rsi, [rel fmt.arg1]
  ;; 최소 스택 영여 red zone (128 byte) + 16 byte * n
  ;sub rsp,(6+8+1)*8       ;;(6+8+1) int args 6(rdi,rsi,rdx,rcx,r8,r9) float args 8 retrun addr 1
  call printf wrt ..plt
.exit:
  mov rax, 60
  xor rdi,rdi
  syscall
