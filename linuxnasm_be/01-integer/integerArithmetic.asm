bits 64

global IntAdd
global IntMul
global IntDiv

;; rdi, rsi, rdx, rcx, r8 , r9
section .text
;; extern "C" long int IAdd(long int a, long int b, long int c, long int d, long int e, long int f);
IntAdd:
      add rdi, rsi
      add rcx, rdx
      mov rax, r8
      add rax, r9
      add rcx, rdi
      add rax, rcx
      ret
;; int64_t IMul(int8_t a, int16_t b, int32_t c, int64_t d, int8_t e, int16_t f, int32_t g, int64_t h);
IntMul:
      movsx rdi, dil
      movsx rsi, si
      imul rdi, rsi
      movsxd rdx, edx
      imul rcx, rdx
      movsx r8, r8b
      movsx r9, r9w
      imul r8, r9
      movsxd rax, dword[rsp+8]
      imul rax, [rsp+16]
      imul rax, rdi
      imul rax, rcx
      imul rax, r8
      ret

;; extern "C" void IDiv(int64_t a, int64_t b, int64_t quo_rem_ab[2], int64_t c, int64_t d, int64_t quo_rem_cd[2]);

IntDiv:
      mov r10,rdx
        cmp rsi, 0
          je .rsi_zero
      mov rax, rdi
      cqo ;; rdx:rax is sign extend rcx cf)cwd cdq 
      idiv rsi
        jmp .result_1
    .rsi_zero:
      mov rax, -1
      mov rdx, -1
    .result_1:
      mov qword[r10], rax
      mov qword[r10+8], rdx
       cmp r8, 0
          je .r8_zero
      mov rax, rcx
      cqo
      idiv r8
        jmp .result_2

    .r8_zero:
      mov rax, -1
      mov rdx, -1

    .result_2:
      mov qword[r9], rax
      mov qword[r9+8], rdx
      ret
