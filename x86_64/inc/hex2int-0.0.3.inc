;; /usr/include/asm-generic/fcntl.h

section .data
      cnt: db 0
      position: db 16
      weight: dq 1
section .bss
      arg: resq 1
      sign: resb 1
      decimal: resb 16
      tmp: resq 1

section .text
  hex2int3:
    .prolog:
      push rbp
      mov rbp, rsp

            mov [arg], rdi 
            xor rcx, rcx
       .chekck_sign:
            sar rdi, 63
            cmp dil, 0xff
              je .negative
          .positive:
            mov byte[sign], "+"
            jmp .check_num
          .negative:
            mov byte[sign], "-"
            not qword[arg]
            add qword[arg],  1

          .check_num:
            inc byte[cnt]

          .mul_1:  ;; rdx:rax ;; increase by weight 10
            xor rdx, rdx  ;; unsigned div or mul need to xor rdx, rdx 
                          ;;signed div or mul cdo(chaange byte to quard) 
                          ;; cwd, cdq, cdo

            mov rax, [weight]
            mov rcx, 10
            mul rcx       ;; mul cx => rax / rcx ==> rdx:rax
            mov [weight], rax

          .div_1:  ;; rdx::rax

            mov rax, [arg]
            xor rdx, rdx  ;; unsigned div or mul need to xor rdx, rdx 

            mov rcx, [weight]
            div rcx        ;; div rm64 == rax:rdx, rax=quotient rdx=remainder

            dec byte[position]
            xor rcx, rcx
            mov cl, [position]

            lea rbx, [decimal + rcx]
            mov [tmp], rdx

          .div_2: ;; decrease by weight 10
            xor rdx, rdx
            mov rcx, 10
            mov rax, [weight]
            div rcx

          .div_3: ;; need quotient
            xor rdx, rdx
            mov rcx ,rax
            mov rax, [tmp]
            div rcx

          .set_digit:
            add rax, '0'
            mov [rbx], al, 
              cmp byte[cnt], 16
              jle .check_num

          .print:
            mov rax, 1
            mov rdi, 1
            mov rsi, sign
            mov rdx, 17
            syscall
            
    .epilog:
      mov rsp, rbp
      pop rbp
      ret
