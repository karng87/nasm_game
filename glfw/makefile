# L_FLAGS:= -L./build/libs -lmylibc -lmylib -lglfw -ldl
L_FLAGS:=-L./external/libs 
l_FLAGS:=-lglad -lglfw -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi
I_FLAGS:=-I./external/include -Isrc/include
LD_FLAGS:=$(I_FLAGS) $(L_FLAGS) $(l_FLAGS)

CC:=gcc
CFLAGS:=-g -Wall
lib_fPIC_CFLAGS:=-g -Wall -fPIC
lib_shared_LD_CFLAGS:=-shared

CXX:=g++
CXXFLAGS:=-g -Wall
lib_fPIC_CXXFLAGS:=-g -Wall -fPIC
lib_shared_LD_CXXFLAGS:=-shared -Wall

no_pie_LD_CFLAGS:=-no-pie
static_LD_CFLAGS:=-static

nasm_CFLAGS:=

CXX:=g++
CXXFLAGS:=-g -Wall -std=c++20

AS:=as
ASFLAGS:=--64

NASM:=nasm
NASMFLAGS:=-g -felf64

LD=ld
LDFLAGS := -melf_x86_64 -emain -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
	 -L /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/ \
		/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbegin.o \
		/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtend.o \
		/lib/crt1.o \
		/lib/crti.o \
		/lib/crtn.o

nasm_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.asm$$' -and -not -regex '\./(lib|build)/.*')
nasm_TARGETS=$(patsubst src/%.asm,build/binn/%,$(nasm_SRCS))

as_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.S$$' -and -not -regex '\./(lib|build)/.*')
as_TARGETS=$(patsubst src/%.asm,build/bina/%,$(as_SRCS))

c_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.c$$' -and -not -regex '\./(lib|build)/.*')
c_TARGETS=$(patsubst src/%.c,build/binc/%,$(c_SRCS))
cxx_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.cpp$$' -and -not -regex '\./(lib|build)/.*')
cxx_TARGETS=$(patsubst src/%.cpp,build/bin/%,$(cxx_SRCS))


.PHONY: libs compile_commands.json all run clean echo

all: libs
	$(MAKE) $(c_TARGETS)
	$(MAKE) $(cxx_TARGETS)

libs: 
	$(MAKE) -C external 
	$(MAKE) -C libs

build/binc/%: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/binc/\1#p' <<< $<)
	$(CC) $(CFLAGS) $(LD_FLAGS) -o $@ $<

build/bin/%: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/bin/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) $(LD_FLAGS) -o $@ $<

build/bina/%: src/%.S
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/bina/\1#p' <<< $<)
	$(CC) $(CFLAGS) $(LD_FLAGS) -o $@ $<

build/binn/%: src/%.asm
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/binn/\1#p' <<< $<)
	$(CC) $(CFLAGS) $(LD_FLAGS) -o $@ $<

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
	clang++ -MJ $@ -Wall -std=c++20 $(LD_FLAGS) -o/dev/null $<

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(LD_FLAGS) -o/dev/null $<

compile_commands.json: $(patsubst src/%,build/json/%.json,$(c_SRCS)) $(patsubst src/%,build/json/%.json,$(cxx_SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find build/json -type f -name "*.json"` > compile_commands.json)

