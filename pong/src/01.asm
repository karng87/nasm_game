bits 16
org 0x7c00

times 510 - ($-$$) db 0
; ....55aa
db 0x55
db 0xaa
