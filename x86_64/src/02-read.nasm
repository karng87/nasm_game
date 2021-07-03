;; https://www.youtube.com/watch?v=UQylMzFiWXc&list=PLjCrdTxPv8nCz28U3BTtl5jOFq-RtREaR&index=10&t=152s
section .data
        fname: db "tmp.txt",0
        msg: db "hello tmp file"
        msg_len: equ $-msg

section .bss
        fd: resq 1
        buffer: resb 30
    
section .text
        global main
        main:
                ;; read(const char *fname, flag, mod)
                ;;  2(*ptr, quad , quad)

            mov rax, 2
                ;; flag /usr/include/asm-generic/fcntl.h
                ;;    O_RD_ONLY   = 2^null
                ;;        0o_00 = 0b_0000_0000

                ;;    O_WR_ONLY   = 2^0
                ;;        0o_01 = 0b_0000_0001

                ;;    O_RD_WR     = 2^1
                ;;        0o_02 = 0b_0000_0010

                ;;    O_CREAT     = 2^6
                ;;      0o_100 = 0b_001_000_000 = 0b_0100_0000
                ;;        0x40 = 0b_0100_0000
                
                ;;    O_TRUNC= 2^10
                ;;      0o_1000 = 0b_001_000_000_000
                ;;        0x_200 = 0b_0010_0000_0000

                ;;    O_APPEND = 2^16
                ;;      0o_2000 = 0b_010_000_000_000
                ;;        0x_400 = 0b_0100_0000_0000
                ;;    O_PATH      = 2^21
                ;;    O_TMPFILE   = 2^22

            mov rdi, 0b_0000_0000_0011_0000_1000_0010_0100_0010

                ;; user: group :other
                ;;    x - 2^0
                ;;    w - 2^1
                ;;    r - 2^2

            mov rsi, 0b_000_111_101_101
            syscall

            push rax
              ;mov qword [fd], rax  ;; byte word dword qword
            mov rax, 1
            pop rdi 
              push rdi
              ;mov rdi, qword[fd]
            mov rsi, msg
            mov rdx, msg_len
            syscall

            mov rcx, 0
            pop rdi
          lp:
            push rcx
            xor rax, rax
            push rdi
            lea rsi, [buffer + rcx]
            xor rdx, rdx
            syscall
            pop rdi
            pop rcx
            cmp rax, 0
              jz end,
            inc rcx
            jmp lp

          end:
            mov rax, 1
            mov rdi, 1
            mov rsi, buffer
            mov rdx, 1 
            syscall

          end1:
            mov rax, 60
            mov rdi, 0
            syscall
