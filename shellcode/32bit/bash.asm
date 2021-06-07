;;;;
; execve(const char * pathname, char * const v[], char * const e[])
;     v and e have to end with null ptr

; nasm -f elf32 bash.asm
; ld -m elf_i386 bash.o
; ld -m elf_x86_64 bash.o
; objdump -M intel -d bash
section .text
  global _start
  _start:
        xor eax, eax
        push eax                ;; "\0\0\0\0"
        push dword 0x68_73_2f_2f  ;; "//sh"
        push dword 0x6e_69_62_2f  ;; "/bin"
        mov ebx, esp      ;; arg1="bin//sh\0" ;; of execve(cmd,v,e)

        push eax      ;;NULL -> args[1] ;; 3rd arg of execve(cmd, v, e)
        push ebx      ;; = esp: "/bin//sh/\0\0\0\0 -> args[0] ;; 2nd arg of execve(cmd,v,e)
        mov ecx, esp  ;; arg2 = args[]
        mov al, 11  ;; syscall 11 = execve(32bit) 
                    ;; 64bit syscall 59

        int 0x80    ;; execve("/bin//sh", args["/bin//sh", NULL], NULL)
