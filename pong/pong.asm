bits 16
org 0x7c00
section .text

player_x  equ 2
player_length equ 5
player_y  dw 10
player_fbl  dw 0b_1010_0000_0000_0000

cpu_x     equ 78
cpu_length equ 5
cpu_y     dw 10
cpu_fbl   dw 0b_1001_0000_0000_0000

ball_x dw 1
ball_y dw 1
ball_x_acc dw 1
ball_y_acc dw 1
ball_fbl dw 0b_1100_0000_0000_0000 ; RGB

get_vga_address:
    mov ax, 0xb800
    mov es, ax

      mov ah, 03h 
      mov al, 05h ;set typematic rate/delay
      mov bh, 00h ;repeat delay: 250ms <-- this has to be 0
      mov bl, 00h ;typematic rate: 30
      int 16h
call game_init

game_loop:
  call screen_clear
  call draw_midline

  ; cpu 
      mov di, cpu_x
      mov si, [cpu_y]
      mov dx, cpu_length
      mov cx, [cpu_fbl]
  call draw_paddle
  call move_ball
key_event:
    mov ah, 1
    int 0x16
        jz .draw_player
    xor ah, ah
    int 0x16
        .jump:
        cmp al, 'j'
            jne .kick
          cmp word[player_y], 24 - player_length
            jg .draw_player
          inc word[player_y]
          jmp .draw_player

        .kick:
        cmp al, 'k'
            jne .draw_player
          cmp word[player_y], 0
            jle .draw_player
          dec word[player_y]
          jmp .draw_player

    .draw_player:
      mov di, player_x
      mov si, [player_y]
      mov dx, player_length
      mov cx, [player_fbl]
  call draw_paddle
  ;

call delay

jmp game_loop

;-----------------------------

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
        imul di, word[ball_x], 2
        imul si, word[ball_y],160
        add di, si
        mov ax, [ball_fbl]
        mov word[es:di], ax
    ret

delay:
    mov bx, [0x_046c]
    add bx, 5
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

draw_paddle:  ;; di:x si:y dx:length cx:char
    .init:
        imul di, di, 2
        imul si, si, 160
        add di, si
    .check:
        test dx, dx 
        je .done
    .do:
        mov [es:di], cx
    .step:
        add di, 160
        dec dx
        jmp .check
    .done:
    ret

times 510 - ($-$$) db 0
dw 0xaa55
