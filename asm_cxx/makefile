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
LD_FLAGS := -melf_x86_64 -emain -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
	 -L /usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/ \
		/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtbegin.o \
		/usr/lib/gcc/x86_64-pc-linux-gnu/11.1.0/crtend.o \
		/lib/crt1.o \
		/lib/crti.o \
		/lib/crtn.o
nasm_shared_SRCS:=$(shell find src -type f -regextype posix-extended -regex '.*\.asm$$' -and -not -regex 'src/((lib|build)/.*)|(.*static.*)')
nasm_static_SRCS:=$(shell find src -type f -regextype posix-extended -regex '.*static.*\.asm$$' -and -not -regex 'src/((lib|build)/.*)')
nasm_SRCS:=$(shell find src -type f -regextype posix-extended -regex '.*\.asm$$' -and -not -regex 'src/(lib|build)/.*')
nasm_TARGETS:=$(patsubst src/%.asm,build/nasm/%,$(nasm_SRCS))
nasm_lib_SRCS=$(shell find src/lib -type f -regextype posix-extended -regex '.*\.asm$$')
nams_lib_OBJS=$(patsubst src/lib/%.asm,build/nasm/lib/%.o,$(nasm_lib_SRCS))

as_SRCS:=$(shell find src -type f -regextype posix-extended -regex '.*\.S$$' -and -not -regex 'src/(lib|build)/.*')
as_TARGETS:=$(patsubst src/%.asm,build/as/%,$(as_SRCS))
as_lib_SRCS:=$(shell find src/lib -type f -regextype posix-extended -regex '.*\.S$$')
am_lib_OBJS:=$(patsubst src/lib/%.S,build/as/lib/%.o,$(as_lib_SRCS))

c_SRCS:=$(shell find src -type f -regextype posix-extended -regex '.*\.c$$' -and -not -regex 'src/(lib|build)/.*')
c_TARGETS:=$(patsubst src/%.c,build/c/%,$(c_SRCS))
c_lib_SRCS:=$(shell find src/lib -type f -regextype posix-extended -regex '.*\.S$$')
c_lib_OBJS:=$(patsubst src/lib/%.S,build/c/lib/%.o,$(c_lib_SRCS))

cxx_SRCS:=$(shell find src -type f -regextype posix-extended -regex '.*\.cpp$$' -and -not -regex 'src/(lib|build)/.*')
cxx_TARGETS:=$(patsubst src/%.cpp,build/cxx/%,$(cxx_SRCS))
cxx_lib_SRCS:=$(shell find src/lib -type f -regextype posix-extended -regex '.*\.cpp$$')
cxx_lib_OBJS:=$(patsubst src/lib/%.cpp,build/cxx/lib/%.o,$(cxx_lib_SRCS))

c_LIB_so := build/c/lib/libmylib.so
cxx_LIB_so := build/cxx/lib/libmylib.so
nasm_LIB_so := build/nasm/lib/libmylib.so
as_LIB_so := build/as/lib/libmylib.so

c_LIB_a := build/c/lib/libmylib.a
cxx_LIB_a := build/cxx/lib/libmylib.a
nasm_LIB_a := build/nasm/lib/libmylib.a
as_LIB_a := build/as/lib/libmylib.a

.PHONEY: compile_commands.json all run clean echo

all:$(nasm_TARGETS)

release: CFLAGS=-Wall -O2 -DNDEBUG

build/c/lib/%.o: src/lib/%.c
	@mkdir -p $(shell sed -En 's#src/lib/(.*/)*.+#build/c/lib/\1#p' <<< $<)
	$(CC) $(lib_fPIC_CFLAGS) -o $@ $<
$(c_LIB_a): $(c_lib_OBJS)
	ar -cvrs $@ $^
$(c_LIB_so): $(c_lib_OBJS)
	$(CC) $(lib_shared_LD_CFLAGS) -o $@ $^

build/as/lib/%.o: src/lib/%.S
	@mkdir -p $(shell sed -En 's#src/lib/(.*/)*.+#build/as/lib/\1#p' <<< $<)
	$(AS) $(ASFLAGS) -o $@ -c $<
$(as_LIB_a): $(as_lib_OBJS)
	ar -cvrs $@ $^
$(as_LIB_so): $(as_lib_OBJS)
	$(CC) $(lib_shared_LD_CFLAGS) -o $@ $^

build/nasm/lib/%.o: src/lib/%.asm
	@mkdir -p $(shell sed -En 's#src/lib/(.*/)*.+#build/nasm/lib/\1#p' <<< $<)
	$(NASM) $(NASMFLAGS) -o $@ -c $<
$(nasm_LIB_a): $(nasm_lib_OBJS)
	ar -cvrs $@ $^
$(nasm_LIB_so): $(nasm_lib_OBJS)
	$(CC) $(lib_shared_LD_CFLAGS) -o $@ $^

build/cpp/lib/%.o: src/lib/%.cpp
	@mkdir -p $(shell sed -En 's#src/lib/(.*/)*.+#build/cpp/lib/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) -o $@ -c $<
$(cxx_LIB_a): $(cxx_lib_OBJS)
	ar -cvrs $@ $^
$(cxx_LIB_so): $(cxx_lib_OBJS)
	$(CXX) $(lib_shared_LD_CXXFLAGS) -o $@ $^

build/c/%: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/c/\1#p' <<< $<)
	$(CC) $(CFLAGS) -o $@ $<

build/nasm/%.o: src/%.asm
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/nasm/\1#p' <<< $<)
	$(NASM) $(NASMFLAGS) -o $@ $<
build/nasm/%-no-pie: build/nasm/%-no-pie.o
	$(CC) $(no_pie_LD_CFLAGS) -o $@ $<
build/nasm/%: build/nasm/%.o
	$(CC) $(CFLAGS) -o $@ $<

build/as/%.o: src/%.S
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/as/\1#p' <<< $<)
	$(AS) $(FLAGS) -o $@ $<
build/as/%: build/as/%.o
	$(LD) $(LDFLAGS) -o $@ $<

build/cpp/%: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/cpp/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) -o $@ $<

run: $(nasm_TARGETS)
ifdef args 
	LD_LIBRARY_PATH+=./build/nasm ./$(word 1,$^) $(args)
else
	./$(word 1,$^) 
endif

echo:
	echo $(nasm_SRCS)
	echo $(nasm_TARGETS)
	echo "This is Nasm"

tmp := $(shell find . -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
	rm $(tmp)

build/json/%.o.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20 -o $(patsubst src/%.cpp,build/obj/%.o,$<) $<

compile_commands.json: $(patsubst src/%.cpp,build/json/%.o.json,$(cxx_SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)


