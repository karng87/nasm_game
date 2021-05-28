bits 16
org 0x_7C00

;; DEFINED VARIABLES AFTER SCREEN MEMORY - 
;;    320*200 = 64000 or 0x_FA00 
sprites      equ 0x_FA00
alien1       equ 0x_FA00
alien2       equ 0x_FA04
ship         equ 0x_FA08
barrierArr   equ 0x_FA0C 
alienArr     equ 0x_FA20  ; 2 words (1 dblword) - 32bits/aliens
playerX      equ 0x_FA24
shotsArr     equ 0x_FA25  ; 4 Y/X shot values - 8 bytes, 1st shot is player
alienY       equ 0x_FA2D
alienX       equ 0x_FA2E
num_aliens   equ 0x_FA2F  ; # of aliens still alive
direction    equ 0x_FA30  ; # pixels that aliens move in X direction
move_timer   equ 0x_FA31  ; 2 bytes (using BP) - \
                          ; # of game loops/timer ticks to wait before aliens move
change_alien equ 0x_FA33  ; Use alternate sprite yes/no

;; CONSTANTS =====================================
SCREEN_WIDTH        equ 320     ; Width in pixels
SCREEN_HEIGHT       equ 200     ; Height in pixels
VIDEO_MEMORY        equ 0x_A000
TIMER               equ 0x_046C   ; # of timer ticks since midnight
BARRIERXY           equ 0x_1655
BARRIERX            equ 0x_16
BARRIERY            equ 0x_55
PLAYERY             equ 93
SPRITE_HEIGHT       equ 4
SPRITE_WIDTH        equ 8       ; Width in bits/data pixels
SPRITE_WIDTH_PIXELS equ 16      ; Width in screen pixels

; Colors
ALIEN_COLOR         equ 0b_0000_0010   ; Green
PLAYER_COLOR        equ 0b_0000_0111   ; Gray
BARRIER_COLOR       equ 0b_0010_0111   ; Red
PLAYER_SHOT_COLOR   equ 0b_0000_1011   ; Cyan
ALIEN_SHOT_COLOR    equ 0b_0000_1110   ; Yellow

;; SETUP ===============================================
  ;; set up video mode - VGA mode 13h, 320x200, 256 colors, 
  ;; 8bpp, linear frambuffer at address 0x_000A_0000
  mov ax, 0x_0013
  int 0x_10

  ;; set up video memory
  ;mov ax, 0x_A000
  ;mov es, ax
  push VIDEO_MEMORY
  pop ES        ;; es -> 0x_000A_0000 ; real memory address = es*0x_01

;; Move initial sprite data into memory
  mov DI, sprites ; 360x200 = 0x_FA00
  mov SI, sprite_bitmaps ; data segments.
  mov CL, 6 ; repeat times
  reps movsw ; repet CL times (mov [ES:DI], [DS:SI],  and ++DI, ++SI)

  lodsd ;; mov EAX, dword[DS:SI] ; store 5barriers in memory for barrierArr
  mov cl, 5 ; 5 times barriers data 
  rep stosd ; mov [ES:DI], EAX

  ;; set initial variable values
  mov cl, 5 ; Alien array & playerX
  pep movsw

  xor ax, ax ; Shots array - 8byte Y/X values
  mov cl, 4
  rep stosb 

  mov cl, 7 : AlienY/X # of aliens, direction, move timer, change alien
  rep movsb
  
  push ES
  pop DS  ; DS = ES
  

;; GAME LOOP ============================================
  game_loop:
      xor ax, ax
      xor di, di
      mov cx, SCREEN_WIDTH * SCREEN_HEIGHT
      rep stosb     ;; repeat cx times <- mov [ES:Di], al , ++di

      ;; ES:DI now point to 0x_000A_FA00
      mov si, alienArr
      mov bl, ALIEN_COLOR
      mov ax, [SI+13] ; AL = alienY, AH = alienX
        cmp byte[SI+19], CL ; Change alien? CL=0 form above
        jg draw_alien_loop ; Nope, use nomal from above
      add di, cx

    draw_alien_loop:
      pusha
        mov cl, 8 ; # of aliens to check per row
        .next_ow;
          pusha
          dec cx
          bt [si], cx ; Store selected bit in CF flag

      popa


  ;; delay timer - 1 tick delay(18.2 tick/second) -> 0x_046C
  delay_timer:
      mov ax, [0x_046C] 
      inc ax
      .wait:
        cmp [0x_046C], ax
          jl .wait

;; GAME END & reset TODO: ==============================
  game_over:
    cli ;; clear interrupt flag
    hlt ;; halt

;; CODE SEGMENT DATA =================================
  sprite_bitmaps:
    db 10011001b    ; Alien 1 bitmap
    db 01011010b
    db 00111100b
    db 01000010b

    db 00011000b    ; Alien 2 bitmap
    db 01011010b
    db 10111101b
    db 00100100b

    db 00011000b    ; Player ship bitmap
    db 00111100b
    db 00100100b
    db 01100110b

    db 00111100b    ; Barrier bitmap
    db 01111110b
    db 11100111b
    db 11100111b

    ;; Initial variable values
    dw 0x_FFFF       ; Alien array
    dw 0x_FFFF
    db 70           ; PlayerX
    ;; times 8 db 0 ; Shots array
    dw 0x_230A        ; alienY & alien X | 10 = Y, 35 = X
    db 0x_20          ; # of aliens = 32 TODO: Remove & check if alienArr = 0, 
                    ;   This is probably not needed, can save some bytes
    db 0x_0FB         ; Direction -5
    dw 18           ; Move timer
    db 1            ; Change alien - toggle between 1 & -1

;; $ symbol denotes the current address of the statement
;; $$ symbol denotes the address of the beginnig of current section
;dup 510-($-$$) db 0 
;section boot_signature start=0x_7dfe  ;; 7dfe - 7c00 = 1fe(510)
times 510-($-$$) db 0 

dw 0x_aa55                            ;; boot signature
