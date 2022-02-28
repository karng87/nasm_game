.global main
.text
main:
  push %rbp
  mov msg(%rip), %rdi
  call puts
  ret

.data
msg:
  .asciz "Hello S"
