;; /usr/include/asm-generic/fcntl.h

section .data
      carry: db 0
      weight: db 0
      shift: db 0

section .bss
      arg: resq 1
      decimal: resb 16
      
section .text
  global main
  main:
            mov rdi, 0x_0000_0000_0000_baf8

            mov [arg], rdi 
            xor rcx, rcx
            xor r8, r8
       .chekck_sign:
            sar rdi, 63
            cmp dil, 0xff
              je .negative
          .positive:
            mov byte[decimal], "+"
            jmp .check_num
          .negative:
            mov byte[decimal], "-"
            not qword[decimal]
            add qword[decimal],  1

          .check_num:
            mov rax, [arg]
            xor rdx, rdx  ;; unsigned div or mul need to xor rdx, rdx 
                          ;;signed div or mul cdo(chaange byte to quard) 
                            ;; cwd, cdq, cdo
            mov r9, 10
            div r9          ;; div rm64 == rax:rdx, rax=quotient rdx=remainder
            mov rcx, 15
            lea rbx, [decimal + rcx]
            add dl, '0'
            mov [rbx], dl, 


          .print:
            mov rax, 1
            mov rdi, 1
            mov rsi, decimal
            mov rdx, 16
            syscall
            

        end:
            mov rax, 60
            xor rdi, rdi
            syscall

