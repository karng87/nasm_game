; ----------
; ram
;   0x_7c00 ~ 0x7dff  512 bootloader
;   0x_7e00 ~ 0x8000  512 files
; ----------
  
; ----------
; disk
;   0x_0000 ~ 0x01ff  512 bootloader
;   0x_0200 ~ 0x0400  512 files
; ----------

; ----------
; sector
;   floppy disk = 512-bytes in each sector
;   hard disk = 4096-bytes in each sector
; ----------
bits 16
org 0x7c00

  mov ax, 0
  mov ds, ax
  mov es, ax

msg_print:
      mov si, msg
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

read_disk_sectors:
  ;ES:BX = pointer to buffer
  .init:
      mov bx, 0x_7e00 ; pointer to buffer es:bx

      mov ah, 2       ; bios code to read disk sector 
      
      mov al, 1       ; the length of sectors
      mov ch, 0       ; the cylinder number
      mov cl, 2       ; the sector number 2(513~)

      mov dh, 0       ; the head number
      int 0x13
      jc .print_error
      jmp .pe_done

  .print_error:
      mov si, error_msg
      mov ah, 0xe
      .pe_check:
        cmp byte[si], 0
        je .pe_done
      .pe_do:
          mov al, byte[si]
          int 0x10
      .pe_step:
          inc si
          jmp .pe_check
      .pe_done:

jmp $

msg db 'GameOS is loaded!', 0xa, 0xd, 0
error_msg db 'Failed to real sector from USB', 0xa, 0xd, 0
times 510 - ($ - $$) db 0
dw 0xaa55
