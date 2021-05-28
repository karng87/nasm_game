bits 16
org 0x_7c00

times 510-($-$$) db 0
dw 0x_aa55
