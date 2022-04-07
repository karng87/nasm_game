vulkan_LD := -lvulkan -lxcb -lX11 -lX11-xcb -lxkbcommon
j_I := -Iinclude
j_LD := -Llibs -lj
jc_LD := -Llibs -ljc

p_I := -I./src/include
asm_lcd := -melf_x86_64 -emain -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
	-L /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/ \
	 /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbegin.o \
	 /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtend.o \
	 /lib/crt1.o \
	 /lib/crti.o \
	 /lib/crtn.o

so_libc := libjc.so
so_libcxx := libj.so
so_libasm := libja.so

I := $(j_I)
L :=
lc := $(vulkan_LD)
lcxx := $(vulkan_LD)
lasm :=
Wl_rpath = -Wl,-rpath build
D := -D_DEBUG -DEXPORT

CFLAGS := -g -Wall -fPIC $(I) $(D)
LDFLAGS := -shared $(L) $(lc)
CXXFLAGS := $(CFLAGS)
LDXXFLAGS := -shared $(L) $(lcxx)

SRC_C :=$(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test.c')
SRC_CXX :=$(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '.*/test.cpp')
SRC_ASM :=$(shell find src -type f -regextype posix-extended -regex '.*\.asm' -and -not -regex '.*/test.asm')

.PHONY: compile_commands.json all run runc runasm clean echo

all: build/$(so_libc) compile_commands.json #build/test.c.out

build/obj/%.c.o: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	gcc $(CFLAGS) -c -o$@ $<

build/$(so_libc): $(patsubst src/%,build/obj/%.o,$(SRC_C))
	gcc $(LDFLAGS) -o$@ $^

build/test.c.out: src/test.c
	gcc -g -Wall $< -o $@ -Iinclude -Lbuild -ljc $(vulkan_LD) $(Wl_rpath)

run: build/$(so_libc) build/test.c.out
	./$(word 2,$^)


tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|libs|test)/.*\.(hi|o|so|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
echo:
	echo $(tmp)
clean:
	rm $(tmp)

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(CFLAGS) $(LDFLAGS) -o/dev/null $<

compile_commands.json:  $(patsubst src/%,build/json/%.json,$(SRC_C)) $(patsubst src/%,build/json/%.json,$(SRC_CXX))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find build/json -type f -name "*.json"` > compile_commands.json)

