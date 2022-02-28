# https://cs.lmu.edu/~ray/notes/gasexamples/

.global maxOfThree
.text

maxOfThree:
  mov %rdi, %rax
  cmp %rsi, %rax  # is %rax less than %rsi?
  cmovl %rsi, %rax # if so, movlong(4-byte) %rsi, %rax
  cmp %rdx, %rax
  cmovl %rdx, %rax
  ret
