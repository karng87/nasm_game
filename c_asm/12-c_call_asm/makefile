CC=gcc
CFLAGS=-g -Wall
NASM=nasm
NASMFLAGS=-g -felf64

c_SRCS=$(notdir $(shell find src -name "*.c"))
c_BINS=$(patsubst %.c,build/bin/%,$(c_SRCS))
nasm_SRCS=$(notdir $(shell find src -name "*.asm"))
nasm_OBJS=$(patsubst %.asm,build/nasm/%.o,$(nasm_SRCS))
as_SRCS=$(notdir $(shell find src -name "*.S"))
as_OBJS=$(patsubst %.S,build/as/%.o,$(as_SRCS))
lib_SRCS=$(notdir $(shell find src/lib -name "*.c"))
lib_OBJS=$(patsubst %.c,build/lib/%.o,$(lib_SRCS))

test_SRCS=$(notdir $(shell find test -name "*.c"))
test_BINS=$(patsubst %.c,build/test/%,$(test_SRCS))

LIB_so = libmyso.so
LIB_a = libmya.a

all: build build/lib/$(LIB_so) $(c_BINS) build/lib/$(LIB_a) $(c_BINS)-a

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_a)

build/lib/$(LIB_a): $(nasm_OBJS)
	ar -cvrs $@ $^

build/lib/$(LIB_so): $(nasm_OBJS)
	$(CC) $(FLAGS) -fpic -shared -Wl,-soname,$(LIB_so).1 -o $@.1.0.0 $^
	cd build/lib && ln -s $(LIB_so).1.0.0 $(LIB_so).1
	cd build/lib && ln -s $(LIB_so).1 $(LIB_so)

run: $(c_BINS)
	LD_LIBRARY_PATH=./build/lib $<

build/bin/%: src/%.c src/%.h
	$(CC) -c $(FLAGS) -o$@ $<

build/bin/%-a: src/%.c
	$(CC) $(FLAGS) -no-pie -o$@ $< -Lbuild/lib -lmya

build/bin/%: src/%.c
	$(CC) $(FLAGS) -o$@ $< -Lbuild/lib -lmyso

build/nasm/%.o: src/%.asm
	$(NASM) $(NASMFLAGS) -o$@ $<

build/as/%.o: src/%.S
	$(AS) $(ASFLAGS) -o$@ $<

build:
	mkdir -p build/{bin,lib,nasm,as}

compile_commands.json:
	make --no-print-directory --always-make --dry-run | sed -En '/\s.+\.c[p]{0,2}\s.*/{s#(.*)(\s.*\.c[p]{0,2})(.*)#\1\3\2#p}' | jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' > compile_commands.json

tmp := $(shell find . -type f,l -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
	rm $(tmp)

echo:
	@echo $(tmp)
	@echo "This is C main Nasm shared lib"

# https://www.youtube.com/watch?v=JarMkGWTF8Y&t=88s

