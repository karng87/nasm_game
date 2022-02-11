.global main
.text

#-----------------------------------
#-- x86_64 command line arguments --
#-----------------------------------
# %rdi := int argc
# %rsi := char **argv
main:
  push %rdi
  push %rsi

  # must align stack 16-byte boundary before call
  sub $8, %rsp
  
  mov (%rsi), %rdi
  call puts

  add $8, %rsp
  pop %rsi
  pop %rdi

  add $8, %rsi
  dec %rdi
  jnz main

  ret

#forman:
#  .asciz "%s\n"

