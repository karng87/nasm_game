;; rbx, r12 ~ r15
%include "x64_io.inc"
section .data
    a: dq 3
    b: dq 4
section .bss
    h: resq 1
section .text
global main
main:
    finit
    fld qword [a]
    fmul qword [a]
    fld qword [b]
    fmul qword [b]
    fadd
    fsqrt
    fst qword[h]
    fwait

    call exit
