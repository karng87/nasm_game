section
.data
  msg1: db "hello", 0xa
hex2int_stack:

        prolog:
          push rbp
          mov rbp, rsp

            .start:

                  mov rbx, [rdi]

                  mov byte[rbx], "H"
                  mov byte[rbx+1], "e"
                  mov byte[rbx+2], "l"
                  mov byte[rbx+3], "l"
                  mov byte[rbx+4], " "
                  mov byte[rbx+5], "w"
                  mov byte[rbx+6], "o"
                  mov byte[rbx+7], "r"
                  mov byte[rbx+9], 0xa

          epilog:
            mov rsp, rbp
            pop rbp

            ret

