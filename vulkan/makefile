external_I  := -I./external/build/include
external_ld := -L./external/build -l...

lib_I:=libs/include
lib_L:=libs/build
libc_l = jc
libcxx_l = j
libasm_l = ja
Wl_rpath = -Wl,-rpath build/libs -Wl,-rpath libs/build

I := -I$(lib_I)
L := -L$(lib_L)
lc := -l$(libc_l)
lcxx := -l$(lib_l)
lasm := -l$(libasm_l)

CFLAGS := -g -Wall -Werror $(I)
CXXFLAGS := $(CFLAGS)
LDFLAGS := $(L) $(lc) $(Wl_rpath)
LDXXFLAGS := $(L) $(lcxx) $(Wl_rpath)

SRC_C := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test.c')
SRC_CXX := $(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '.*/test.cpp')
SRC_ASM := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test.c')

.PHONY: compile_commands.json all run runc runasm clean echo

all: build_library $(patsubst src/%,build/%.out,$(SRC_C) $(SRC_CXX) $(SRC_ASM))

build_library:
	$(MAKE) -C libs

build/%.c.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	gcc -g -Wall $(CFLAGS) $(LDFLAGS) -o $@ $< 

runc: build_library $(patsubst src/%,build/%.out,$(SRC_C))
	LD_LIBRARY_PATH+=$$(pwd)/build/libs ./$(word 2,$^)

build/%.cpp.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	g++ -g -Wall -std=c++20 $(CXXFLAGS) $(LDXXFLAGS) -o $@ $< 

run: build_libarary $(patsubst src/%,build/%.out,$(SRC_CXX))
	LD_LIBRARY_PATH+=$$(pwd)/build/libs ./$(word 2,$^)


tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|libs|test)/.*\.(hi|o|so|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
echo:
	$(MAKE) -C libs echo
	echo $(tmp)
clean:
	$(MAKE) -C libs clean
	rm $(tmp)


build/json/%.cpp.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20  $(CXXFLAGS) $(LDXXFLAGS) -o/dev/null $<

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(CFLAGS) $(LDFLAGS) -o/dev/null $<

compile_commands.json:  $(patsubst src/%,build/json/%.json,$(SRC_C)) $(patsubst src/%,build/json/%.json,$(SRC_CXX))
	$(MAKE) -C libs compile_commands.json
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)

