bits 16
org 0x7c00

  mov ax, 0
  mov ds, ax
  mov es, ax

  .init:
      mov si, msg
      cld
      mov ah, 0xe
  .check:
      cmp byte[si], 0
      je .done
  .do:
      mov al, byte[si]
      int 0x10
  .step:
      inc si
      jmp .check
  .done:

jmp $

msg db 'GameOS is loaded!', 0xa, 0xd, 0
error_msg db 'Failed to real sector from USB', 0xa, 0xd, 0
times 510 - ($ - $$) db 0
dw 0xaa55
