; nams -f elf64 safeinput.asm

;; arguments
;;    1st arg = rdi
;;    2nd arg = rsi
;;    3rd arg = rdx
;;    4rd arg = rcx
;;    5rd arg = r8
;;    6rd arg = r9

; safe input - read standard input up to n characters
;   terminate on newline or n-1 characters for null character

section .data
  newline   equ   0x0A  ; Unix newline, \n
  nullchar  equ   0x0   ; terminating string character
  STDIN     equ   0     ; stanadard input device
  SYS_read  equ   0     ; system call read character

section .bss
  maxchars  resq  1   ; storage for input max
                      ;; word             = 2byte = 8bit
                      ;; double word = dw = 4byte = 32bit
                      ;; quad = quad word = 8byte = 64bit

section .text
  ;; 1st arg => rdi = input buffer base address
  ;; 2nd arg => rsi = max characters

  ;; return value = rax = actual characters typed (minus the null)

  global safe_input

safe_input:
      mov rbx, rdi        ;; rbx = base address register
      mov [maxchars], rsi

      mov r12, 1

  .lp:
      mov rax, SYS_read ;; what action? rax read device
      mov rdi, STDIN    ;; where from? rdi 
      mov rsi, rbx      ;; where to address? rsi
      mov rdx, 1        ;; how many count? rdx 
      syscall

        cmp byte[rbx], newline
          je  safe_input_exit

      inc rbx
      inc r12
        cmp r12, [maxchars]
          jl .lp

safe_input_exit:
    mov byte[rbx], nullchar
    mov rax, r12
    dec rax
    ret

