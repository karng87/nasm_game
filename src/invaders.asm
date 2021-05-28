bits 16
org 0x_7C00
;; SETUP ===============================================
  ;; set up video mode - VGA mode 13h, 320x200, 256 colors, 
  ;; 8bpp, linear frambuffer at address 0x_000A_0000
  mov ax, 0x_0013
  int 0x_10

  ;; set up video memory
  ;mov ax, 0x_A000
  ;mov es, ax
  push 0x_A000
  pop es        ;; es -> 0x_000A_0000 ; real memory address = es*0x_01

;; GAME LOOP ============================================
  game_loop:
    mov al, 0b_0000_0100
    mov cx, 320*200
    xor di, di
    rep stosb     ;; repeat cx times <- mov [ES:Di], al , ++di
      jmp game_loop

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

;; $ symbol denotes the current address of the statement
;; $$ symbol denotes the address of the beginnig of current section
;dup 510-($-$$) db 0 
;section boot_signature start=0x_7dfe  ;; 7dfe - 7c00 = 1fe(510)
times 510-($-$$) db 0 

dw 0x_aa55                            ;; boot signature
