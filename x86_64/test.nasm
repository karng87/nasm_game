section .text
global main
main:
          mov rax, 1
          mov rdi, 1
          sub rsp, 1
          mov byte[rsp],'1'
          sub rsp, 1
          mov byte[rsp],'2'
          sub rsp, 1
          mov byte[rsp],'3'
          sub rsp, 1
          mov byte[rsp],'4'
          sub rsp, 1
          mov byte[rsp],'5'
          sub rsp, 1
          mov byte[rsp],'6'
          sub rsp, 1
          mov byte[rsp],'7'
          sub rsp, 1
          mov byte[rsp],'8'

          lea rsi, [rsp]
          mov rdx, 8
          syscall

          mov rax, 60
          mov rdi, 0
          syscall

