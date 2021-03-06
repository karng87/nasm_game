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
#*----------------------------------------------------
#* ldd : show load dynamic dependance
#* ***************************************************
#*----------------------------------------------------
#* ldconfig : configure runtime dynamic library path
#* ***************************************************
#*/
CC = gcc
CC_S = -S
CC_CFLAGS = -Wall -g -fsanitize=address -c
CC_LDFLAGS = -no-pie

GCC = gcc
GCC_S = -S
GCC_CFLAGS = -Wall -g -c
GCC_LDFLAGS = -no-pie

AS = nasm
AS_CFLAGS = -f elf64 -g -Fdwarf

LD = ld
LDFLAGS = -melf_x86_64 -emain

# usr = User System Resources
LD_FLAGS = -L /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/ \
       /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbegin.o \
       /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtend.o \
       /lib/crt1.o \
       /lib/crti.o \
       /lib/crtn.o \
       -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
       -lc

#OBJSN := $(patsubst %,src/build/%.o,$(notdir $(shell find src -name "*.nasm")))
#TARGETN := $(patsubst %,src/%.out,$(notdir $(OBJSN)))
TARGETN := $(patsubst %,src/%.o.out,$(notdir $(shell find src -name "*.nasm")))

#OBJSC := $(patsubst %,src/%.s,$(notdir $(shell find src -name "*.c")))
#TARGETC := $(patsubst %,src/%.out,$(notdir $(OBJSC)))
TARGETC := $(patsubst %,src/%.s.out,$(notdir $(shell find src -name "*.c")))

TARGETS:= $(patsubst %,src/%.o.out,$(notdir $(shell find src -name "*.S")))
TARGET := ntuto.nasm.o.out gtuto.S.o.out ctuto.c.s.o.out
.PHONY: all clean run compile_commands.json
#MAKEFLAGS += --silent
#.PRECIOUS:
#.INTERMEDIATE:

all : $(TARGET) $(TARGETN) $(TARGETC) $(TARGETS)

src/build/%.nasm.o : src/%.nasm
				$(AS) $(AS_CFLAGS) -o$@ $<
src/%.nasm.o.out : src/build/%.nasm.o
				$(LD) $(LDFLAGS) -o$@ $< 
				

src/build/%.S.o: src/%.S
				$(CC) $(CC_CFLAGS) -o$@ $<
src/%.S.o.out: src/build/%.S.o
				$(LD) $(LDFLAGS) -o$@ $<


src/%.c.s: src/%.c
				$(CC) $(CC_S) -o$@ $<
src/build/%.c.s.o: src/%.c.s
				$(CC) $(CC_CFLAGS) -o$@ -c $<
src/%.c.s.o.out: src/build/%.c.s.o
				$(LD) $(LDFLAGS) -o$@ $<


src/build/ntuto.nasm.o : ntuto.nasm
				$(AS) $(AS_CFLAGS) -o$@ $<
ntuto.nasm.o.out: src/build/ntuto.nasm.o
				$(LD) $(LDFLAGS) -o$@ $<


ctuto.c.s: ctuto.c
				$(CC) $(CC_S) -o$@ $<
src/build/ctuto.c.s.o: ctuto.c.s
				$(CC) $(CC_CFLAGS) -o$@ $<
ctuto.c.s.o.out: src/build/ctuto.c.s.o
				$(LD) $(LD_FLAGS) -o$@ $<


src/build/gtuto.S.o: gtuto.S
				$(CC) $(CC_CFLAGS) -o$@ $<
gtuto.S.o.out: src/build/gtuto.S.o
				$(LD) $(LDFLAGS) -o$@ $<

clean:
		rm *.{s,out} src/*.out src/build/*.o compile_commands.json

c:
			./ctuto.c.s.o.out

n:
			./ntuto.nasm.o.out

g:
			./gtuto.S.o.out

compile_commands.json:
			make --no-print-directory --always-make --dry-run | \
				awk '/\.c$$/' | \
				jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' \
				> compile_commands.json
