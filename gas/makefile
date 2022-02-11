CC=gcc
CFLAGS=-no-pie -g -Wall

LD=ld
LDFLAGS=
c_SRCS=$(notdir $(shell find src -name "*.c"))
s_SRCS=$(notdir $(shell find src -name "*.S"))

c_TARGETS=$(patsubst %.c,build/%,$(c_SRCS))
s_TARGETS=$(patsubst %.c,build/%,$(s_SRCS))

c_LIBS=$(notdir $(shell find libs -name "*.c"))
clib_OBJS=$(patsubst %.c,build/%.o,$(c_LIBS))

tmp := $(shell find . -type f -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
c_TESTS=$(notdir $(shell find test -name "*.c"))
c_TESTBINS=$(patsubst %.c,build/%.o,$(c_TESTS))


LIB_so = lib/libmylib.so
LIB_a = lib/libmylib.a


all: $(s_TARGETS) $(c_TARGETS)

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_a)

$(LIB_a): $(c_lib_OBJS)
	rm $(LIB_a)
	ar -cvrs $(LIB_a) $(c_lib_OBJS)

build/%: src/%.S src/%.c 
	$(CC) $(CFLAGS) -o $@ $<

build/%: src/%.c
	$(CC) $(CFLAGS) -o $@ $<

build/%: src/%.S
	$(CC) $(FLAGS) -o $@ $<


test: $(LIB_a) tests/bin $(c_TESTBINS) 
	for t in $(c_TESTBINS); do ./$$t ; done

test/bin/%: test/%.c
	$(CC) $(FLAGS) -o $@ -lcriterion $< 

tests/bin:
	mkdir -p tests/bin

compile_commands.json:
	make --no-print-directory --always-make --dry-run | sed -En '/\.c\s*$$/p' | jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' > compile_commands.json

# https://www.youtube.com/watch?v=JarMkGWTF8Y&t=88s

