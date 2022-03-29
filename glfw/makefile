# L_FLAGS:= -L./build/libs -lmylibc -lmylib -lglfw -ldl
glad_CFLAGS:= -I./external/include -Isrc/include
glad_LDFLAGS:= -L./external/libs -lglad -lglfw -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi
glad_FLAGS:= $(glad_CFLAGS) $(glad_LDFLAGS)

glew_FLAGS:= -lGLEW -lGL -lglfw

CC:=gcc
CFLAGS:=-g -Wall $(glad_CFLAGS)
CXX:=g++
CXXFLAGS:=-g -Wall -std=c++20

fPIC_CFLAGS:=-g -Wall -fPIC
shared_LDFLAGS:=-shared


no_pie_LD_CFLAGS:=-no-pie
static_LD_CFLAGS:=-static

AS:=as
AS_FLAGS:=--64

NASM:=nasm
NASM_FLAGS:=-g -felf64

ld=ld
ldFLAGS := -melf_x86_64 -emain -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
	 -L /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/ \
		/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbegin.o \
		/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtend.o \
		/lib/crt1.o \
		/lib/crti.o \
		/lib/crtn.o

nasm_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.asm$$' -and -not -regex '\./(lib|build)/.*')
nasm_TARGETS=$(patsubst src/%.asm,build/%.out,$(nasm_SRCS))

as_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.S$$' -and -not -regex '\./(lib|build)/.*')
as_TARGETS=$(patsubst src/%.asm,build/%.out,$(as_SRCS))

c_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.c$$' -and -not -regex '\./(lib|build)/.*')
c_TARGETS=$(patsubst src/%.c,build/%.out,$(c_SRCS))
cxx_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.cpp$$' -and -not -regex '\./(lib|build)/.*')
cxx_TARGETS=$(patsubst src/%.cpp,build/%.out,$(cxx_SRCS))


.PHONY: external libs compile_commands.json all run clean echo

all: external
	$(MAKE) $(c_TARGETS)
	$(MAKE) $(cxx_TARGETS)

external: 
	$(MAKE) -C external 
	$(MAKE) -C libs

build/%.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	$(CC) $(CFLAGS) $(glad_FLAGS) -o $@ $<

build/%_glew.out: src/%_glew.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	$(CC) $(CFLAGS) $(glew_FLAGS) -o $@ $<

build/%.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) $(glad_FLAGS) -o $@ $<

build/%_glew.out: src/%_glew.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) $(glew_FLAGS) -o $@ $<

build/%.out: src/%.S
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	$(CC) $(CFLAGS)  -o $@ $<

build/%.out: src/%.asm
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	$(NASM) $(NASM_FLAGS) -o $@ $<

run: $(cxx_TARGETS)
ifdef args 
	LD_LIBRARY_PATH+=./external/libs ./$(word 1,$^) $(args)
else
	LD_LIBRARY_PATH+=./external/libs ./$(word 1,$^) 
endif

runc: $(c_TARGETS)
ifdef args 
	LD_LIBRARY_PATH+=./external/libs ./$(word 1,$^) $(args)
else
	LD_LIBRARY_PATH+=./external/libs ./$(word 1,$^) 
endif

echo:
	echo $(cxx_SRCS)
	echo $(cxx_TARGETS)
	echo "This is glfw"

tmp := $(shell find . -type f,l -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
	rm $(tmp)

build/json/%.cpp.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20 $(glad_FLAGS) -o/dev/null $<

build/json/%_glew.cpp.json: src/%_glew.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20 $(glew_FLAGS) -o/dev/null $<

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(glad_FLAGS) -o/dev/null $<
build/json/%_glew.c.json: src/%_glew.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(glew_FLAGS) -o/dev/null $<

compile_commands.json: $(patsubst src/%,build/json/%.json,$(c_SRCS)) $(patsubst src/%,build/json/%.json,$(cxx_SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find build/json -type f -name "*.json"` > compile_commands.json)

