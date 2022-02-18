extern printf

section .data
fmt: db "Hello %s!",10,0
.arg1: db "Lee",0
section .text
global main
main:
  ;lea rdi, [rel fmt]
  mov rdi, fmt
  ;lea rsi, [rel fmt.arg1]
  mov rsi, fmt.arg1
  sub rsp,(6+8+1)*8       ;; int args 6(rdi,rsi,rdx,rcx,r8,r9) float args 8 retrun addr 1
  call printf
.exit:
  mov rax, 60
  xor rdi,rdi
  syscall
