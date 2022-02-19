;================
; memory map
;   size of 512 byte = 0 ~ 0x1ff
;   0x7c00 ~ 0x7dff = sector-1
;   0x7e00 ~ 0x7fff = sector-2
;   0x8000 ~ 0x81ff = sector-3

bits 16
org 0x8000   ; starting address of sector-3

  mov ax, 0
  mov ds, ax
  mov es, ax

print_file_names_from_sec2:
  .init:
      mov si, 0x7e00
      mov ah, 0xe
  .check:
      cmp al, 0
      je .done
  .do:
      mov al, [si]
      int 0x10
  .step:
      inc si
      jmp .check
  .done:

read_disk_sector:
  mov ax, 0x7c0
  mov es, ax
  mov bx, 0       ; es:bx = es << 4 = 0x7c00 + 0
  mov ah, 2
  mov al, 1       ; length of sectors
  mov ch, 0       ; cylinder number
  mov cl, 6


  
