bits 64
section .text
global _start
_start: 
            mov             rax, 1; write
            mov             rdi, 1              ; stdout
            mov             rsi, msg
            mov             rdx, len
            syscall
            mov             rax, 60; exit
            mov             rdi, 0              ; return 0
            syscall

section .data
msg:        db              'Hello world', 0x0A ; 'Hello world' followed by newline
len:        equ             $ - msg
