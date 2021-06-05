section .data
    hello_world: db "Hello World!", 0xA
    length equ $-hello_world

section .bss
section .text
    global main

    helloProc:
        mov rax, 1
        mov rdi, 1
        mov rsi, hello_world
        mov rdx, length
        syscall

        ret

    main:
        mov rcx, 0x10
        .lp:
          push rcx
          call helloProc
          pop rcx
          loop .lp
