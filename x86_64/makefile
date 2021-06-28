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
CC_FLAG = -fsanitize=address

AS = nasm
FLAGS = -felf64

LD = ld
LD_FLAGS = -melf_x86_64 -emain

LDFLAGS = -L /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/ \
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
all : $(TARGETS)  a.out out

build/%.out : build/%.o
				$(LD) $(LDFLAGS) $< -o $@
				
%.out : %.o
				$(LD) $(LDFLAGS) $< -o $@

build/%.o : src/%.nasm
				$(AS) $(FLAGS) $< -o $@

out: build/nasm.o
				$(LD) $(LDFLAGS) $^ -o $@

build/nasm.o : ntuto.nasm
				$(AS) $(FLAGS) $< -o $@

a.out: build/cc.o
				$(LD) $^ $(LDFLAGS) -o $@
build/cc.o: ctuto.c
				$(CC) -c $^ -o $@

clean:
		rm *.out build/*.o

a:
			./a.out

n:
			./out
