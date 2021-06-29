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

OBJS := $(patsubst %.nasm,build/%.o,$(notdir $(shell find src -name "*.nasm")))
TARGETS := $(patsubst %.o,%.out,$(OBJS))

.PHONY: all clean run
all : $(TARGETS)  out-c out-n out-s

build/%.out : build/%.o
				$(LD) $(LDFLAGS) $< -o $@
				
%.out : %.o
				$(LD) $(LDFLAGS) $< -o $@

build/%.o : src/%.nasm
				$(AS) $(AS_FLAGS) $< -o $@

out-n: build/nasm.o
				$(LD) $(LDFLAGS) $< -o $@

build/nasm.o : ntuto.nasm
				$(NASM) $(NASM_FLAGS) $< -o $@

out-c: build/cc.o
				$(LD) $(LD_FLAGS) $< -o $@
build/cc.o: ctuto.c
				$(GCC) -c $< -o $@

out-s: build/s.o
				$(LD) $< -o $@

build/s.o: stuto.s
				$(GCC) -c $< -o $@
clean:
		rm out-* *.o build/*.o

c:
			./out-c

n:
			./out-n

s:
			./out-s
