# gcc %
#.section .rodata
.data
  msg: .asciz "GAS: %d\n"

.text
.global main
  main:
    push %rbp
    lea msg(%rip), %rdi
    mov $99, %rsi
    xor %rax, %rax
    call printf@plt
    pop %rbp
    ret
