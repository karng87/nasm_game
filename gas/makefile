CC=gcc
CFLAGS=-no-pie -g -Wall

AS=as
ASFLAGS=--64
LD=ld
LDFLAGS=

c_SRCS=$(notdir $(shell find src -name "*.c"))

s_SRCS=$(notdir $(shell find src -name "*.S"))
nasm_SRCS=$(notdir $(shell find src -name "*.asm"))

c_TARGETS=$(patsubst %,build/%.out,$(c_SRCS))
s_TARGETS=$(patsubst %,build/%.out,$(s_SRCS))
nasm_TARGETS=$(patsubst %,build/%.out,$(nasm_SRCS))

tmp := $(shell find . -type f -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')

LIB_so = lib/libmylib.so
LIB_a = lib/libmylib.a


all: $(s_TARGETS) $(nasm_TARGETS)

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_a)

$(LIB_a): $(c_lib_OBJS)
	rm $(LIB_a)
	ar -cvrs $(LIB_a) $(c_lib_OBJS)

build/%.c.out: src/%.c 
	$(CC) $(CFLAGS) -o $@ $<

build/%.cpp.out: src/%.cpp
	$(CC) $(CFLAGS) -o $@ $<

build/%.S.out: src/%.S
	# $(CC) -no-pie -o $@ $<
	gcc -o $@ $<

build/%.asm.o: src/%.asm
	# $(CC) -no-pie -o $@ $<
	nasm -felf64 -o$@ $<

build/%.asm.out: $(patsubst %.asm,build/%.asm.o, $(nasm_SRCS))
	# $(CC) -no-pie -o $@ $<
	gcc -o$@ $<

test: $(LIB_a) tests/bin $(c_TESTBINS) 
	for t in $(c_TESTBINS); do ./$$t ; done

test/bin/%: test/%.c
	$(CC) $(FLAGS) -o $@ -lcriterion $< 

tests/bin:
	mkdir -p tests/bin

compile_commands.json:
	make --no-print-directory --always-make --dry-run | sed -En '/\.c\s*$$/p' | jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' > compile_commands.json

# https://www.youtube.com/watch?v=JarMkGWTF8Y&t=88s
echo:
	echo $(patsubst %.asm,build/%.asm.o, $(nasm_SRCS))

