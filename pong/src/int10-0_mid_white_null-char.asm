bits 16
org 0x7c00
section .text
_start:

    mov ax, 0xb800
    mov es, ax
    xor di, di

    mov ah, 0       ; select vga mode
    mov al, 3       ; 25 x 80 16 color text mode
    int 0x10

    mov ah, 1       ; cursor shape
    mov ch, 0x26    ; start scanline (bit 5 = 1)
    mov cl, 0x07    ; end scanline
    int 0x10        ; box

    mov ah, 2       ; cursor position
    mov dh, 24      ; dh = rows
    mov dl, 79      ; dl = columns
    int 0x10

  .clear:
    mov byte[es:di], 0
    mov byte[es:di+1], 0b_1111_0000; background:foreground

    add di, 2
    cmp di, 80 * 25 * 2
    jl .clear

    mov ah, 0b_0000_1111
    mov al, 0
    xor di, di
    mov di, 80
    mov word[es:di], ax

    xor si, si
    xor di, di

  jmp $
times 510 - ($-$$) db 0
dw 0xaa55
