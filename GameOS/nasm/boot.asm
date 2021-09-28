;==========================
;        BOOTLOADER
;==========================

bits 16
org 0x7c00

;------------------------------------------
; vga addr:(back800x480)b800 => 0x000b_8000
;   ascii::fg color::bg color
;------------------------------------------
set_vga:    
    mov ah, 0
    mov al, 3
    int 0x10
        mov ax, 0xb800
        mov es, ax

    mov di, 0x0000
    mov al, "O"
    mov ah, 0b_1111_1100
    mov si, ax
    call print_position_vec

    lea di, [ball_A_vec]
    call get_vga_address_from_memory_vec
    push ax
      mov di, ax
      mov al, "A"
      mov ah, 0b_0000_1001
      mov si, ax
      call print_position_vec


    lea di, [ball_B_vec]
    call get_vga_address_from_memory_vec
    push ax
      mov di, ax
      mov al, "B"
      mov ah, 0b_0000_1010
      mov si, ax
      call print_position_vec

    pop cx
    pop di
    add di, cx
      mov al, "S"
      mov ah, 0b_0000_1100
      mov si, ax
      call print_position_vec

    
    jmp $

delay:
    mov ax, [0x046c]
    add ax, 10
    .lp:
        cmp ax, [0x046c]
        jg .lp
    ret

sum_of_vec:
    add di, si
      test dx,dx
        jnz .next
          mov dl, 'S'
          mov dh, 0b_1001_0000
    .next:
    call print_position_vec
    ret

get_vga_address_from_memory_vec:
    mov ax, word[di]
    movsx cx, ah
      imul cx, cx, 2
    movsx dx, al
      imul ax, dx, 160
    add ax, cx
    ret

get_vga_address_from_position_vec:
      imul di, di, 2
      imul ax, si, 160
    add ax, di 
    ret

print_position_vec:
    ; di: vga_address
    ; si: ascill and color value
        mov ax, 0xb800
        mov es, ax
        mov word[es:di], si
      ret
;--------------------------------
;   teletype mode (int 10,e)
;     :cursor advances after write
;--------------------------------
print_str:
    mov ah, 0x0e
    .next_char:
        mov al, [di]
        cmp al, 0
        je .return
        int 0x10 
        inc di
        jmp .next_char
    
    .return:
    ret

msg: db "hello ", 0
; x: 0~79(0x4f) y: 0~24(0x18)
position_vec_rows: dw 0x3010, 0x3011, 0x3012, 0x3014, 0x3016, 0x3018, 0x3020, 0x3022, 0x3024,0
position_vec_columns: dw 0x1010, 0x1110, 0x1210, 0x1310, 0x1410, 0x1510, 0x1610, 0x1710, 0x1810,0

ball_1_vec: dw 0x1000
ball_2_vec: dw 0x0010
ball_1_position_vec: dw 0x2803
ball_2_position_vec: dw 0x3001

ball_A_vec: dw 0x4f00
ball_B_vec: dw 0x0018

times 510 - ($ - $$) db 0 
dw 0xaa55                




