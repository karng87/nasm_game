;; /usr/include/asm-generic/fcntl.h

section .data
      cnt: db 0
      position: db 16
      weight: dq 1
section .bss
      arg: resq 1
      decimal: resb 16
      tmp: resq 1
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
            inc byte[cnt]


            xor rdx, rdx  ;; unsigned div or mul need to xor rdx, rdx 
                          ;;signed div or mul cdo(chaange byte to quard) 
                            ;; cwd, cdq, cdo
            mov rax, [weight]
            mov rcx, 10
            mul rcx
            mov [weight], rax

            mov rax, [arg]
            xor rdx, rdx  ;; unsigned div or mul need to xor rdx, rdx 

            mov r9, [weight]
            div r9          ;; div rm64 == rax:rdx, rax=quotient rdx=remainder

            dec byte[position]
            xor rcx, rcx
            mov cl, [position]

            lea rbx, [decimal + rcx]
            mov [tmp], rdx
            xor rdx, rdx
            mov r9, 10
            mov rax, [weight]
            div r9

            xor rdx, rdx
            mov r9,rax
            mov rax, [tmp]
            div r9

            add rax, '0'
            mov [rbx], al, 
              cmp byte[cnt], 16
              jle .check_num


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

