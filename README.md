# nasm 

## registers
    
    | quad |  double word | word  | byte | meanning |
    | --- | --- | --- | --- | --- |
    | rax | eax | ax | ah + al | accumulator |
    | rbx | ebx | bx | bh + bl | base address |
    | rcx | ecx | cx | ch + cl | counter |
    | rdx | edx | dx | dh + dl | data |
    | rdi | edi | di |  | destination address index |
    | rsi | esi | si |  | source address index |


## call parameter


## x86_64
    rdi
    rsi
    rdx
    rcx
    r8
    r9
    stack

## x86
    caller stack
        push arg4 ; auto dec:  esp = esp - 2
        push arg3
        push arg2
        push arg1
        call func ;; auto push return address

    callee
        push ebp
        mov ebp, esp
            ; *[ebp+0] -> old ebp address
            ; *[ebp+2] -> return instruction address
            ; *[ebp+4] -> arg1
            ; *[ebp+6] -> arg2
            ; *[ebp+8] -> arg3
            ; *[ebp+10] -> arg4
        and esp, 0xffff_fff0

