CC=gcc
CFLAGS=-g -Wall
CXX=g++
CXXFLAGS=-g -Wall -std=c++20
c_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.c$$' -and -not -regex '\./(lib|build)/.*')
c_TARGETS=$(patsubst src/%.c,build/bin/%,$(c_SRCS))
cxx_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.cpp$$' -and -not -regex '\./(lib|build)/.*')
cxx_TARGETS=$(patsubst src/%.cpp,build/bin/%,$(cxx_SRCS))

lib_SRCS=$(shell find src/lib -type f -regextype posix-extended -regex '.*\.(c|cxx|cpp)$$')
lib_OBJS=$(patsubst src/lib/%.cpp,build/lib/%.o,$(lib_SRCS))

LIB_so = build/lib/libmylib.so
LIB_a = build/lib/libmylib.a

.PHONEY: compile_commands.json all run clean echo

all:compile_commands.json $(lib_OBJS) $(c_TARGETS) $(cxx_TARGETS)

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_a) $(LIB_so)
$(LIB_a): $(lib_OBJS)
	ar -cvrs $(LIB_a) $(c_lib_OBJS)
$(LIB_so): $(lib_OBJS)
	$(CC) $(CFLAGS) -shared -fpic -o $@ $^

build/lib/%.o: src/lib/%.c
	@mkdir -p $(shell sed -En 's#src/lib/(.*/)*.+#build/lib/\1#p' <<< $<)
	$(CC) $(CFLAGS) -o $@ -c $<

build/lib/%.o: src/lib/%.cpp
	@mkdir -p $(shell sed -En 's#src/lib/(.*/)*.+#build/lib/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) -o $@ -c $<

build/bin/%: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/bin/\1#p' <<< $<)
	$(CC) $(CFLAGS) -o $@ $<

build/bin/%: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/bin/\1#p' <<< $<)
	$(CXX) $(CXXFLAGS) -o $@ $<

build/bin: 
	mkdir -p build/{bin,lib,test}

run: $(cxx_TARGETS)
ifdef args 
	./$(word 1,$^) $(args)
else
	./$(word 1,$^) 
endif

echo:
	echo $(cxx_SRCS)
	echo $(cxx_TARGETS)
	echo "This is cxx"

tmp := $(shell find . -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
	rm $(tmp)

build/json/%.o.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20 -o $(patsubst src/%.cpp,build/obj/%.o,$<) $<

compile_commands.json: $(patsubst src/%.cpp,build/json/%.o.json,$(cxx_SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)

