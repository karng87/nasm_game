;------------
; 8 bit = 1 byte
;AL - accumulator low
;BL - base low
;CL - counter low
;DL - data low
;AH - accumulator high
;CH - counter high
;DH - data high
;BH - base high

;--------------
; 16 bit = 2 byte = 1 word
; X - eXtend
;AX - accumulator: 누적 연산기라는 의미
;BX - base: 기초, 기점이라는 의미
;CX - counter: 수를 세는 기계라는 의미
;DX - data: 데이터라는 의미
;SP - stack pointer: 스택용 포인터
;BP - base pointer: 베이스용 포인터
;SI - source index: 읽기 인덱스
;DI - destination index: 쓰기 인덱스
;IP - instruction pointer: 명령 포인터

;-------------
; 32 bit = 4 byte = 2 word = 1 double
; E = Expand
;EAX, ECX, EDX, EBX, ESP, EBP, ESI, EDI, EIP

;-------------
; 64 bit = 8 byte = 4 word = 2 double = 1 quad
; R = Register
;RAX, RCX, RDX, RBX, RSP, RBP, RSI, RDI, RIP

;---------------
; Segment = 16 bit 
;CS - code segment
;SS - stack segment
;DS - data segment
;ES - extra segment: 덤 세그먼트
;FS - F is flowed by E
;GS - G is flowd by F

bits 16 ; tell NASM to assemble 16-bit code
org 0x7c00 ;tell NASM the code is runnig at boot sector

times 510 - ($-$$) db 0
;dw 0xaa55 
db 0x55
db 0xaa
