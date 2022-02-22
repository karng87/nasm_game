libs_SRCS:=$(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')
LD_FLAGS:=-I include
all: libs/libglad.so

libs/%.o: src/%.c
	g++ -fPIC -Wall -c -o$@ $< $(LD_FLAGS) 

libs/libglad.so: $(patsubst src/%.c,libs/%.o,$(libs_SRCS))
	g++ -shared -Wall -o$@ $^

test/test.o: test/test.c
	g++ -Wall -c -o$@ $<

test/test.out: text/test.o
	# g++ -Wall -o test test.o -L . -ladd -Wl,-rpath=.
	g++ -o$@ -L ./libs -l glad -Wl,-rpath=./libs $<

run: libglad.so test.out
	./$(word 2,$^)

echo:
	echo $(libs_SRCS)

clean: 
	rm *.out *.o *.so *.json

test/%.cpp.json: test/%.cpp
	clang++ -MJ $@ -Wall -std=c++20 -L. -ladd -o /dev/null $<

test/%.c.json: test/%.c
	clang -MJ $@ -Wall -L. -laddc -o /dev/null $<

compile_commands.json: libglad.so test.json
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find ./test -maxdepth 1 -type f -name "*.json"` > compile_commands.json)

