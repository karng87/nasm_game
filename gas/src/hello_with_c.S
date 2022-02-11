# https://cs.lmu.edu/~ray/notes/gasexamples/

.global main
.text
# main := when using gcc 
# _start := when using gcc -c  $ ld
# _start := when using as & ld

#---------------------------------------------
#-- ABI(Application Binary Interface) for C --
#---------------------------------------------
# for pointers and integer, func(rdi,rsi,rdx,rcx,r8,r9)
# for floating-point, func(xmm0,xmm1,xmm2,xmm3,xmm4,xmm5,xmm6,xmm7)
# additional parameters are pushed on the stack, right to left
#   and are removed by the caller after the call
# After the parametes are pushed,
#   the call instructon is made, so when the called function gets controll,
#   the return address is at (%rsp)
#   the first memory parameter is at 8(%rsp)
#---------------------------------------------
#-- ALIGNED STACK in x86_64 for C functions --
#---------------------------------------------
# Before making a call C function
#   the %rsp must be aligned to a 16 byte boundary
# note : the process of makeing a call pushes the return address(8-byte) on the stack
#         , therefore when a function gets controll, %rsp is not aligned
#           , you have to make extra 8-byte space yourself
#           , by pushing rbp,rbx,r12~r15(callee-save regitsters)
# note : return value to rax or rdx:rax, xmm0 or xmm1:xmm0

# gcc -no-pie hello_with_c.S
main: 
  push %rcx
  mov $msg, %rdi
  call puts
  ret

msg:
  .asciz "Hola, mundo" # asciz ascizero : puts a 0byte at the end
