bits 16
org 0x7c00

section .text

set_vga_address:
    mov ax, 0xb800
    mov es, ax

set_vga_mod:
    mov ah, 0       ; select vga mode
    mov al, 3       ; 25 x 80 16 color text mode
    int 0x10

set_cursor_shape:
    mov ah, 1       ; cursor shape
    mov ch, 0x26    ; start scanline (bit 5 = 1)
    mov cl, 0x07    ; end scanline
    int 0x10        ; box

set_cursor_position:
    mov ah, 2       ; cursor position
    mov dh, 24      ; dh = rows
    mov dl, 79      ; dl = columns
    int 0x10

;=================================
; https://wiki.osdev.org/Text_UI
;Bit 7|654||3|210
;   7:= bg brightness, 654:=bg color , 3:=fg brightness 210:=fg color
; 1111|0000 := white(bg)|black(fg)
; 1111|1111 := white(bg)|white(fg)
screen_clear:
    xor di, di
  .lp:
    mov al, 0
    mov ah, 0b_1111_0000
    mov word[es:di], ax

    add di, 2
    cmp di, (80 * 2) * 25 - 1
    jl .lp

jmp screen_clear

times 510 - ($-$$) db 0
dw 0xaa55
