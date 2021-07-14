;          1         2         3         4         5         6         7
;01234567890123456789012345678901234567890123456789012345678901234567890
;=======================================================================
;+---------------------------------------------------------------------+
;|                                                                     |
;|              Print floating-point number to stdout                  |
;|                                                                     |
;|   This example shows how to print double value from FPU register    |
;|   to stdout.                                                        |
;|                                                                     |
;|   This assembly program is equivalent to the C program below:       |
;|                                                                     |
;|   #include <stdio.h>                                                |
;|   int main(void)                                                    |
;|   {                                                                 |
;|       double sample = 2147483647.12345678;                          |
;|       printf("%.8f\n",sample);                                      |
;|       return 0;                                                     |
;|   }                                                                 |
;|                                                                     |
;|   The limitations of this example are the program cannot print      |
;|   9 to 16 decimal places, and cannot operate for double_sample      |
;|   value larger than 2^32. This program can only prints up to        |
;|   8 decimal places only.                                            |
;|                                                                     |
;|   However, the most accurate precision is up to 7 decimal places    |
;|   only. You will see the problem when using more than 7 decimal     |
;|   places in this program.                                           |
;|                                                                     |
;|                                decimal part                         |
;|                                      ^                              |
;|                                      |                              |
;|                                   +--+---+                          |
;|                                   |      |                          |
;|   Given double_sample: 2147483647.12345678                          |
;|                        |        |                                   |
;|                        +---+----+                                   |
;|                            |                                        |
;|                            V                                        |
;|                      integer part                                   |
;|                                                                     |
;|   the program will print the double_sample to stdout.               |
;|                                                                     |
;|   If you want to manually set the value of double_sample, make      |
;|   sure to set within this range:                                    |
;|                                                                     |
;|   -2147483648.000000000 <= double_sample <= 2147483647.99999999     |
;|                                                                     |
;|   ::IMPORTANT::                                                     |
;|                                                                     |
;|   Although if you set the double_sample to 2147483647.12345678,     |
;|   but the program will prints 2147483647.12345672 because           |
;|   of precision problems. FPU always operate in extended float,      |
;|   so the new value of double_sample when loaded into FPU is:        |
;|                                                                     |
;|   2147483647.1234567165374755859375                                 |
;|                                                                     |
;|   But, since we want to print only 8 decimal places, the FPU        |
;|   rounds to the nearest and becomes:                                |
;|                                                                     |
;|   2147483647.12345672                                               |
;|                                                                     |
;|                                                                     |
;| Use these commands to assemble this code:                           |
;|                                                                     |
;| $ nasm _start.asm -f elf32 -o _start.o                              |
;| $ ld _start.o -m elf_i386 -o exe                                    |
;|                                                                     |
;+---------------------------------------------------------------------+
;|       AUTHOR: Nik Mohamad Aizuddin bin Nik Azmi                     |
;|        EMAIL: nickaizuddin93@gmail.com                              |
;| DATE CREATED: 26/OCT/2014                                           |
;+---------------------------------------------------------------------+
;|     LANGUAGE: x86 Assembly Language                                 |
;|    ASSEMBLER: NASM                                                  |
;|       SYNTAX: Intel                                                 |
;| ARCHITECTURE: i386                                                  |
;|       KERNEL: Linux 32-bit                                          |
;|       FORMAT: ELF32                                                 |
;+---------------------------------------------------------------------+
;| REVISION HISTORY:                                                   |
;|                                                                     |
;|  Rev # |    Date     |                Description                   |
;| -------+-------------+--------------------------------------------- |
;|  0.9.0 | 27/OCT/2014 | First release.                               |
;|                                                                     |
;+---------------------------------------------------------------------+
;| Do whatever you want with this source code :)                       |
;+---------------------------------------------------------------------+
;=======================================================================

[bits 32] ;generate 32-bit codes
cpu 386   ;assemble instructions up to 386 instruction sets

;---- section uninitialized data ---------------------------------------
section .bss noexec write align=4

fpu_controlword:      resw 1 ;used for modifying fpu rounding control
integer_part:         resd 1 ;stores integer part of double
decimal_part:         resq 1 ;stores decimal part of double
temp:                 resq 1 ;general purpose memory

;---- section read only data -------------------------------------------
section .rdata noexec nowrite align=4

double_sample:        dq 2147483647.12345678
decimal_places:       dq 100000000           ;take 8 decimal places only
dot_character:        dd 2eH
newline_character:    dd 0aH

;---- section instruction codes ----------------------------------------
section .text exec nowrite align=16

global _start:
_start:

.step_1:
;+---------------------------------------------------------------------+
;| Get 2147483647 from 2147483647.12345678                             |
;|                                                                     |
;| Technique used:                                                     |
;| Convert double to integer and store to memory.                      |
;| The FPU will round the integer depends on RC bits.                  |
;| RC = truncate means the FPU don't round the integer.                |
;|                                                                     |
;| NOTE: Make sure to set FPU rounding control to truncate, by         |
;|       modifying its controlword value. Make sure bit 10 = 1 and     |
;|       bit 11 = 1. Ignore other bits, and DON'T TOUCH THEM! if you   |
;|       don't know what you are doing!                                |
;|                                                                     |
;|       See the table below about modifying control word:             |
;|                                                                     |
;|          +-----+                                                    |
;|   BIT  0 | IM  | --> Invalid operation Mask                         |
;|          +-----+                                                    |
;|   BIT  1 | DM  | --> Denormalized operand Mask                      |
;|          +-----+                                                    |
;|   BIT  2 | ZM  | --> Zero divide Mask                               |
;|          +-----+                                                    |
;|   BIT  3 | OM  | --> Overflow Mask                                  |
;|          +-----+                                                    |
;|   BIT  4 | UM  | --> Underflow Mask                                 |
;|          +-----+                                                    |
;|   BIT  5 | PM  | --> Precision Mask                                 |
;|          +-----+                                                    |
;|   BIT  6 |     |                                                    |
;|          +-----+                                                    |
;|   BIT  7 | IEM | --> Interrupt Enable Mask                          |
;|          +-----+                                                    |
;|   BIT  8 | PC  | --> Precision Control                              |
;|   BIT  9 |     |                                                    |
;|          +-----+                                                    |
;|   BIT 10 | RC  | --> Rounding Control, 11B = truncate               |
;|   BIT 11 |     |                                                    |
;|          +-----+                                                    |
;|   BIT 12 | IC  | --> Infinity control                               |
;|          +-----+                                                    |
;|   BIT 13 |     |                                                    |
;|          +-----+                                                    |
;|   BIT 14 |     |                                                    |
;|          +-----+                                                    |
;|   BIT 15 |     |                                                    |
;|          +-----+                                                    |
;|                                                                     |
;| reference: http://www.website.masmforum.com/tutorials/fptute/       |
;|            fpuchap1.htm                                             |
;+---------------------------------------------------------------------+

    finit                         ;initialize fpu

    fstcw  word [fpu_controlword] ;get fpu controlword
    mov    ax, [fpu_controlword]
    or     eax, 110000000000B     ;rounding control := truncate
    mov    [fpu_controlword], ax
    fldcw  word [fpu_controlword] ;use modified fpu controlword

    fld    qword [double_sample]  ;st0 := double_sample
    fist   dword [integer_part]   ;store int from real

.step_2:
;+---------------------------------------------------------------------+
;| Get 0.12345678 from 2147483647.12345678                             |
;|                                                                     |
;| Technique used:                                                     |
;| 0.12345678 = 2147483647.12345678 - 2147483647.00000000              |
;+---------------------------------------------------------------------+

    finit                        ;initialize fpu
    fld    qword [double_sample] ;push double_sample to st1
    fild   dword [integer_part]  ;push integer_part to st0
    fsub                         ;st0 := st1 - st0
    fstp   qword [temp]          ;temporarily store subtract result

;+---------------------------------------------------------------------+
;| Convert 0.12345678 to 12345678                                      |
;|                                                                     |
;| Technique used:                                                     |
;| Multipy 0.12345678 with 8. But, if you multiply it with 7, you'll   |
;| get 7 decimal places only.                                          |
;|                                                                     |
;| If the program is set to 6 decimal places, the program will convert |
;| 0.12345678 to 123457.                                               |
;+---------------------------------------------------------------------+

    finit                         ;reset fpu
    fld    qword [temp]           ;st1 := temp
    fild   dword [decimal_places] ;st0 := decimal_places
    fmul                          ;st0 := st1 * st0
    fistp  qword [decimal_part]   ;save decimal_part


;+---------------------------------------------------------------------+
;| Print 2147483647                                                    |
;+---------------------------------------------------------------------+

    sub    esp, 8              ;reserve 8 bytes
    mov    eax, [integer_part] ;get integer_part
    mov    ebx, 1              ;flag=1 (signed int)
    mov    [esp    ], eax      ;arg1: integer_part
    mov    [esp + 4], ebx      ;arg2: flag=1 (signed int)
    call   print_int2stdout
    add    esp, 8              ;restore 8 bytes

;+---------------------------------------------------------------------+
;| Print "dot"                                                         |
;+---------------------------------------------------------------------+

    mov    eax, 04H           ;systemcall write
    mov    ebx, 01H           ;write to stdout
    mov    ecx, dot_character ;src := address dot_character
    mov    edx, 1             ;len := 1
    int    80H

;+---------------------------------------------------------------------+
;| Print 12345678                                                      |
;|                                                                     |
;| If the value is -12345678, first we have to convert the             |
;| two's complement form to get the actual value.                      |
;+---------------------------------------------------------------------+

    sub    esp, 8              ;reserve 8 bytes
    mov    eax, [decimal_part] ;get decimal_part

    mov    ebx, eax            ;if negative
    and    ebx, 0x80000000
    cmp    ebx, 0
    je     .positive

.negative:
    not    eax                 ;decode two's complement
    add    eax, 1

.positive:
    mov    ebx, 0              ;flag=0 (unsigned int)
    mov    [esp    ], eax      ;arg1: decimal_part
    mov    [esp + 4], ebx      ;arg2: flag=0 (unsigned int)

    call   print_int2stdout
    add    esp, 8              ;restore 8 bytes

;+---------------------------------------------------------------------+
;| Print newline                                                       |
;+---------------------------------------------------------------------+

    mov    eax, 04H               ;systemcall write
    mov    ebx, 01H               ;write to stdout
    mov    ecx, newline_character ;src := address newline_character
    mov    edx, 1                 ;len := 1
    int    80H

.exit:
    mov    eax, 01H ;systemcall exit
    xor    ebx, ebx ;return 0
    int    80H

;          1         2         3         4         5         6         7
;01234567890123456789012345678901234567890123456789012345678901234567890
;=======================================================================
;+---------------------------------------------------------------------+
;| NAME:                                                               |
;|                                                                     |
;| print_int2stdout -- Print signed or unsigned int to stdout.         |
;|                                                                     |
;+---------------------------------------------------------------------+
;| PASCAL SPECIFICATION:                                               |
;|                                                                     |
;| procedure print_int2stdout(integer_x: Longword, flag: Longword )    |
;|                                                                     |
;+---------------------------------------------------------------------+
;| PARAMETERS:                                                         |
;|                                                                     |
;|                                                                     |
;+---------------------------------------------------------------------+
;| RETURNS:                                                            |
;|                                                                     |
;|                                                                     |
;+---------------------------------------------------------------------+
;| DESCRIPTION:                                                        |
;|                                                                     |
;|                                                                     |
;+---------------------------------------------------------------------+
;=======================================================================
print_int2stdout:

.setup_stackframe:
    sub    esp, 4     ;reserve 4 bytes
    mov    [esp], ebp ;store ebp to stack
    mov    ebp, esp   ;store stack pointer to ebp

.get_arguments:
    add    ebp, 8         ;+8 offset, to get arguments
    mov    eax, [ebp    ] ;get integer_x
    mov    ebx, [ebp + 4] ;get flag

.set_localvariables:
    sub    esp, 52             ;reserve 52 bytes
    mov    [esp     ], eax     ;integer_x
    mov    [esp +  4], ebx     ;flag
    mov    dword [esp +  8], 0 ;integer_x_len
    mov    dword [esp + 12], 0 ;integer_x_quo
    mov    dword [esp + 16], 0 ;integer_x_rem
    mov    dword [esp + 20], 0 ;decimal_x_b0
    mov    dword [esp + 24], 0 ;decimal_x_b1
    mov    dword [esp + 28], 0 ;ascii_char
    mov    dword [esp + 32], 0 ;ascii_x_b0
    mov    dword [esp + 36], 0 ;ascii_x_b1
    mov    dword [esp + 40], 0 ;ascii_x_b2
    mov    dword [esp + 44], 0 ;ascii_x_len
    mov    dword [esp + 48], 0 ;is_negative

;+---------------------------------------------------------------------+
;|       integer_x_len := calculate_integer_length(integer_x, flag);   |
;+---------------------------------------------------------------------+

; integer_x_len := calculate_integer_length(integer_x, flag)
;-----------------------------------------------------------------------
    sub    esp, 8                   ;reserve 8 bytes
    mov    eax, [esp + 8 + 0]       ;get integer_x
    mov    ebx, [esp + 8 + 4]       ;get flag
    mov    [esp    ], eax           ;arg1: integer_x
    mov    [esp + 4], ebx           ;arg2: flag
    call   calculate_integer_length
    add    esp, 8                   ;restore 8 bytes
    mov    [esp + 8], eax           ;save return value

.is_signed_or_unsigned_int:
;+---------------------------------------------------------------------+
;|       If flag = 1 Then                                              |
;|           If (integer_x & 0x80000000) <> 0 Then                     |
;|               integer_x := (not integer_x) + 1;                     |
;|               is_negative := 1;                                     |
;+---------------------------------------------------------------------+

; If flag = 1 Then continue to .signed_int
;-----------------------------------------------------------------------
    mov    eax, [esp + 4] ;eax := flag
    cmp    eax, 1         ;compare eax with 1
    jne    .unsigned_int  ;if <>, goto .unsigned_int

.signed_int:
; If (integer_x & 0x80000000) <> 0 Then continue to .negative_value
;-----------------------------------------------------------------------
    mov    eax, [esp]      ;eax := integer_x
    and    eax, 0x80000000 ;eax := eax and 0x80000000
    cmp    eax, 0          ;compare eax with 0
    je     .positive_value ;if =, goto .positive_value

.negative_value:
; integer_x := (not integer_x) + 1
;----------------------------------------------------------------------
    mov    eax, [esp] ;eax := integer_x
    not    eax        ;eax := not eax
    add    eax, 1     ;eax := eax + 1
    mov    [esp], eax ;integer_x := eax

; is_negative := 1
;----------------------------------------------------------------------
    mov    eax, 1          ;eax := 1
    mov    [esp + 48], eax ;is_negative := eax

.positive_value:
.unsigned_int:

;+---------------------------------------------------------------------+
;|       If integer_x_len > 8 Then                                     |
;|           integer_x_quo := integer_x / 100000000;                   |
;|           integer_x_rem := remainder from the division;             |
;|           decimal_x_b0 := formula_hex2dec(integer_x_rem);           |
;|           decimal_x_b1 := formula_hex2dec(integer_x_quo);           |
;|           write_dec2string(@decimal_x_b0, 2, @ascii_x_b0,           |
;|               @ascii_x_len);                                        |
;+---------------------------------------------------------------------+

; If integer_x_len > 8 Then continue to .more_than_8
;-----------------------------------------------------------------------
    mov    eax, [esp + 8] ;eax := integer_x_len
    cmp    eax, 8         ;compare eax with 8
    jbe    .less_than_8   ;if <=, goto .less_than_8

.more_than_8:
; integer_x_quo := integer_x / 100000000
;-----------------------------------------------------------------------
    mov    eax, [esp]      ;eax := integer_x
    mov    ebx, 100000000  ;ebx := 100000000
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    [esp + 12], eax ;integer_x_quo := eax

; integer_x_rem := remainder from the division
;-----------------------------------------------------------------------
    mov    [esp + 16], edx ;integer_x_rem := edx

; decimal_x_b0 := formula_hex2dec(integer_x_rem)
;-----------------------------------------------------------------------
    sub    esp, 4              ;reserve 4 bytes
    mov    eax, [esp + 4 + 16] ;get integer_x_rem
    mov    [esp], eax          ;arg1: integer_x_rem
    call   formula_hex2dec
    add    esp, 4              ;restore 4 bytes
    mov    [esp + 20], eax     ;save return value

; decimal_x_b1 := formula_hex2dec(integer_x_quo)
;-----------------------------------------------------------------------
    sub    esp, 4              ;reserve 4 bytes
    mov    eax, [esp + 4 + 12] ;get integer_x_quo
    mov    [esp], eax          ;arg1: integer_x_quo
    call   formula_hex2dec
    add    esp, 4              ;restore 4 bytes
    mov    [esp + 24], eax     ;save return value

; write_dec2string(@decimal_x_b0, 2, @ascii_x_b0, @ascii_x_len)
;-----------------------------------------------------------------------
    sub    esp, 16          ;reserve 16 bytes
    mov    eax, esp
    add    eax, (16+20)     ;get @decimal_x_b0
    mov    ebx, 2           ;get number of blocks
    mov    ecx, esp
    add    ecx, (16+32)     ;get @ascii_x_b0
    mov    edx, esp
    add    edx, (16+44)     ;get @ascii_x_len
    mov    [esp     ], eax  ;arg1: @decimal_x_b0
    mov    [esp +  4], ebx  ;arg2: num_of_blocks
    mov    [esp +  8], ecx  ;arg3: @ascii_x_b0
    mov    [esp + 12], edx  ;arg4: @ascii_x_len
    call   write_dec2string
    add    esp, 16          ;restore 16 bytes

; skip .less_than_8
;-----------------------------------------------------------------------
    jmp    .print_value

.less_than_8:
;+---------------------------------------------------------------------+
;|       Else                                                          |
;|           decimal_x_b0 := formula_hex2dec(integer_x);               |
;|           write_dec2string(@decimal_x_b0, 1, @ascii_x_b0,           |
;|               @ascii_x_len);                                        |
;+---------------------------------------------------------------------+

; decimal_x_b0 := formula_hex2dec(integer_x)
;-----------------------------------------------------------------------
    sub    esp, 4             ;reserve 4 bytes
    mov    eax, [esp + 4 + 0] ;get integer_x
    mov    [esp], eax         ;arg1: integer_x
    call   formula_hex2dec
    add    esp, 4             ;restore 4 bytes
    mov    [esp + 20], eax    ;save return value

; write_dec2string(@decimal_x_b0, 1, @ascii_x_b0, @ascii_x_len)
;-----------------------------------------------------------------------
    sub    esp, 16          ;reserve 16 bytes
    mov    eax, esp
    add    eax, (16+20)     ;get @decimal_x_b0
    mov    ebx, 1           ;get number of blocks
    mov    ecx, esp
    add    ecx, (16+32)     ;get @ascii_x_b0
    mov    edx, esp
    add    edx, (16+44)     ;get @ascii_x_len
    mov    [esp     ], eax  ;arg1: @decimal_x_b0
    mov    [esp +  4], ebx  ;arg2: num_of_blocks
    mov    [esp +  8], ecx  ;arg3: @ascii_x_b0
    mov    [esp + 12], edx  ;arg4: @ascii_x_len
    call   write_dec2string
    add    esp, 16          ;restore 16 bytes

.print_value:
;+---------------------------------------------------------------------+
;|       If is_negative = 1 Then                                       |
;|           ascii_char := 0x2d;                                       |
;|           Write(stdout, @ascii_char, 1);                            |
;|                                                                     |
;|       Write(stdout, @ascii_x_b0, ascii_x_len);                      |
;|                                                                     |
;|       ascii_char := 0x0a;                                           |
;|       Write(stdout, @ascii_char, 1);                                |
;+---------------------------------------------------------------------+

.is_print_negative_symbol:
; If is_negative = 1 Then continue below
;-----------------------------------------------------------------------
    mov    eax, [esp + 48]  ;eax := is_negative
    cmp    eax, 1           ;compare eax with 1
    jne    .print_the_value ;if <>, goto .print_the_value

.print_negative_symbol:
; ascii_char := 0x2d;
; Write(stdout, @ascii_char, 1);
;-----------------------------------------------------------------------
    mov    eax, 0x2d       ;eax := 0x2d
    mov    [esp + 28], eax ;ascii_char := eax
    mov    eax, 0x04       ;systemcall write
    mov    ebx, 0x01       ;write to stdout
    mov    ecx, esp
    add    ecx, 28         ;@ascii_char
    mov    edx, 1          ;print 1 character
    int    0x80

.print_the_value:
; Write(stdout, @ascii_x_b0, ascii_x_len);
;-----------------------------------------------------------------------
    mov    eax, 0x04       ;systecmcall write
    mov    ebx, 0x01       ;write to stdout
    mov    ecx, esp
    add    ecx, 32         ;@ascii_x_b0
    mov    edx, [esp + 44] ;ascii_x_len
    int    0x80

.return:

.clean_stackframe:
    sub    ebp, 8     ;-8 offset
    mov    esp, ebp   ;restore esp to its initial value
    mov    ebp, [esp] ;restore ebp to its initial value
    add    esp, 4     ;restore 4 bytes

    ret

;          1         2         3         4         5         6         7
;01234567890123456789012345678901234567890123456789012345678901234567890
;=======================================================================
;+---------------------------------------------------------------------+
;| NAME:                                                               |
;|                                                                     |
;| calculate_integer_length -- Find the number of digits               |
;|                             from an integer number.                 |
;|                                                                     |
;+---------------------------------------------------------------------+
;| PASCAL SPECIFICATION:                                               |
;|                                                                     |
;| function calculate_integer_length(integer_x: Longword,              |
;|                                   flag: Longword ): Longword;       |
;|                                                                     |
;+---------------------------------------------------------------------+
;| PARAMETERS:                                                         |
;|                                                                     |
;| integer_x                                                           |
;|     The integer number, can be data type of Longword or Longint.    |
;| flag                                                                |
;|     Specify whether the integer_x is Longword or Longint            |
;|                                                                     |
;+---------------------------------------------------------------------+
;| RETURNS:                                                            |
;|                                                                     |
;| Length of integer, which is the number of digits from integer_x.    |
;|                                                                     |
;+---------------------------------------------------------------------+
;| DESCRIPTION:                                                        |
;|                                                                     |
;| The specifications of the flag value are as follows:                |
;|                                                                     |
;| flag = 0b00000000000000000000000000000000                           |
;|     The integer_x is Longword (unsigned int 32-bit)                 |
;| flag = 0b00000000000000000000000000000001                           |
;|     The integer_x is Longint (signed int 32-bit)                    |
;|                                                                     |
;+---------------------------------------------------------------------+
;=======================================================================
calculate_integer_length:

.setup_stackframe:
    sub    esp, 4     ;reserve 4 bytes of stack
    mov    [esp], ebp ;save ebp to stack memory
    mov    ebp, esp   ;save current stack ptr to ebp

.get_arguments:
    add    ebp, 8         ;+8 bytes offsets to ebp, to get arguments
    mov    eax, [ebp    ] ;get integer_x
    mov    ebx, [ebp + 4] ;get flag

.set_localvariables:
    sub    esp, 16             ;reserve 16 bytes of stack
    mov    [esp     ], eax     ;integer_x
    mov    [esp +  4], ebx     ;flag
    mov    dword [esp +  8], 0 ;num_of_digits

.check_signvalue:

;+---------------------------------------------------------------------+
;|       { If flag = 1, that means the integer_x is long signed int.   |
;|         So, we have to check its sign value to determine whether    |
;|         it is a positive or negative number.                        |
;|                                                                     |
;|         If the integer_x is negative number, we have to find the    |
;|         value from its two's complement form.                       |
;|                                                                     |
;|         If the integer_x is positive number, no need to find the    |
;|         value from its two's complement form.                       |
;|                                                                     |
;|         Otherwise if the flag = 0, skip these instructions. }       |
;|                                                                     |
;|       { Check whether integer_x is signed or unsigned int }         |
;|       IF flag = 1 THEN                                              |
;|           { If integer_x is signed, check its sign value }          |
;|           IF (integer_x and 0x80000000) <> 0 THEN                   |
;|               { If integer_x is negative }                          |
;|               { Invert all bits }                                   |
;|               integer_x := not integer_x;                           |
;|               { Add 1 }                                             |
;|               integer_x := integer_x + 1;                           |
;+---------------------------------------------------------------------+

; if flag = 1 then continue to .integer_x_is_signed
;-----------------------------------------------------------------------
    mov    eax, [esp + 4]         ;eax := flag
    cmp    eax, 1                 ;compare eax with 1
    jne    .integer_x_is_unsigned ;if <>, goto .integer_x_is_unsigned
                                  ;otherwise, continue below

.integer_x_is_signed:

; if integer_x & 0x80000000 <> 0 then continue to .integer_x_is_negative
;-----------------------------------------------------------------------
    mov    eax, [esp]             ;eax := integer_x
    and    eax, 0x80000000        ;eax := eax and 0x80000000
    cmp    eax, 0                 ;compare eax with 1
    je     .integer_x_is_positive ;if =, goto .integer_x_is_positive
                                  ;otherwise, continue below

.integer_x_is_negative:

; integer_x := not integer_x
;-----------------------------------------------------------------------
    mov    eax, [esp] ;eax := integer_x
    not    eax        ;eax := not eax
    mov    [esp], eax ;integer_x := eax

; integer_x := integer_x + 1
;-----------------------------------------------------------------------
    mov    eax, [esp] ;eax := integer_x
    add    eax, 1     ;eax := eax + 1
    mov    [esp], eax ;integer_x := eax

.integer_x_is_positive:
.integer_x_is_unsigned:

.find_number_of_digits:

;+---------------------------------------------------------------------+
;|       { The instructions below will find the number of digits       |
;|         from integer_x. }                                           |
;|                                                                     |
;|       IF integer_x < 10 THEN                                        |
;|           num_of_digits := 1;                                       |
;|       ELSE IF integer_x < 100 THEN                                  |
;|           num_of_digits := 2;                                       |
;|       ELSE IF integer_x < 1000 THEN                                 |
;|           num_of_digits := 3;                                       |
;|       ELSE IF integer_x < 10000 THEN                                |
;|           num_of_digits := 4;                                       |
;|       ELSE IF integer_x < 100000 THEN                               |
;|           num_of_digits := 5;                                       |
;|       ELSE IF integer_x < 1000000 THEN                              |
;|           num_of_digits := 6;                                       |
;|       ELSE IF integer_x < 10000000 THEN                             |
;|           num_of_digits := 7;                                       |
;|       ELSE IF integer_x < 100000000 THEN                            |
;|           num_of_digits := 8;                                       |
;|       ELSE IF integer_x < 1000000000 THEN                           |
;|           num_of_digits := 9;                                       |
;|       ELSE                                                          |
;|           num_of_digits := 10;                                      |
;+---------------------------------------------------------------------+

; compares
;-----------------------------------------------------------------------
    mov    eax, [esp]             ;eax := integer_x
    cmp    eax, 10                ;compare eax with 10
    jb     .jumper_10             ;if <, goto .less_than_10
    cmp    eax, 100               ;compare eax with 100
    jb     .jumper_100            ;if <, goto .less_than_100
    cmp    eax, 1000              ;compare eax with 1000
    jb     .jumper_1000           ;if <, goto .less_than_1000
    cmp    eax, 10000             ;compare eax with 10000
    jb     .jumper_10000          ;if <, goto .less_than_10000
    cmp    eax, 100000            ;compare eax with 100000
    jb     .jumper_100000         ;if <, goto .less_than_100000
    cmp    eax, 1000000           ;compare eax with 1000000
    jb     .jumper_1000000        ;if <, goto .less_than_1000000
    cmp    eax, 10000000          ;compare eax with 10000000
    jb     .jumper_10000000       ;if <, goto .less_than_10000000
    cmp    eax, 100000000         ;compare eax with 100000000
    jb     .jumper_100000000      ;if <, goto .less_than_100000000
    cmp    eax, 1000000000        ;compare eax with 1000000000
    jb     .jumper_1000000000     ;if <, goto .less_than_1000000000
    jmp    .less_than_10000000000 ;else, goto .less_than_10000000000

; conditional jump cannot jump more than 128 bytes.
;-----------------------------------------------------------------------
.jumper_10:
    jmp    .less_than_10
.jumper_100:
    jmp    .less_than_100
.jumper_1000:
    jmp    .less_than_1000
.jumper_10000:
    jmp    .less_than_10000
.jumper_100000:
    jmp    .less_than_100000
.jumper_1000000:
    jmp    .less_than_1000000
.jumper_10000000:
    jmp    .less_than_10000000
.jumper_100000000:
    jmp    .less_than_100000000
.jumper_1000000000:
    jmp    .less_than_1000000000

.less_than_10:
; num_of_digits := 1
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 1  ;num_of_digits := 1
    jmp    .endcondition       ;goto .endcondition

.less_than_100:
;     num_of_digits := 2
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 2  ;num_of_digits := 2
    jmp    .endcondition       ;goto .endcondition

.less_than_1000:
;     num_of_digits := 3
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 3  ;num_of_digits := 3
    jmp    .endcondition       ;goto .endcondition

.less_than_10000:
;     num_of_digits := 4
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 4  ;num_of_digits := 4
    jmp    .endcondition       ;goto .endcondition

.less_than_100000:
;     num_of_digits := 5
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 5  ;num_of_digits := 5
    jmp    .endcondition       ;goto .endcondition

.less_than_1000000:
;     num_of_digits := 6
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 6  ;num_of_digits := 6
    jmp    .endcondition       ;goto .endcondition

.less_than_10000000:
;     num_of_digits := 7
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 7  ;num_of_digits := 7
    jmp    .endcondition       ;goto .endcondition

.less_than_100000000:
;     num_of_digits := 8
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 8  ;num_of_digits := 8
    jmp    .endcondition       ;goto .endcondition

.less_than_1000000000:
;     num_of_digits := 9
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 9  ;num_of_digits := 9
    jmp    .endcondition       ;goto .endcondition

.less_than_10000000000:
;     num_of_digits := 10
;-----------------------------------------------------------------------
    mov    dword [esp + 8], 10  ;num_of_digits := 10

.endcondition:

.return:
    mov    eax, [esp + 8] ;eax := num_of_digits

.clean_stackframe:
    sub    ebp, 8     ;-8 bytes offsets to ebp
    mov    esp, ebp   ;restore stack ptr to its initial value
    mov    ebp, [esp] ;restore ebp to its initial value
    add    esp, 4     ;restore 4 bytes of stack

    ret

;          1         2         3         4         5         6         7
;01234567890123456789012345678901234567890123456789012345678901234567890
;=======================================================================
;+---------------------------------------------------------------------+
;| NAME:                                                               |
;|                                                                     |
;| formula_hex2dec -- Convert hexadecimal number to decimal number.    |
;|                                                                     |
;+---------------------------------------------------------------------+
;| PASCAL SPECIFICATION:                                               |
;|                                                                     |
;| function formula_hex2dec( hexadecimal_num: Longword ): Longword;    |
;|                                                                     |
;+---------------------------------------------------------------------+
;| PARAMETERS:                                                         |
;|                                                                     |
;| hexadecimal_num                                                     |
;|     The hexadecimal number, can be data type of Longword or Longint.|
;|                                                                     |
;+---------------------------------------------------------------------+
;| RETURNS:                                                            |
;|                                                                     |
;| decimal number                                                      |
;|                                                                     |
;+---------------------------------------------------------------------+
;| DESCRIPTION:                                                        |
;|                                                                     |
;| Converts 0x00bd0c32 to 0x12389426.                                  |
;|                                                                     |
;+---------------------------------------------------------------------+
;=======================================================================
formula_hex2dec:  

.setup_stackframe:
    sub    esp, 4     ;reserve 4 bytes to store ebp value
    mov    [esp], ebp ;store ebp to stack
    mov    ebp, esp   ;store current stack pointer to ebp

.get_arguments:
    add    ebp, 8     ;+8 offsets to ebp, to get arguments
    mov    eax, [ebp] ;hexadecimal_num

.setup_localvariables:
    sub    esp, 80             ;reserve 80 bytes of stack
    mov    [esp     ], eax     ;hexadecimal_num
    mov    dword [esp +  4], 0 ;decimal_num
    mov    dword [esp +  8], 0 ;A
    mov    dword [esp + 12], 0 ;B
    mov    dword [esp + 16], 0 ;C
    mov    dword [esp + 20], 0 ;D
    mov    dword [esp + 24], 0 ;E
    mov    dword [esp + 28], 0 ;F
    mov    dword [esp + 32], 0 ;G
    mov    dword [esp + 36], 0 ;H
    mov    dword [esp + 40], 0 ;I
    mov    dword [esp + 44], 0 ;J
    mov    dword [esp + 48], 0 ;K
    mov    dword [esp + 52], 0 ;L
    mov    dword [esp + 56], 0 ;M
    mov    dword [esp + 60], 0 ;N
    mov    dword [esp + 64], 0 ;O
    mov    dword [esp + 68], 0 ;P
    mov    dword [esp + 72], 0 ;Q
    mov    dword [esp + 76], 0 ;R

.begin_formula_hex2dec:  

;+---------------------------------------------------------------------+
;|       A := (hexadecimal_num / 1000000000);                          |
;|       B := 16 * A;                                                  |
;|       C := (hexadecimal_num / 100000000) + B;                       |
;|       D := 16 * C;                                                  |
;|       E := (hexadecimal_num / 10000000) + D;                        |
;|       F := 16 * E;                                                  |
;|       G := (hexadecimal_num / 1000000) + F;                         |
;|       H := 16 * G;                                                  |
;|       I := (hexadecimal_num / 100000) + H;                          |
;|       J := 16 * I;                                                  |
;|       K := (hexadecimal_num / 10000) + J;                           |
;|       L := 16 * K;                                                  |
;|       M := (hexadecimal_num / 1000) + L;                            |
;|       N := 16 * M;                                                  |
;|       O := (hexadecimal_num / 100) + N;                             |
;|       P := 16 * O;                                                  |
;|       Q := (hexadecimal_num / 10) + P;                              |
;|       R := 6 * Q;                                                   |
;|       decimal_num := hexadecimal_num + R;                           |
;+---------------------------------------------------------------------+

; A := (hexadecimal_num / 1000000000)
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecimal_num
    mov    ebx, 1000000000 ;ebx := 1000000000
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    [esp +  8], eax ;A := eax

; B := 16 * A
;-----------------------------------------------------------------------
    mov    eax, [esp +  8] ;eax := A
    mov    ebx, 16         ;ebx := 16
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    [esp + 12], eax ;B := eax

; C := (hexadecimal_num / 100000000) + B
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecmal_num
    mov    ebx, 100000000  ;ebx := 100000000
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    ebx, [esp + 12] ;ebx := B
    add    eax, ebx        ;eax := eax + ebx
    mov    [esp + 16], eax ;C := eax

; D := 16 * C
;-----------------------------------------------------------------------
    mov    eax, [esp + 16] ;eax := C
    mov    ebx, 16         ;ebx := 16
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    [esp + 20], eax ;D := eax

; E := (hexadecimal_num / 10000000) + D
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecimal_num
    mov    ebx, 10000000   ;ebx := 10000000
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    ebx, [esp + 20] ;ebx := D
    add    eax, ebx        ;eax := eax + ebx
    mov    [esp + 24], eax ;E := eax

; F := 16 * E
;-----------------------------------------------------------------------
    mov    eax, [esp + 24] ;eax := E
    mov    ebx, 16         ;ebx := 16
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    [esp + 28], eax ;F := eax

; G := (hexadecimal_num / 1000000) + F
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecimal_num
    mov    ebx, 1000000    ;ebx := 1000000
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    ebx, [esp + 28] ;ebx := F
    add    eax, ebx        ;eax := eax + ebx
    mov    [esp + 32], eax ;G := eax

; H := 16 * G
;-----------------------------------------------------------------------
    mov    eax, [esp + 32] ;eax := G
    mov    ebx, 16         ;ebx := 16
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    [esp + 36], eax ;H := eax

; I := (hexadecimal_num / 100000) + H
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecimal_num
    mov    ebx, 100000     ;ebx := 100000
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    ebx, [esp + 36] ;ebx := H
    add    eax, ebx        ;eax := eax + ebx
    mov    [esp + 40], eax ;I := eax

; J := 16 * I
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := I
    mov    ebx, 16         ;ebx := 16
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    [esp + 44], eax ;J := eax

; K := (hexadecimal_num / 10000) + J
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecimal_num
    mov    ebx, 10000      ;ebx := 10000
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    ebx, [esp + 44] ;ebx := J
    add    eax, ebx        ;eax := eax + ebx
    mov    [esp + 48], eax ;K := eax

; L := 16 * K
;-----------------------------------------------------------------------
    mov    eax, [esp + 48] ;eax := K
    mov    ebx, 16         ;ebx := 16
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    [esp + 52], eax ;L := eax

; M := (hexadecimal_num / 1000) + L
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecimal_num
    mov    ebx, 1000       ;ebx := 1000
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    ebx, [esp + 52] ;ebx := L
    add    eax, ebx        ;eax := eax + ebx
    mov    [esp + 56], eax ;M := eax

; N := 16 * M
;-----------------------------------------------------------------------
    mov    eax, [esp + 56] ;eax := M
    mov    ebx, 16         ;ebx := 16
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    [esp + 60], eax ;N := eax

; O := (hexadecimal_num / 100) + N
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecimal_num
    mov    ebx, 100        ;ebx := 100
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    ebx, [esp + 60] ;ebx := N
    add    eax, ebx        ;eax := eax + ebx
    mov    [esp + 64], eax ;O := eax

; P := 16 * O
;-----------------------------------------------------------------------
    mov    eax, [esp + 64] ;eax := O
    mov    ebx, 16         ;ebx := 16
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    [esp + 68], eax ;P := eax

; Q := (hexadecimal_num / 10) + P
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecimal_num
    mov    ebx, 10         ;ebx := 10
    xor    edx, edx        ;edx := 0
    div    ebx             ;eax := eax / ebx
    mov    ebx, [esp + 68] ;ebx := P
    add    eax, ebx        ;eax := eax + ebx
    mov    [esp + 72], eax ;Q := eax

; R := 6 * Q
;-----------------------------------------------------------------------
    mov    eax, [esp + 72] ;eax := Q
    mov    ebx, 6          ;ebx := 6
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    [esp + 76], eax ;R := eax

; decimal_num := hexadecimal_num + R
;-----------------------------------------------------------------------
    mov    eax, [esp     ] ;eax := hexadecimal_num
    mov    ebx, [esp + 76] ;ebx := R
    add    eax, ebx        ;eax := eax + ebx
    mov    [esp +  4], eax ;decimal_num := eax

.return:
    mov    eax, [esp + 4] ;eax := decimal_num

.clean_stackframe:
    sub    ebp, 8     ;-8 offsets to ebp, to get initial esp value
    mov    esp, ebp   ;restore stack pointer to its initial value
    mov    ebp, [esp] ;restore ebp to its initial value
    add    esp, 4     ;restore 4 bytes of stack memory

    ret

;          1         2         3         4         5         6         7
;01234567890123456789012345678901234567890123456789012345678901234567890
;=======================================================================
;+---------------------------------------------------------------------+
;| NAME:                                                               |
;|                                                                     |
;| write_dec2string -- Fill the string with the decimal number.        |
;|                                                                     |
;+---------------------------------------------------------------------+
;| PASCAL SPECIFICATION:                                               |
;|                                                                     |
;| procedure write_dec2string(decimal_x_ptr^: Longword,                |
;|                            num_of_blocks: Longword,                 |
;|                            ascii_x_ptr^: Longword,                  |
;|                            ascii_x_len_ptr^: Longword)              |
;|                                                                     |
;+---------------------------------------------------------------------+
;| PARAMETERS:                                                         |
;|                                                                     |
;| decimal_x_ptr                                                       |
;|     The address to decimal number block 0.                          |
;| num_of_blocks                                                       |
;|     Number of decimal number blocks.                                |
;| ascii_x_ptr                                                         |
;|     The address to ascii block 0.                                   |
;| ascii_x_len_ptr                                                     |
;|     The address to length of ascii.                                 |
;|                                                                     |
;+---------------------------------------------------------------------+
;| RETURNS:                                                            |
;|                                                                     |
;| Nothing                                                             |
;|                                                                     |
;+---------------------------------------------------------------------+
;| DESCRIPTION:                                                        |
;|                                                                     |
;| For example, fill 0x00000042 into string, becomes 0x00003234.       |
;|                                                                     |
;+---------------------------------------------------------------------+
;=======================================================================
write_dec2string:

.setup_stackframe:
    sub    esp, 4     ;reserve 4 bytes to store ebp
    mov    [esp], ebp ;store ebp to stack
    mov    ebp, esp   ;store current stack pointer value to ebp

.get_arguments:
    add    ebp, 8 ;+8 offset to ebp, to get arguments
    mov    eax, [ebp     ] ;get address decimal_x_b0
    mov    ebx, [ebp +  4] ;get num_of_blocks
    mov    ecx, [ebp +  8] ;get address ascii_x_b0
    mov    edx, [ebp + 12] ;get address ascii_x_len

.setup_localvariables:
    sub    esp, 52             ;reserve 52 bytes
    mov    [esp     ], eax     ;decimal_x_ptr
    mov    [esp +  4], ebx     ;num_of_blocks
    mov    [esp +  8], ecx     ;ascii_x_ptr
    mov    [esp + 12], edx     ;ascii_x_len_ptr
    mov    dword [esp + 16], 0 ;ascii_x_len
    mov    dword [esp + 20], 0 ;decimal_x_b0
    mov    dword [esp + 24], 0 ;decimal_x_b1
    mov    dword [esp + 28], 0 ;decimal_x_b0_len
    mov    dword [esp + 32], 0 ;decimal_x_b1_len
    mov    dword [esp + 36], 0 ;temp
    mov    dword [esp + 40], 0 ;counter
    mov    dword [esp + 44], 0 ;ascii_char
    mov    dword [esp + 48], 0 ;byte_position

.check_num_of_blocks:
;+---------------------------------------------------------------------+
;|       { If there are 2 blocks of decimal_x }                        |
;|       If num_of_blocks = 2 Then                                     |
;+---------------------------------------------------------------------+

; If num_of_blocks = 2 Then continue to .decimal_x_2_blocks
;-----------------------------------------------------------------------
    mov    eax, [esp + 4]     ;eax := num_of_blocks
    cmp    eax, 2             ;compare eax with 2
    jne    .decimal_x_1_block ;if <>, goto .decimal_x_1_block

.decimal_x_2_blocks:
;+---------------------------------------------------------------------+
;|           decimal_x_b0 := decimal_x_ptr^;                           |
;|           decimal_x_b1 := (decimal_x_ptr+4)^;                       |
;+---------------------------------------------------------------------+

; decimal_x_b0 := decimal_x_ptr^
;-----------------------------------------------------------------------
    mov    eax, [esp]      ;eax := decimal_x_ptr
    mov    eax, [eax]      ;eax := eax^
    mov    [esp + 20], eax ;decimal_x_b0 := eax

; decimal_x_b1 := (decimal_x_ptr+4)^
;-----------------------------------------------------------------------
    mov    eax, [esp]      ;eax := decimal_x_ptr
    add    eax, 4          ;eax := eax + 4
    mov    eax, [eax]      ;eax := eax^
    mov    [esp + 24], eax ;decimal_x_b1 := eax

;+---------------------------------------------------------------------+
;|           decimal_x_b0_len := 8;                                    |
;+---------------------------------------------------------------------+

; decimal_x_b0_len := 8
;-----------------------------------------------------------------------
    mov    eax, 8          ;eax := 8
    mov    [esp + 28], eax ;decimal_x_b0_len := eax

;+---------------------------------------------------------------------+
;|           { Find the number of nipples in decimal_x_b1 }            |
;|           temp := decimal_x_b1;                                     |
;|           While temp <> 0 Do                                        |
;|           Begin                                                     |
;|               temp := temp >> 4;                                    |
;|               ++ decimal_x_b1_len;                                  |
;|           End;                                                      |
;+---------------------------------------------------------------------+

; temp := decimal_x_b1
;-----------------------------------------------------------------------
    mov    eax, [esp + 24] ;eax := decimal_x_b1
    mov    [esp + 36], eax ;temp := eax

.loop_1:

; temp := temp >> 4
;-----------------------------------------------------------------------
    mov    eax, [esp + 36] ;eax := temp
    shr    eax, 4          ;eax := eax >> 4
    mov    [esp + 36], eax ;temp := eax

; ++ decimal_x_b1_len
;-----------------------------------------------------------------------
    mov    eax, [esp + 32] ;eax := decimal_x_b1_len
    add    eax, 1          ;eax := eax + 1
    mov    [esp + 32], eax ;decimal_x_b1_len := eax

; While temp <> 0, goto .loop_1
;-----------------------------------------------------------------------
    mov    eax, [esp + 36] ;eax := temp
    cmp    eax, 0          ;compare eax with 0
    jne    .loop_1         ;if <>, goto .loop_1

;+---------------------------------------------------------------------+
;|           { Fill ascii_x with decimal_x block 1 }                   |
;|           counter := decimal_x_b1_len;                              |
;|           While counter <> 0 Do                                     |
;|           Begin                                                     |
;|               ascii_char :=                                         |
;|                   ((decimal_x_b1 >> ((counter-1)*4)) and 0x0f) or   |
;|                   0x30;                                             |
;|               ascii_x_ptr^ :=                                       |
;|                   ascii_x_ptr^ or (ascii_char << (byte_position*8));|
;|               ++ ascii_x_len;                                       |
;|               ++ byte_position;                                     |
;|               -- counter;                                           |
;|           End;                                                      |
;+---------------------------------------------------------------------+

; counter := decimal_x_b1_len
;-----------------------------------------------------------------------
    mov    eax, [esp + 32] ;eax := decimal_x_b1_len
    mov    [esp + 40], eax ;counter := eax

.loop_2:

; ascii_char := ((decimal_x_b1 >> ((counter-1)*4)) and 0x0f) or 0x30
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := counter
    sub    eax, 1          ;eax := eax - 1
    mov    ebx, 4          ;ebx := 4
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    ecx, eax        ;ecx := eax
    mov    eax, [esp + 24] ;eax := decimal_x_b1
    shr    eax, cl         ;eax := eax >> cl
    and    eax, 0x0f       ;eax := eax and 0x0f
    or     eax, 0x30       ;eax := eax or 0x30
    mov    [esp + 44], eax ;ascii_char := eax

; ascii_x_ptr^ := ascii_x_ptr^ or (ascii_char << (byte_position*8))
;-----------------------------------------------------------------------
    mov    eax, [esp + 48] ;eax := byte_position
    mov    ebx, 8          ;ebx := 8
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    ecx, eax        ;ecx := eax
    mov    eax, [esp + 44] ;eax := ascii_char
    shl    eax, cl         ;eax := eax << cl
    mov    ecx, [esp +  8] ;ecx := ascii_x_ptr
    mov    ebx, [ecx]      ;ebx := ecx^
    or     eax, ebx        ;eax := eax or ebx
    mov    [ecx], eax      ;ecx^ := eax

; ++ ascii_x_len
;-----------------------------------------------------------------------
    mov    eax, [esp + 16] ;eax := ascii_x_len
    add    eax, 1          ;eax := eax + 1
    mov    [esp + 16], eax ;ascii_x_len := eax

; ++ byte_position
;-----------------------------------------------------------------------
    mov    eax, [esp + 48] ;eax := byte_position
    add    eax, 1          ;eax := eax + 1
    mov    [esp + 48], eax ;byte_position := eax

; -- counter
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := counter
    sub    eax, 1          ;eax := eax - 1
    mov    [esp + 40], eax ;counter := eax

; While counter <> 0, goto .loop_2
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := counter
    cmp    eax, 0          ;compare eax with 0
    jne    .loop_2         ;if <>, goto .loop_2

;+---------------------------------------------------------------------+
;|           { Fill ascii_x with decimal_x block 0 }                   |
;|           counter := decimal_x_b0_len;                              |
;|           While counter <> 0 Do                                     |
;|           Begin                                                     |
;|               ascii_char :=                                         |
;|                   ((decimal_x_b0 >> ((counter-1)*4)) and 0x0f) or   |
;|                   0x30;                                             |
;|               ascii_x_ptr^ :=                                       |
;|                   ascii_x_ptr^ or (ascii_char << (byte_position*8));|
;|               ++ ascii_x_len;                                       |
;|               ++ byte_position;                                     |
;|               If byte_position = 4 Then                             |
;|                   ascii_x_ptr := ascii_x_ptr + 4;                   |
;|                   byte_position := 0;                               |
;|               -- counter;                                           |
;|           End;                                                      |
;+---------------------------------------------------------------------+

; counter := decimal_x_b0_len
;-----------------------------------------------------------------------
    mov    eax, [esp + 28] ;eax := decimal_x_b0_len
    mov    [esp + 40], eax ;counter := eax

.loop_3:

; ascii_char := ((decimal_x_b0 >> ((counter-1)*4)) and 0x0f) or 0x30
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := counter
    sub    eax, 1          ;eax := eax - 1
    mov    ebx, 4          ;ebx := 4
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    ecx, eax        ;ecx := eax
    mov    eax, [esp + 20] ;eax := decimal_x_b0
    shr    eax, cl         ;eax := eax >> cl
    and    eax, 0x0f       ;eax := eax and 0x0f
    or     eax, 0x30       ;eax := eax or 0x30
    mov    [esp + 44], eax ;ascii_char := eax

; ascii_x_ptr^ := ascii_x_ptr^ or (ascii_char << (byte_position*8))
;-----------------------------------------------------------------------
    mov    eax, [esp + 48] ;eax := byte_position
    mov    ebx, 8          ;ebx := 8
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    ecx, eax        ;ecx := eax
    mov    eax, [esp + 44] ;eax := ascii_char
    shl    eax, cl         ;eax := eax << cl
    mov    ecx, [esp +  8] ;ecx := ascii_x_ptr
    mov    ebx, [ecx]      ;ebx := ecx^
    or     eax, ebx        ;eax := eax or ebx
    mov    [ecx], eax      ;ecx^ := eax

; ++ ascii_x_len
;-----------------------------------------------------------------------
    mov    eax, [esp + 16] ;eax := ascii_x_len
    add    eax, 1          ;eax := eax + 1
    mov    [esp + 16], eax ;ascii_x_len := eax

; ++ byte_position
;-----------------------------------------------------------------------
    mov    eax, [esp + 48] ;eax := byte_position
    add    eax, 1          ;eax := eax + 1
    mov    [esp + 48], eax ;byte_position := eax

.check1_is_ascii_x_block_full:
; If byte_position = 4 Then continue to .ascii_x_block_is_full
;-----------------------------------------------------------------------
    mov    eax, [esp + 48] ;eax := byte_position
    cmp    eax, 4          ;compare eax with 4
    ;if <>, goto .cond1_ascii_x_block_is_not_full
    jne    .cond1_ascii_x_block_is_not_full

.cond1_ascii_x_block_is_full:
; ascii_x_ptr := ascii_x_ptr + 4
;-----------------------------------------------------------------------
    mov    eax, [esp + 8] ;eax := ascii_x_ptr
    add    eax, 4         ;eax := eax + 4
    mov    [esp + 8], eax ;ascii_x_ptr := eax

; byte_position := 0
;-----------------------------------------------------------------------
    xor    eax, eax        ;eax := 0
    mov    [esp + 48], eax ;byte_position := eax

.cond1_ascii_x_block_is_not_full:

; -- counter
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := counter
    sub    eax, 1          ;eax := eax - 1
    mov    [esp + 40], eax ;counter := eax

; While counter <> 0, goto .loop_3
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := counter
    cmp    eax, 0          ;compare eax with 0
    jne    .loop_3         ;if <>, goto .loop_3

.endloop_3:

; skip .decimal_x_1_block:
;-----------------------------------------------------------------------
    jmp    .save_ascii_x_len

.decimal_x_1_block:
;+---------------------------------------------------------------------+
;|       { If number of blocks is 1, or other than 2 }                 |
;|       Else                                                          |
;|           decimal_x_b0 := decimal_x_ptr^;                           |
;+---------------------------------------------------------------------+
    mov    eax, [esp     ] ;eax := decimal_x_ptr
    mov    eax, [eax]      ;eax := eax^
    mov    [esp + 20], eax ;decimal_x_b0 := eax

;+---------------------------------------------------------------------+
;|           { Find the number of nipples in decimal_x block 0 }       |
;|           temp := decimal_x_b0;                                     |
;|           While temp <> 0 Do                                        |
;|           Begin                                                     |
;|               temp := temp >> 4;                                    |
;|               ++ decimal_x_b0_len;                                  |
;|           End;                                                      |
;+---------------------------------------------------------------------+

; temp := decimal_x_b0
;-----------------------------------------------------------------------
    mov    eax, [esp + 20] ;eax := decimal_x_b0
    mov    [esp + 36], eax ;temp := eax

.loop_4:

; temp := temp >> 4
;-----------------------------------------------------------------------
    mov    eax, [esp + 36] ;eax := temp
    shr    eax, 4          ;eax := eax >> 4
    mov    [esp + 36], eax ;temp := eax

; ++ decimal_x_b0_len
;-----------------------------------------------------------------------
    mov    eax, [esp + 28] ;eax := decimal_x_b0_len
    add    eax, 1          ;eax := eax + 1
    mov    [esp + 28], eax ;decimal_x_b0_len := eax

; While temp <> 0, goto .loop_4
;-----------------------------------------------------------------------
    mov    eax, [esp + 36] ;eax := temp
    cmp    eax, 0          ;compare eax with 0
    jne    .loop_4         ;if <>, goto .loop_4

.endloop_4:

;+---------------------------------------------------------------------+
;|           { Fill the ascii_x with decimal_x block 0 }               |
;|           counter := decimal_x_b0_len;                              |
;|           While counter <> 0 Do                                     |
;|           Begin                                                     |
;|               ascii_char :=                                         |
;|                   ((decimal_x_b0 >> ((counter-1)*4)) and 0x0f) or   |
;|                   0x30;                                             |
;|               ascii_x_ptr^ :=                                       |
;|                   ascii_x_ptr^ or (ascii_char << (byte_position*8));|
;|               ++ ascii_x_len;                                       |
;|               ++ byte_position;                                     |
;|               If byte_position = 4 Then                             |
;|                   ascii_x_ptr := ascii_x_ptr + 4;                   |
;|                   byte_position := 0;                               |
;|               -- counter;                                           |
;|           End;                                                      |
;+---------------------------------------------------------------------+

; counter := decimal_x_b0_len
;-----------------------------------------------------------------------
    mov    eax, [esp + 28] ;eax := decimal_x_b0_len
    mov    [esp + 40], eax ;counter := eax

.loop_5:

; ascii_char := ((decimal_x_b0 >> ((counter-1)*4)) and 0x0f) or 0x30
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := counter
    sub    eax, 1          ;eax := eax - 1
    mov    ebx, 4          ;ebx := 4
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    ecx, eax        ;ecx := eax
    mov    eax, [esp + 20] ;eax := decimal_x_b0
    shr    eax, cl         ;eax := eax >> cl
    and    eax, 0x0f       ;eax := eax and 0x0f
    or     eax, 0x30       ;eax := eax or 0x30
    mov    [esp + 44], eax ;ascii_char := eax

; ascii_x_ptr^ := ascii_x_ptr^ or (ascii_char << (byte_position*8))
;-----------------------------------------------------------------------
    mov    eax, [esp + 48] ;eax := byte_position
    mov    ebx, 8          ;ebx := 8
    xor    edx, edx        ;edx := 0
    mul    ebx             ;eax := eax * ebx
    mov    ecx, eax        ;ecx := eax
    mov    eax, [esp + 44] ;eax := ascii_char
    shl    eax, cl         ;eax := eax << cl
    mov    ecx, [esp +  8] ;ecx := ascii_x_ptr
    mov    ebx, [ecx]      ;ebx := ecx^
    or     eax, ebx        ;eax := eax or ebx
    mov    [ecx], eax      ;ecx^ := eax

; ++ ascii_x_len
;-----------------------------------------------------------------------
    mov    eax, [esp + 16] ;eax := ascii_x_len
    add    eax, 1          ;eax := eax + 1
    mov    [esp + 16], eax ;ascii_x_len := eax

; ++ byte_position
;-----------------------------------------------------------------------
    mov    eax, [esp + 48] ;eax := byte_position
    add    eax, 1          ;eax := eax + 1
    mov    [esp + 48], eax ;byte_position := eax

.check2_is_ascii_x_block_full:
; If byte_position = 4 Then continue to .ascii_x_block_is_full
;-----------------------------------------------------------------------
    mov    eax, [esp + 48] ;eax := byte_position
    cmp    eax, 4          ;compare eax with 4
    ;if <>, goto .cond2_ascii_x_block_is_not_full
    jne    .cond2_ascii_x_block_is_not_full

.cond2_ascii_x_block_is_full:
; ascii_x_ptr := ascii_x_ptr + 4
;-----------------------------------------------------------------------
    mov    eax, [esp + 8] ;eax := ascii_x_ptr
    add    eax, 4         ;eax := eax + 4
    mov    [esp + 8], eax ;ascii_x_ptr := eax

; byte_position := 0
;-----------------------------------------------------------------------
    xor    eax, eax        ;eax := 0
    mov    [esp + 48], eax ;byte_position := eax

.cond2_ascii_x_block_is_not_full:

; -- counter
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := counter
    sub    eax, 1          ;eax := eax - 1
    mov    [esp + 40], eax ;counter := eax

; While counter <> 0, goto .loop_5
;-----------------------------------------------------------------------
    mov    eax, [esp + 40] ;eax := counter
    cmp    eax, 0          ;compare eax with 0
    jne    .loop_5 ;if <>, goto .loop_5

.endloop_5:

.save_ascii_x_len:
;+---------------------------------------------------------------------+
;|       { Save the length of ascii_x }                                |
;|       ascii_x_len_ptr^ := ascii_x_len;                              |
;+---------------------------------------------------------------------+

; ascii_x_len_ptr^ := ascii_x_len
;-----------------------------------------------------------------------
    mov    eax, [esp + 16] ;eax := ascii_x_len
    mov    ebx, [esp + 12] ;ebx := ascii_x_len_ptr
    mov    [ebx], eax      ;ebx^ := eax

.return:

.clean_stackframe:
    sub    ebp, 8     ;-8 offset to ebp
    mov    esp, ebp   ;restore stack pointer to its initial value
    mov    ebp, [esp] ;restore ebp to its initial value
    add    esp, 4     ;restore 4 bytes

    ret
