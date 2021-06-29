.global main
.text

main:
    mov $1, %rax
    mov $1, %rdi
    mov $msg, %rsi
    mov $11, %rdx
    syscall

    mov $60, %rax
    xor %rdi, %rdi
    syscall
msg: 
    .ascii "Hello GAS\n"
