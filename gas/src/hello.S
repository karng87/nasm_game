# https://cs.lmu.edu/~ray/notes/gasexamples/

.global main
.text
# syscall rax(rdi, rsi,rdx, rcx, r8, r9)
main:
  # write => rax(rdi,1(1,msg,13) ::  syscall (write syscall , msg , length)
  mov $1, %rax
  mov $1, %rdi
  lea msg(%rip), %rsi
  mov $13, %rdx
  syscall

  # exit(0) => 60(rdi) return value rdi= 0
  mov $60, %rax
  xor %rdi,%rdi
  syscall

.data
msg:
  .ascii "Hello, world\n"
