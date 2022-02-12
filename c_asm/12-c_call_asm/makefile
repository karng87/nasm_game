CC=clang
CFLAGS=-g -Wall 

GCC=gcc
GCCFLAGS=-g -Wall

NASM=nasm
NASMFLAGS=-g -felf64

AS=as
ASFLAGS=
LD=ld
LDFLAGS=

c_SRCS=$(notdir $(shell find src -name "*.c"))
c_BINS=$(patsubst %.c,build/bin/%,$(c_SRCS))

nasm_SRCS=$(notdir $(shell find src -name "*.asm"))
nasm_OBJS=$(patsubst %.asm,build/nasm/%.o,$(nasm_SRCS))

as_SRCS=$(notdir $(shell find src -name "*.S"))
as_OBJS=$(patsubst %.S,build/as/%.o,$(asm_SRCS))

lib_SRCS=$(notdir $(shell find src/lib -name "*.c"))
lib_OBJS=$(patsubst %.c,build/lib/%.o,$(c_LIBS))

LIB_so = build/lib/libmymsg.so
LIB_a = build/lib/libmymsg.a

all: build $(LIB_a) build/bin/main

releaseA: CFLAGS=-Wall -O2 -DNDEBUG
releaseA: clean
releaseA: $(LIB_a)

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_so)


$(LIB_a): $(nasm_OBJS)
	ar -cr $(LIB_a) $^

build/bin/%: src/%.c
	$(GCC) $(GCCFLAGS) -no-pie $< -Lbuild/lib -lmymsg -o $@

build/nasm/%.o: src/%.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

build/as/%.o: src/%.S
	$(AS) $(ASFLAGS) -o $@ -c $<

build:
	mkdir -p build/{test,bin,nasm,as,lib}

tmp := $(shell find . -type f -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
ifneq ('', tmp)
	rm $(tmp)
endif


compile_commands.json:
	make --no-print-directory --always-make --dry-run | sed -En '/\s.+\.c[p]{0,2}\s.*/{s#(.*)(\s.*\.c[p]{0,2})(.*)#\1\3\2#p}' | jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' > compile_commands.json

# https://www.youtube.com/watch?v=JarMkGWTF8Y&t=88s

