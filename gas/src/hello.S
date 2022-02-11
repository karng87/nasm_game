# https://cs.lmu.edu/~ray/notes/gasexamples/

.global _start
.text
# syscall (rax, rdi, rsi, ..)
_start:
  # write (1,msg,13) ::  syscall (write syscall , msg , length)
  mov $1, %rax
  mov $1, %rdi
  mov $msg, %rsi
  mov $13, %rdx
  syscall

  # exit(0) :: syscall (60,return value) return value := rax = 0
  mov $60, %rax
  xor %rdi,%rdi
  syscall

msg:
  .ascii "Hello, world\n"
