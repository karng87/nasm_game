.code16 # tell GAS to output 16-bit code
  mov $msg, %si
  mov $0xe, %ah
lp:
  mov (%si), %al
  or %al, %al
  jz halt
  int $0x10
  inc %si
  jmp lp

halt:
  hlt

msg:
  .asciz "hello world"
