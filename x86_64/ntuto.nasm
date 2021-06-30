section .data
    codes: db "hello\n"

section .bss

section .text
    global main
    main:
        mov rsi, codes
        mov rsi, [codes]
        lea rsi, j

