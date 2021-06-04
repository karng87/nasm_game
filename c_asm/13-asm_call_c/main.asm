extern message

section .data

section .bss

section .text
    global main
    main:
        mov rcx, 5
        .lp:
          push rcx
          call message
          pop rcx
          loop .lp

        mov rax, 60
        mov rdi, 0
        syscall
    
