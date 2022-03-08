.extern printf
.extern exit
.data
  fmt: byte '%d'
.text
.global main
main:
  movl fmt, %rdi
  call printf @plt
  call exit @plt

  
