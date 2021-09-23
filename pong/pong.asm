org 0x00
bits 16
section .text
  jmp 0x7c0:_start
_start:
    mov ax, 0x07c0
    mov ds, ax

    mov ax, 0xb800
    mov es, ax
    xor di, di
  .clear:
    mov byte[es:di], 'A'
    mov byte[es:di+1], 0b_0000_1111 ; background:foreground

    add di, 2
    cmp di, 80 * 25 * 2
    jl .clear
    xor si, si
    xor di, di

  jmp $
times 510 - ($-$$) db 0
dw 0xaa55
