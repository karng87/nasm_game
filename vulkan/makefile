LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi
SRCS:=$(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_SRCS:=$(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')
LIBS:=$(shell find libs -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_LIBS:=$(shell find libs -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')


all: $(patsubst src/%,build/%.out,$(SRCS))


build/libs/%.c.o: libs/%.c
	gcc -fPIC -Wall -c -o$@ $<


build/libs/libmylibc.so: $(patsubst libs/%.c,build/libs/%.c.o,$(C_LIBS))
	gcc -shared -Wall -o$@ $^


build/%.c.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	gcc -g -Wall -o $@ $< $(LDFLAGS)


build/libs/%.cpp.o: libs/%.cpp
	g++ -fPIC -Wall -c -o$@ $<


build/libs/libmylib.so: $(patsubst libs/%.cpp,build/libs/%.cpp.o,$(LIBS))
	g++ -shared -Wall -o$@ $^


build/%.cpp.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	g++ -g -Wall -std=c++20 -o $@ $< $(LDFLAGS)


runc: $(patsubst src/%,build/%.out,$(C_SRCS))
	LD_LIBRARY_PATH+=. ./$(word 1,$^)

run: $(patsubst src/%,build/%.out,$(SRCS))
	LD_LIBRARY_PATH+=. ./$(word 1,$^)


echo:
	echo $(SRCS)

tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
	rm $(tmp)


build/json/%.cpp.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20 $(LDFLAGS) -o/dev/null $<

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(LDFLAGS) -o/dev/null $<

compile_commands.json:  $(patsubst src/%,build/json/%.json,$(C_SRCS))$(patsubst src/%,build/json/%.json,$(SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)

