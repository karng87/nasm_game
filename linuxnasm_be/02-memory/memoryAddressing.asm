bits 64

global MemoryAddressing
global num
global sum

section .bss
      ; global sum, section .bss, sum resd 1
      common sum 4   ; global uninitialized 4byte
section .data
section .code
