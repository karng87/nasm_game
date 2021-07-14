%include "x64_io.inc"
section .text
  global main
  main:

      mov rbx, rsp
      mov rdi, [rbx]
      push rdi
      call p_hexadecimal
      call p_newline

      xor r12, r12
      inc r12
      pop r13

      .for:
          mov rdi, [rbx+r12*8]
            cmp r12, r13
              je .out
          inc r12
            call p_mem
            call p_newline
          jmp .for
      .out:
          call p_mem
          call p_newline

      call exit
