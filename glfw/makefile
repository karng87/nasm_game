# L_FLAGS:= -L./build/libs -lmylibc -lmylib -lglfw -ldl
L_FLAGS:= -L./build/libs -lmylibc -lglfw -ldl
I_FLAGS:=-I./external/include -Isrc/include
LD_FLAGS:=$(I_FLAGS) $(L_FLAGS)

CC:=gcc
CFLAGS:=-g -Wall
lib_fPIC_CFLAGS:=-g -Wall -c -fPIC
lib_shared_LD_CFLAGS:=-shared

CXX:=g++
CXXFLAGS:=-g -Wall
lib_fPIC_CXXFLAGS:=-g -Wall -c -fPIC
lib_shared_LD_CXXFLAGS:=-shared

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
nasm_TARGETS=$(patsubst src/%.asm,build/nbin/%,$(nasm_SRCS))

as_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.S$$' -and -not -regex '\./(lib|build)/.*')
as_TARGETS=$(patsubst src/%.asm,build/abin/%,$(as_SRCS))

c_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.c$$' -and -not -regex '\./(lib|build)/.*')
c_TARGETS=$(patsubst src/%.c,build/cbin/%,$(c_SRCS))
cxx_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.cpp$$' -and -not -regex '\./(lib|build)/.*')
cxx_TARGETS=$(patsubst src/%.cpp,build/cbin/%,$(cxx_SRCS))

c_external_SRCS=$(shell find external/src -type f -regextype posix-extended -regex '.*\.c$$')
c_external_OBJS=$(patsubst external/src/%.c,build/libs/%.o,$(c_external_SRCS))

cxx_external_SRCS=$(shell find external/src -type f -regextype posix-extended -regex '.*\.cpp$$')
cxx_external_OBJS=$(patsubst external/src/%.cpp,build/libs/%.o,$(cxx_external_SRCS))

c_lib_SRCS=$(shell find libs -type f -regextype posix-extended -regex '.*\.c$$')
c_lib_OBJS=$(patsubst src/libs/%.c,build/libs/%.o,$(c_lib_SRCS))

nasm_lib_SRCS=$(shell find libs -type f -regextype posix-extended -regex '.*\.asm$$')
nasm_lib_OBJS=$(patsubst libs/%.asm,build/libs/%.o,$(nasm_lib_SRCS))

lib_SRCS=$(shell find libs -type f -regextype posix-extended -regex '.*\.cpp$$')
lib_OBJS=$(patsubst libs/%.cpp,build/libs/%.o,$(lib_SRCS))

LIB_so = build/libs/libmylib.so
LIB_a = build/libs/libmylib.a
c_LIB_so = build/libs/libmylibc.so
c_LIB_a = build/libs/libmylibc.a

.PHONY: libs compile_commands.json ccompile_commands.json all run clean echo

all: libs
	$(MAKE) $(c_TARGETS)
	$(MAKE) $(cxx_TARGETS)
libs: $(c_LIB_a) $(c_LIB_so) $(LIB_a) $(LIB_so)

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_a) $(LIB_so)

$(LIB_a): $(lib_OBJS)
	ar -cvrs $@ $^
$(LIB_so): $(lib_OBJS)
	$(CXX) -Wall -O2 -DNDEBUG -shared -o $@ $^

$(c_LIB_a): $(c_lib_OBJS) $(c_external_OBJS) $(nasm_lib_OBJS)
	ar -cvrs $@ $^
$(c_LIB_so): $(c_lib_OBJS) $(c_external_OBJS) $(nasm_lib_OBJS)
	$(CC) -Wall -O2 -DNDEBUG -shared -o $@ $^

build/libs/%.o: libs/%.nasm
	@mkdir -p $(shell sed -En 's#libs/(.*/)*.+#build/libs/\1#p' <<< $<)
	$(NASM) $(NASMFLAGS) -o $@ -c $<

build/libs/%.o: external/src/%.c
	@mkdir -p $(shell sed -En 's#external/src/(.*/)*.+#build/libs/\1#p' <<< $<)
	$(CC) $(CCFLAGS) -fPIC -Iexternal/include -o $@ -c $<

build/libs/%.o: libs/%.c
	@mkdir -p $(shell sed -En 's#libs/(.*/)*.+#build/libs/\1#p' <<< $<)
	$(CC) $(CFLAGS) -fPIC -Iexternal/include -o $@ -c $<

build/libs/%.o: libs/%.cpp
	@mkdir -p $(shell sed -En 's#libs/(.*/)*.+#build/libs/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) -fPIC -Iexternal/include -o $@ -c $<

build/cbin/%: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/cbin/\1#p' <<< $<)
	$(CC) $(CFLAGS) $(LD_FLAGS) -o $@ $<

build/bin/%: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/bin/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) $(LD_FLAGS) -o $@ $<

build/abin/%: src/%.S
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/abin/\1#p' <<< $<)
	$(CC) $(CFLAGS) $(LD_FLAGS) -o $@ $<

build/nbin/%: src/%.asm
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/nbin/\1#p' <<< $<)
	$(CC) $(CFLAGS) $(LD_FLAGS) -o $@ $<

run: $(cxx_TARGETS)
ifdef args 
	LD_LIBRARY_PATH+=./build/libs ./$(word 1,$^) $(args)
else
	LD_LIBRARY_PATH+=./build/libs ./$(word 1,$^) 
endif

crun: $(c_TARGETS)
ifdef args 
	LD_LIBRARY_PATH+=./build/libs ./$(word 1,$^) $(args)
else
	LD_LIBRARY_PATH+=./build/libs ./$(word 1,$^) 
endif

echo:
	echo $(cxx_SRCS)
	echo $(cxx_TARGETS)
	echo "This is g++"

tmp := $(shell find . -type f,l -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
	rm $(tmp)

build/json/%.o.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
# 	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20  $(CXXFLAGS) $(LD_FLAGS) -o $(patsubst src/%.cpp,build/json/%.o,$<) $<

compile_commands.json: $(patsubst src/%.cpp,build/json/%.o.json,$(cxx_SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)
ccompile_commands.json:
	make --no-print-directory --always-make --dry-run | sed -En '/\.c\s*$$/p' | jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' > compile_commands.json

