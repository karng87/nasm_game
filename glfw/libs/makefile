c_SRCS:=$(shell find -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')
cxx_SRCS:=$(shell find -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
nasm_SRCS:=$(shell find -type f -regextype posix-extended -regex '.*\.asm' -and -not -regex '\./test.asm')

all: libaddc.so libadd.so test.c.out test.cpp.out

%.asm.o: %.asm
	nasm -felf64 -o$@ $<

libaddasm.so: $(patsubst %,%.o,$(nasm_SRCS))
	gcc -shared -Wall -o$@ $^

test.asm.o: test.asm
	nasm -felf64 -o$@ $<
test.asm.out: test.asm.o
	# gcc -o test test.o -L . -ladd -Wl,-rpath=.
	gcc -Wall -o$@ -L. -laddasm $<

%.c.o: %.c
	gcc -fPIC -Wall -c -o$@ $<

libaddc.so: $(patsubst %,%.o,$(c_SRCS))
	gcc -shared -Wall -o$@ $^

test.c.o: test.c
	# gcc -Wall -c -o$@ $<
	gcc -Wall -c -o$@ $<
test.c.out: test.c.o
	# gcc -o test test.o -L . -ladd -Wl,-rpath=.
	gcc -Wall -o$@ -L. -laddc $<

%.cpp.o: %.cpp
	g++ -fPIC -Wall -c -o$@ $<
libadd.so: $(patsubst %,%.o,$(cxx_SRCS))
	g++ -shared -Wall -o$@ $^

test.cpp.o: test.cpp
	g++ -Wall -c -o$@ $<
test.cpp.out: test.cpp.o
	# g++ -Wall -o test test.o -L . -ladd -Wl,-rpath=.
	g++ -o$@ -L. -ladd $<

runc: libaddc.so test.c.out
	LD_LIBRARY_PATH+=. ./$(word 2,$^)

run: libadd.so test.cpp.out
	LD_LIBRARY_PATH+=. ./$(word 2,$^)

echo:
	echo $(c_SRCS)

clean: 
	rm *.out *.o *.so *.json

%.cpp.json: %.cpp
	clang++ -MJ $@ -Wall -std=c++20 -L. -ladd -o /dev/null $<

%.c.json: %.c
	clang -MJ $@ -Wall -L. -laddc -o /dev/null $<

compile_commands.json: libaddc.so libadd.so test.c.json test.cpp.json
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find ./ -maxdepth 1 -type f -name "*.json"` > compile_commands.json)

