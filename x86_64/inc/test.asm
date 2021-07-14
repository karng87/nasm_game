;; rbx, r12 ~ r15
%include "x64_io.inc"
section .data
    var1: dq 0.2
    var2: dq 0.3
section .text
global main
main:
    finit
    fld qword[var1]
    fld qword[var2]
    fadd st0, st1

    call exit
