# GAS

## [[Digital Design]](https://www.youtube.com/watch?v=eJHmVlzH_9Q&list=PL7kkolCtIBKLukrBsEDwKRTE64JvaJDhM&index=1)

## [[ASM]](https://www.youtube.com/watch?v=lUbPUWtmVUU&t=170s)
    https://www.youtube.com/watch?v=lUbPUWtmVUU&t=219s

## [[MASM]](https://www.youtube.com/watch?v=5hikXYBOppU)

## dispalcement(base register, index register, scale)
    leaq (%rdi, %rdi,2), %rax => %rdi + %rdi x 2 = 3 x %rdi = %rax
    salq $2, %rax             => %rax x 2^2 = (3 x %rdi) x 2^2 = 12 x %rdi
       
## FLAGS ( https://www.youtube.com/watch?v=BIn6iyYIGio )
    CF => Carry\Borrow Flag(for unsigned)
        Extar bit is discarded
        Carry = 1 : Unsigned ADD is incorrect, but SUB is correct
        Carry = 0 : Unsigned ADD is correct, but SUB is incorrect
    OF => Overflow Flag(for signed)
        Positive + Positive = Negative
        Negative _ Negative = Positive

    SF => Sign Flag(for signed)
    ZF => Zero Flag (All zero = test condition)
        
    AF => Auxiliary Overflow Flag(by nible)

    compq A, B
      A - B  without setting destination
      CF set if carry out from most significant bit(used for unsigned comparisons)
      ZF set if a == b
      SF set if (a-b) < 0 (as sigend)
      OF set if two's-complement (signed) overflow
        ( a > 0 && b < 0 && ( a-b ) < 0 || ( a<0) && b > 0 && ( a-b ) > 0 
       
##  ABS
    0b_0011_1101 - %rdi ::arg1
    0b_0000_0000 - %rdx ::sarq $7, %arg1
    ---------------
    0b_0011_1101 - %rax => %rdi + %rdx ::leaq(%rid,%rdx), %rax
    ----------------
    0b_0000_0000 - %rdx => xorq %rdx, %rax
    0b_0011_1101 - %rax :: abs positive Z
    -------------------
    0b_0011_1101 - A ^ 0x_0000 = A


    0b_1101_0101  - %rdx negative Z => 0b_0010_1011 
    0b_1111_1111  - %rax = %rdx - 1
    ----------------
    0b_1101_0100  - %rax = rdx - 1
    0b_1111_1111  - %rdx ,,negative Z => 0b_0010_1011 
    --------------
    0b_0010_1011   - A ^ 0x_1111 = ~A


## arithmathic orperator
    addq  => +
    subq  => -
    imulq => *
    salq  => << shift arithmathic left quad
    sarq  => >> shift arithmathic right quad
    shrq  => >> shift right quad (logical)
        xorq  => ^
                  A ^ 0 => A
                  A ^ -1 => ~A
        andq  => &
        orq   => |
        incq  => ++
        decq  => --
        negq  => (-1) *
        notq  => ~


# gdb

## x(examine)
    x/option target
    x/xb => byte to hexadecimal
    x/2xb => 2 byte to hexadecimal

    x/xh => 2byte
    x/xw => 4byte
    x/xg => 8byte

    x/xg &var1
