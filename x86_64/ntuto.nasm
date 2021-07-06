;; /usr/include/asm-generic/fcntl.h
%include "inc/print.inc"

section .data
    count: db 16
    carry: db 0

section .bss
    msg: resb 100
    return: resq 1
    value: resb 16

section .text
global main
  main:
      mov rax, 0
      mov rdi, 0
      mov rsi, msg
      mov rdx, 100
      syscall
      
      mov [return], rax
      ;mov rdi, rax
      ;call print_hex

      xor rcx, rcx 

    lp:
      sar rax, cl
      and rax, 0xf

        cmp al, 0xa
          jge over_a
      add al,'0'
      add al, [carry]
      mov byte[carry], 0
      jmp save_val

    over_a:
      add al, 38
      add al, [carry]
      mov byte[carry], 1

    save_val:
      dec byte[count]

      xor rdx, rdx
      mov dl, [count]

      mov rbx, value

      lea rbx, [rbx + rdx]
      mov [rbx], al

      mov rax, [return]
      add rcx, 4
        cmp rcx, 64
          jl lp

      

      mov rax, 1
      mov rdi, 1
      mov rsi, value
      mov rdx, 32
      syscall

      mov rdi, 0x0a
      call print_char
      mov rdi, [return]
      call print_hex

      mov rax, 60
      mov rdi, 0
      syscall

