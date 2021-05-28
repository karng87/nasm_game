bits 16
org 0x_7c00

  cli ;; clear interrupt flag
  hlt ;; halt

;; $ symbol denotes the current address of the statement
;; $$ symbol denotes the address of the beginnig of current section
;dup 510-($-$$) db 0 
times 510-($-$$) db 0 

; section boot signature start = 0x_7dfe
;; 7dfe - 7c00 = 1fe(510)
;; boot signature
dw 0x_aa55
