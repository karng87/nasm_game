;==========================
;        BOOTLOADER
;==========================

[bits 16]
[org 0x7c00]

msg: db 'GameOS is loaded!', 10, 13, 0


xor ax, ax
mov ds, ax
mov es, ax

    lea si, [msg]
    mov ah, 0x0e
    
    .next_char:
        mov al, [si]
        cmp al, 0
        je .return
        int 0x10 
        inc si
        jmp .next_char
    
    .return:
    jmp $


times 510 - ($ - $$) db 0 
dw 0xaa55                




