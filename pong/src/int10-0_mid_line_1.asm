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
    cmp di, (80 * 2) * 25 - 1
    jl .clear

        ; 0-79    => 0 ~ 40 ~ 79   
        ; 0-159   => 0 ~ 80 ~ 158:159 
        ; 160-319 => 160 ~ 240 ~ 318:319
        ; 320-479 => 

    .init_mid:
        mov ah, 0b_0000_1111
        mov al, 0
        mov di, 80

    .check_mid:
        cmp di, 80 + 160 * 24
        jg .done
    .do_mid:
        mov word[es:di], ax
    .step_mid:
        add di, 160 * 2
        jmp .check_mid
    .done:
        

    xor si, si
    xor di, di

  jmp $
times 510 - ($-$$) db 0
dw 0xaa55
