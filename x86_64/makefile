#/**************************************************** 
#* Some definitions: 
#*   PIC - position independent code (-fPIC) 
#*   PIE - position independent executable (-fPIE -pie) 
#*   crt - C runtime
#*****************************************************
#
#* ***************************************************
#* ld tuto.o 
#*   -L  /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/ 
#*       /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbegin.o 
#*       /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtend.o 
#*       /lib/crt1.o 
#*       /lib/crti.o 
#*       /lib/crtn.o 
#*       -dynamic-linker /lib64/ld-linux-x86-64.so.2 
#*       -lc
#* ***************************************************
#*/
CC = clang
CC_FLAGS = -Wall -g -fsanitize=address

GCC = gcc
GCC_FLAGS = -Wall -g
GCC_S = $(GCC) -Og -S

NASM = nasm
NASM_FLAGS = -felf64

LD = ld
LDFLAGS = -melf_x86_64 -emain

LD_FLAGS = -L /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/ \
       /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbegin.o \
       /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtend.o \
       /lib/crt1.o \
       /lib/crti.o \
       /lib/crtn.o \
       -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
       -lc

OBJS := $(patsubst %.nasm,src/build/%.o,$(notdir $(shell find src -name "*.nasm")))
TARGETN := $(patsubst %.o,%.out,$(OBJS))

TARGETS:= $(patsubst %.S,src/build/%.out,$(notdir $(shell find src -name "*.S")))

.PHONY: all clean run
all : $(TARGETS) $(TARGETN) out-c out-n out-s

src/build/%.out : src/build/%.o
				$(LD) $(LDFLAGS) $< -o$@
				
src/build/%.o : src/%.nasm
				$(AS) $(AS_FLAGS) $< -o$@




src/build/out-n: src/build/nasm.o
				$(LD) $(LDFLAGS) $< -o$@

src/build/%.out: src/%.S
				$(GCC) $< -o$@
src/%.S: src/%.c
				$(GCC) $(GCC_S) $< -o$@



out-n: src/build/nasm.o
				$(LD) $(LD_FLAGS) $< -o$@
src/build/nasm.o : ntuto.nasm
				$(NASM) $(NASM_FLAGS) $< -o$@



out-c: ctuto.S
				$(GCC) $< -o$@
ctuto.S: ctuto.c
				$(GCC) $(GCC_S) $< -o$@

out-s: stuto.s
				$(GCC) $< -o$@
clean:
		rm out-* *.o build/*.o

c:
			./out-c

n:
			./out-n

s:
			./out-s
