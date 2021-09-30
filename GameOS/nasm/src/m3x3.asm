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
    mov ah, 0b_0000_1100
    mov si, ax
    call print_position_vec

        ; i hat + tm
        push 1
        push 0
        push 5
        
        ; j hat + tm
        push 0
        push 1
        push 10

        ; xy vector
        push 40
        push 10
        ; transmission hold element
        push 1

    call m3x3
    mov di, ax
    mov al, "X"
    mov ah, 0b_1111_1100
    mov si, ax
    call print_position_vec

    jmp $

m3x3:
    ; m11(20) m21(18) m31(16) = i hat
    ; m12(14)  m22(12) m32(10) = j hat
    ; x(8) y(6) h(4)       = input vec
    ; ret bp

    ; x'= (m11 * x) + (m21 * y) + (m31 * h)
    ; y'= (m12 * x) + (m22 * y) + (m32 * h)
    push bp
    mov bp, sp

    mov ax, word[bp+20] ; m11
    imul ax, word[bp+8]
    push ax

    mov ax, word[bp+18] ; m21
    imul ax, word[bp+6]  ; m11 * y
    pop bx
    add ax, bx
    push ax

    mov ax, word[bp+16] ; m31
    imul ax, word[bp+4]  ; m31 * h
    pop bx
    add ax, bx  ; x'
    push ax     ; x'

    mov ax, word[bp+14] ; m12
    imul ax, word[bp+8]  ; m11 * x
    push ax

    mov ax, word[bp+12] ; m22
    imul ax, word[bp+6]  ; m11 * y
    pop bx
    add ax, bx
    push ax

    mov ax, word[bp+10] ; m32
    imul ax, word[bp+4]  ; m32 * h
    pop bx
    add ax, bx

    imul ax, 160

    pop bx
    imul bx, 2
    add ax, bx  ; address

    mov sp, bp
    pop bp
    ret

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




