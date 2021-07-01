section .data
    codes: db "hello\n"

section .bss

d:ection .text
    global main
    main:
        mov rsi, codes
        mov rsi, [codes]

