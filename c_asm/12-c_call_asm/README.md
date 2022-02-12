# c call asm function
    clang -c main.c
    nasm -f elf64 message.asm

    clang -nopie main.o message.o -o main
    ld 

## main.c
```c
    // no need <stdio.h>

    void message(void);

    int main(){
      int x;
      for(x=0; x<5; x++){
        message();
      }
      return 0;
    }
```

## message.asm
```asm
    section .data
        str: db "Oh, no! This line repeates!", 0x_0A
        str_length equ $-str

        SYS_write equ  1;
        STDOUT    equ 1;

    section .bss

    section .text
        global message

        message:
            mov rax, SYS_write
            mov rdi, STDOUT
            mov rsi, str
            mov rdx, str_length
            syscall
            ret
