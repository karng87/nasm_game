bits 16
org 0x7c00
section .text
  jmp $
times 510 - ($-$$) db 0
dw 0xaa55
