#x_IL:= -I./external/include -L./external/libs
#x_lilbs :=
#x_FLAGS :=$(x_IL) $(x_lilbs)

#j_IL := -I./src/inclucde -I./libs/include -L./build/libs
#j_FLAGS :=$(j_IL) -lj -ljc

#l_FLAGS := -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi

#LDFLAGS := $(x_FLAGS) $(j_FLAGS) $(l_FLAGS)


SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')
LIBS := $(shell find libs/src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_LIBS := $(shell find libs/src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')


all: $(patsubst src/%,build/S/%.S,$(SRCS) $(C_SRCS)) $(patsubst src/%,build/%.out,$(SRCS) $(C_SRCS))

# .cfi in GAS for debugging stands for call frame information.
# to disable .cfi directive -fno-....
build/S/%.c.S: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/S/\1#p' <<< $<)
	gcc -S -O0 -fno-dwarf2-cfi-asm -fno-stack-protector -fno-asynchronous-unwind-tables -o$@ $< $(LDFLAGS)

S: $(patsubst src/%,build/S/%.S,$(C_SRCS))
	nvim ./$(word 1,$^)


init:
	mkdir -p {external/{include,libs},libs/{src,include},src}

build/libs/%.c.o: libs/%.c
	gcc -fPIC -Wall -c -g -o$@ $<

build/libs/libjc.so: $(patsubst libs/%.c,build/libs/%.c.o,$(C_LIBS))
	gcc -shared -Wall -g -o$@ $^


build/%.c.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	gcc -g -Wall -o $@ -g $< $(LDFLAGS)

crun: $(patsubst src/%,build/%.out,$(C_SRCS))
	LD_LIBRARY_PATH+=. ./$(word 1,$^)


build/libs/%.cpp.o: libs/%.cpp
	g++ -fPIC -Wall -c -o$@ -g  $<


build/libs/libj.so: $(patsubst libs/%.cpp,build/libs/%.cpp.o,$(LIBS))
	g++ -shared -Wall -o$@ -g $^


build/%.cpp.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	g++ -g -Wall -std=c++20 -o $@ -g $< $(LDFLAGS)

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

