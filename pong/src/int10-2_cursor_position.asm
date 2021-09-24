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

    mov ah, 2       ; cursor position
    mov dh, 0       ; dh = rows
    mov dl, 0       ; dl = columns
    int 0x10

    mov ah, 2       ; cursor position
    mov dh, 24      ; dh = rows
    mov dl, 79      ; dl = columns
    int 0x10

    mov ah, 1       ; cursor shape
    mov ch, 0x00    ; start scanline 
    mov cx, 0x07    ; end scanline
    int 0x10        ; box



  .clear:
    mov byte[es:di], 0
    mov byte[es:di+1], 0b_0000_1111 ; background:foreground

    add di, 2
    cmp di, 80 * 25 * 2
    jl .clear
    xor si, si
    xor di, di

  jmp $
times 510 - ($-$$) db 0
dw 0xaa55
