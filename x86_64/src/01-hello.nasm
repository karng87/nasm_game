;; nasm -felf64 src.asm
;; ld -melf_x86_64 -emain src.o
;;    gcc -no-pie src.o
;;    clang -no-pie src.o
;; ./a.out

section .data
    msg: db "Hello, Nasm!", 0x0A
    msg_len: equ $-msg

section .bss
section .text
    global main
    main:
        ;; write (stdout, *buff, count)
        mov rax, 1
        mov rdi, 1
        mov rsi, msg
        mov rdx, msg_len
        syscall

        ;; exit(0)
        mov rax, 60
        mov rdi, 0
        syscall
