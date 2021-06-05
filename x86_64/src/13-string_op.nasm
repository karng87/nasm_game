section .data
      HelloWorld: db "Hello World!"
      len: equ $-HelloWorld

section .bss
      Copy: resb len
      var1: resb 8

section .text
      global main
      main:

          ;; Movsb/w/d/q Memory[rsi] to Memory[rdi]
          cld
          lea rsi, [HelloWorld]
          lea rdi, [Copy]
          movsq

          cld
          lea rsi, [HelloWorld]
          xor rax, rax
          mov qword[Copy], rax
          lea rdi, [Copy]
          mov rcx, len
          rep movsb

          ;; stosb/w/d/q Register(rax) to Memory[rdi]
          mov rax, 0x_0123_4567_89ab_cdef
          lea rdi, [var1]
          stosq

          ;; lods/w/d/q Memory[rsi] to Register(rax)
          xor rax, rax
          lea rsi, [var1]
          lodsq
