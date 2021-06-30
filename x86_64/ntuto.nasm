<<<<<<< HEAD
section .data
    codes: db "hello\n"

section .bss

section .text
    global main
    main:
        mov rsi, codes
        mov rsi, [codes]
        lea rsi, j

=======
>>>>>>> 31ff0e9d5d694e5125e3cc4b95fc07de19f965bf
