CC=clang
CFLAGS=-g -Wall
CXX=clang++
CXXFLAGS=-g -Wall -std=c++20
c_SRCS=$(notdir $(shell find -type f -regextype posix-extended -regex '.*\.c$$' -and -not -regex '\./(lib|build)/.*'))
c_TARGETS=$(patsubst %.c,build/bin/%,$(c_SRCS))
cxx_SRCS=$(notdir $(shell find -type f -regextype posix-extended -regex '.*\.cpp$$' -and -not -regex '\./(lib|build)/.*'))
cxx_TARGETS=$(patsubst %.cpp,build/bin/%,$(cxx_SRCS))

lib_SRCS=$(notdir $(shell find src/lib -type f -regextype posix-extended -regex '.*\.(c|cxx|cpp)$$'))
lib_OBJS=$(patsubst %.cpp,build/lib/%.o,$(lib_SRCS))

LIB_so = build/lib/libmylib.so
LIB_a = build/lib/libmylib.a

.PHONEY: compile_commands all run clean echo

all:build/bin $(lib_OBJS) $(c_TARGETS) $(cxx_TARGETS)

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_a) $(LIB_so)
$(LIB_a): $(lib_OBJS)
	ar -cvrs $(LIB_a) $(c_lib_OBJS)
$(LIB_so): $(lib_OBJS)
	$(CC) $(CFLAGS) -shared -fpic -o $@ $^

build/lib/%.o: src/lib/%.c
	$(CC) $(CFLAGS) -o $@ -c $<

build/lib/%.o: src/lib/%.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<

build/bin/%: src/%.c
	$(CC) $(CFLAGS) -o $@ $<

build/bin/%: src/%.cpp 
	$(CXX) $(CXXFLAGS) -o $@ $<

build/bin: 
	mkdir -p build/{bin,lib,test,pdf}

run: $(cxx_TARGETS)
ifdef args 
	./$(word 3,$^) $(args)
else
	./$(word 3,$^) 
endif

echo:
	echo $(cxx_SRCS)
	echo $(cxx_TARGETS)
	echo "This is cxx"

tmp := $(shell find . -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
	rm $(tmp)

compile_commands:
	make --no-print-directory --always-make --dry-run | sed -En '/\.(c|cpp)\s*$$/p' | jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' > compile_commands.json

# https://www.youtube.com/watch?v=JarMkGWTF8Y&t=88s

tex_SRCS := $(notdir $(shell find -maxdepth 1 -type f -name "*.tex"))
tex_BINS:= $(patsubst %.tex,build/pdf/%.pdf,$(tex_SRCS))

build/pdf/%.pdf: %.tex
	pdflatex --jobname=$(patsubst %.tex,build/pdf/%, $<) $<

pdf :$(patsubst %.tex,build/pdf/%.pdf, $(tex_SRCS))
	@nohup zathura $(word 1, $^) &

