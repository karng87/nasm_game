CC=gcc
CFLAGS=-g -Wall -lSDL2
CXX=g++
CXXFLAGS=-g -Wall -std=c++20 -lSDL2

c_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.c$$' -and -not -regex 'src/(lib|clib|build)/.*')
c_TARGETS=$(patsubst src/%.c,build/cbin/%,$(c_SRCS))
cxx_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.cpp$$' -and -not -regex 'src/(lib|clib|build)/.*')
cxx_TARGETS=$(patsubst src/%.cpp,build/bin/%,$(cxx_SRCS))

c_lib_SRCS=$(shell find src/clib -type f -regextype posix-extended -regex '.*\.c$$')
c_lib_OBJS=$(patsubst src/clib/%.c,build/clib/%.o,$(c_lib_SRCS))
lib_SRCS=$(shell find src/lib -type f -regextype posix-extended -regex '.*\.cpp$$')
lib_OBJS=$(patsubst src/lib/%.cpp,build/lib/%.o,$(lib_SRCS))

LIB_so = build/lib/libmylib.so
LIB_a = build/lib/libmylib.a
c_LIB_so = build/clib/libmylib.so
c_LIB_a = build/clib/libmylib.a

.PHONEY: compile_commands.json ccompile_commands.json all run clean echo

all: $(c_TARGETS)

lib: $(c_LIB_a) $(c_LIB_so) $(LIB_a) $(LIB_so)

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_a) $(LIB_so)

$(LIB_a): $(lib_OBJS)
	ar -cvrs $(LIB_a) $(c_lib_OBJS)
$(LIB_so): $(lib_OBJS)
	$(CC) $(CFLAGS) -shared -o $@ $^

$(c_LIB_a): $(c_lib_OBJS)
	ar -cvrs $(LIB_a) $(c_lib_OBJS)
$(c_LIB_so): $(c_lib_OBJS)
	$(CC) $(CFLAGS) -shared -o $@ $^

build/clib/%.o: src/clib/%.c
	@mkdir -p $(shell sed -En 's#src/clib/(.*/)*.+#build/clib/\1#p' <<< $<)
	$(CC) $(CFLAGS) -fPIC -o $@ -c $<

build/lib/%.o: src/lib/%.cpp
	@mkdir -p $(shell sed -En 's#src/lib/(.*/)*.+#build/lib/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) -fPIC -o $@ -c $<

build/cbin/%: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/cbin/\1#p' <<< $<)
	$(CC) $(CFLAGS) -o $@ $<

build/bin/%: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/bin/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) -o $@ $<

run: $(cxx_TARGETS)
ifdef args 
	LD_LIBRARY_PATH+=./build/libs ./$(word 1,$^) $(args)
else
	LD_LIBRARY_PATH+=./build/libs ./$(word 1,$^) 
endif

crun: $(c_TARGETS)
ifdef args 
	LD_LIBRARY_PATH+=./build/clibs ./$(word 1,$^) $(args)
else
	LD_LIBRARY_PATH+=./build/clibs ./$(word 1,$^) 
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
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20  $(CXXFLAGS) -o $(patsubst src/%.cpp,build/obj/%.o,$<) $<

compile_commands.json: $(patsubst src/%.cpp,build/json/%.o.json,$(cxx_SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)
ccompile_commands.json:
	make --no-print-directory --always-make --dry-run | sed -En '/\.c\s*$$/p' | jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' > compile_commands.json

