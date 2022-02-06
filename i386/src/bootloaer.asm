bits 16
org 0x7c00

  mov ah, 6
  mov al, 10
  mov bh, 0b_0001_0000
  mov ch, 0 
  mov cl, 0 
  mov dh, 15
  mov dl,15
  int 10h

jmp $

times 510 - ($ - $$) db 0
db 0x55
db 0xaa
