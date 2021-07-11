section .bss
section .data
section .text
global _start
  _start:
    mov rdi, 0x0000_0000_0000_0000_0000
    call int2str
    mov rax, 60
    mov rdi, 0
    syscall
      
print_rdi:
    call int2str
    push rax
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 8
    syscall
    pop rax
    ret

int2str:
  push rdi

  .for:
    pop rdi
    test rdi, rdi
      jz .end
    push rdi
    and rdi, 0xf
    cmp rdi, 0xa
      jge .over_a
    add rdi, '0'
    jmp .next
  .over_a:
    add rdi, 55
  .next:
    call print_char

    mov sil, dil
    shl sil, 4
    pop rdi
    shr rdi, 4
    push rdi

    jmp .for
  .end:
    mov rax, rsi
    ret

print_char:
    push rdi
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    pop rdi
    ret
