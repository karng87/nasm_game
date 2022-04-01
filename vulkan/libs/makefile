so_libc := libjc.so
so_libcxx := libj.so
so_libasm := libja.so

I := -Iinclude
L :=
lc :=
lcxx :=
lasm :=
Wl_rpath = -Wl,-rpath build

CFLAGS := -fPIC -g -Wall $(I)
CXXFLAGS := $(CFLAGS)
LDFLAGS := -shared $(L) $(lc)
LDXXFLAGS := -shared $(L) $(lcxx)

SRC_C :=$(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test.c')
SRC_CXX :=$(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '.*/test.cpp')
SRC_ASM :=$(shell find src -type f -regextype posix-extended -regex '.*\.asm' -and -not -regex '.*/test.asm')

.PHONY: compile_commands.json all run runc runasm clean echo

all: build/$(so_libc)

build/obj/%.asm.o: src/%.asm
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	nasm -felf64 -o$@ $<

build/$(so_libasm): $(patsubst %,build/obj/%.o,$(asm_SRCS))
	gcc $(LDFLAGS) -o$@ $^

build/obj/test.asm.o: src/test.asm
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	nasm -felf64 -o$@ $<
build/test.asm.out: build/obj/test.asm.o
	gcc $(LDFLAGS) $< -o $@

build/obj/%.c.o: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	gcc $(CFLAGS) -c -L$(I) -o$@ $<

build/$(so_libc): $(patsubst src/%,build/obj/%.o,$(SRC_C))
	gcc $(LDFLAGS) -o$@ $^

build/test.c.out: src/test.c
	gcc -g -Wall $< -o $@ -Iinclude -Lbuild -l$(patsubst lib%.so,%,$(so_libc)) $(Wl_rpath)

build/obj/%.cpp.o: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	g++ $(CXXFLAGS) -c -o$@ $<
build/$(so_libcxx): $(patsubst %,build/obj/%.o,$(SRC_CXX))
	g++ $(LDXXFLAGS) -o$@ $^

build/test.cpp.out: src/test.cpp
	g++ -g -Wall $< -o $@ -Iinclude -Lbuild -l$(patsubst lib%.so,%,$(so_libcxx)) $(Wl_rpath)

runc: build/$(so_libc) build/test.c.out
	./$(word 2,$^)

run: build/$(so_libcxx) build/test.cpp.out
	LD_LIBRARY_PATH+=build ./$(word 2,$^)

runasm: build/$(so_libasm) build/test.asm.out
	LD_LIBRARY_PATH+=build ./$(word 2,$^)

tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|libs|test)/.*\.(hi|o|so|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
echo:
	echo $(tmp)
clean:
	rm $(tmp)

build/json/%.cpp.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20  $(CXXFLAGS) $(LDXXFLAGS) -c -o/dev/null $<

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(CFLAGS) $(LDFLAGS) -o/dev/null $<

compile_commands.json:  $(patsubst src/%,build/json/%.json,$(SRC_C)) $(patsubst src/%,build/json/%.json,$(SRC_CXX))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)

