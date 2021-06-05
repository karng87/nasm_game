section .data
      var1: dq 0x_1234_5678_90ab_cdef
      var2: dq 0x_fedc_ba12_3456_7890
      var3: dq 0x_1234_5678_09ab_cdef

section .bss
section .text
      global main
      main:
          ;; scab  rax vs rdi
          cld       ;; clear direction flag
          mov rax, 0x_1234_5678_90ab_cdef
          lea rdi, [var1]
          scasq       ;; scan a register string qword to rdi(es:edi)

          ;; scab  rax vs rdi
          cld       ;; clear direction flag
          ;mov rax, 0x_1234_5678_90ab_cdef
          lea rdi, [var2]
          scasq       ;; scan a register string qword to rdi(es:edi)
                      ;; set CF

          ;; cmpsb compare memory(ds:si vs es:di)
          cld
          lea rsi, [var1]
          lea rdi, [var3]
          cmpsq   ;; set ZF

          ;; exit
          mov rax, 60
          mov rdi, 0
          syscall


