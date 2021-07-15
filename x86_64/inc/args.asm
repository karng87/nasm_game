%include "x64_io.inc"
section .text
  global main
  main:
    push rbp ;; rbp - return address - argc -- argv
    mov rbp, rsp

      mov rbx, rbp
      mov rdi, [rbx + 8]
      push rdi
      call p_hexadecimal
      call p_newline

      xor r12, r12
      inc r12
      pop r13

      .for:
          mov rdi, [rbx + 8 + r12 * 8]
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
