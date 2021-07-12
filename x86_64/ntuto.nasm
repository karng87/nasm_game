%include "inc/x64_print.inc"

section .data
  msg: db "hello world",0xa, 0
section .bss
  arg: resq 1
  argc: resq 1
  argv: resq 1

section .text
  global main
  main:
      push rdi
      push rsi

        call p_d2s
        call p_newline

        pop rdi
        call p_x2s

        call exit
