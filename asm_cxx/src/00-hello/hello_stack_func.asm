section .data
    msg: db "Hello, printn msg func!", 0x0A, 0
    msg_length equ $-msg

    STDIN  equ 0
    STDOUT equ 1
    STDERR equ 2

    SYSCALL_READ  equ 0
    SYSCALL_WRITE equ 1
    SYSCALL_EXIT  equ 60

    EXIT_OK equ 0

section .bss
section .text
    global main

    main:
        call print
        call printmsg

        mov rax, SYSCALL_EXIT
        syscall

    print:
        sub rsp, 8
        mov byte[rsp], 'H'
        mov byte[rsp+1], 'e'
        mov byte[rsp+2], 'l'
        mov byte[rsp+3], 'l'
        mov byte[rsp+4], 'o'
        mov byte[rsp+5], '!'
        mov byte[rsp+6],0xa
        mov byte[rsp+7],0
        ;; rax(rdi,rsi,rdx,rcx) := 1(1,rsp,8);
        mov rax, SYSCALL_WRITE  ;rax = 1
        mov rdi, STDOUT         ;rdi = 1
        mov rsi, rsp            ;rsi = address of msg
        mov rdx, 8              ;rdx = length of msg
        syscall
        add rsp,8
        ret
  printmsg:
        mov rax, SYSCALL_WRITE  ;rax = 1
        mov rdi, STDOUT         ;rdi = 1
        mov rsi, msg            ;rsi = address of msg
        mov rdx, msg_length              ;rdx = length of msg
        syscall
        ret


