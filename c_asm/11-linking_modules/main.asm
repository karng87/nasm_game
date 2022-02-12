extern print_strz
extern print_string
extern newline_out
extern input

section .data
    prompt1 db "Who are you? "
    prompt1_len equ $-prompt1

    prompt2 db "What is your mood? "
    prompt2_len equ $-prompt2

    reply1 db "Hello, ", 0

    reply2 db "Well, ", 0

    reply3 db ", I fell ", 0

    reply4 db " too", 0x0A, 0

section .bss
    name resb 32 
    mood resb 32
    
section .text
    global _start

    _start:
        mov rdi, prompt1
        mov rsi, prompt1_len
        call print_string

        mov rdi, name
        mov rsi, 32
        call input

        mov rdi, reply1
        call print_strz
        mov rdi, name
        call print_strz
        call newline_out

        mov rdi, prompt2
        mov rsi, prompt2_len
        call print_string

        mov rdi, mood
        mov rsi, 32
        call input

        mov rdi, reply2
        call print_strz

        mov rdi, name
        call print_strz

        mov rdi, reply3
        call print_strz

        mov rdi, mood
        call print_strz

        mov rdi, reply4
        call print_strz

        mov rax, 60
        syscall
