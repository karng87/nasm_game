bits 16
org 0x7c00
section .text

; 80 x 25
ball_x dw 1
ball_y dw 1
ball_x_acc dw 1
ball_y_acc dw 1

get_vga_address:
    mov ax, 0xb800
    mov es, ax

call game_init

game_loop:
  call screen_clear
  call draw_midline

  ; left paddle
      mov di, 160 * 10 + 2 
      mov si, 5
      mov dx, 0b_0000_1111_0000_0000
  call draw_paddle

  ; right paddle
      mov di, 160 * 10 + 156
      mov si, 5
      mov dx, 0b_0000_1111_0000_0000
  call draw_paddle
  ;

move_ball:
    .check_top:
        cmp word[ball_y], 0
        jle .reflect_y

    .check_bottom:
        cmp word[ball_y], 24
        jge .reflect_y
        jmp .check_left

      .reflect_y:
        not word[ball_y_acc]
        inc word[ball_y_acc]

    .check_left:
        cmp word[ball_x], 0
        jle .reflect_x

    .check_right:
        cmp word[ball_x], 79
        jge .reflect_x
        jmp .check_end
        
      .reflect_x:
        not word[ball_x_acc]
        inc word[ball_x_acc]

    .check_end:
        mov ax, word[ball_x_acc]
        add word[ball_x], ax
        mov ax, word[ball_y_acc]
        add word[ball_y], ax
        
    .draw_ball:
        mov ax, 0b_1001_1111_0000_0000
        imul di, word[ball_x], 2
        imul si, word[ball_y],160
        add di, si
        mov word[es:di],ax

call delay

jmp game_loop

;;===========================

delay:
    mov bx, [0x_046c]
    add bx, 10 
    .lp:
      cmp bx, [0x046c]
      jle .timeout
      jmp .lp
    .timeout:
    ret

game_init:
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

    ret

screen_clear:
    xor di, di
  .clear:
    mov al, 0
    mov ah, 0b_1111_0000
    mov word[es:di], ax

    add di, 2
    cmp di, (80 * 2) * 25 - 1
    jl .clear
    ret

draw_midline:
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
    ret

draw_paddle:  ;; di: position si: length dx: char
    .init:
        ;mov di, 160 * 10 + 2
        ;mov si, 5
        mov si, si
        mov ax, dx

    .check:
        test si, si 
        je .done
    .do:
        mov al, 0
        mov ah, 0b_0000_1111
        mov [es:di], ax
    .step:
        add di, 160
        dec si
        jmp .check
    .done:
    ret

times 510 - ($-$$) db 0
dw 0xaa55
