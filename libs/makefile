#I_x := -I./external/include -L./external/lib
#L_x := -L./external/lib
#l_j :=
#LD_x :=$(I_x) $(L_x) $(l_x)

I_j := -I./lib/include
L_j := -L./lib
l_j := -lj
l_jc := -ljc
LD_j := $(I_j) $(L_j) $(l_j)
LD_jc := $(I_j) $(L_j) $(l_jc)

I_p := -I./src/inclucde
L_p := -L./build/lib
l_p := -lp
l_pc := -lpc
LD_p := $(I_p) $(L_p) $(l_p)
LD_pc := $(I_p) $(L_p) $(l_pc)

SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')
LIBS := $(shell find lib/src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_LIBS := $(shell find lib/src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')

all: lib/libjc.so $(patsubst src/%,build/%.out,$(SRCS) $(C_SRCS))

lib/build/%.c.o: lib/src/%.c
	@mkdir -p $(shell sed -En 's#lib/src/(.*/)*.+#lib/build/\1#p' <<< $<)
	gcc -fPIC -Wall $(I_j) -c -o$@ $<

lib/libjc.so: $(patsubst lib/src/%.c,lib/build/%.c.o,$(C_LIBS))
	gcc -shared -Wall -o$@ $^


build/%.c.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	gcc -g -Wall -o $@ $< $(LD_jc)

crun: $(patsubst src/%,build/%.out,$(C_SRCS))
	LD_LIBRARY_PATH+=$$(pwd)/lib. ./$(word 1,$^)


lib/build/%.cpp.o: lib/src/%.cpp
	@mkdir -p $(shell sed -En 's#lib/src/(.*/)*.+#lib/build/\1#p' <<< $<)
	g++ -fPIC -Wall $(I_j) -c -o$@ $<


lib/libj.so: $(patsubst lib/src/%.cpp,libs/build/%.cpp.o,$(LIBS))
	g++ -shared -Wall -o$@ $^


build/%.cpp.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	g++ -g -Wall -std=c++20 -o $@ $< $(LD_j)

run: $(patsubst src/%,build/%.out,$(SRCS))
	LD_LIBRARY_PATH+=$$(pwd)/lib. ./$(word 1,$^)


echo:
	echo $(C_LIBS)

tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|lib|test)/.*\.(hi|o|so|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
	rm $(tmp)


build/json/%.cpp.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20 $(LD_j) -o/dev/null $<

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(LD_jc) -o/dev/null $<

compile_commands.json:  $(patsubst src/%,build/json/%.json,$(C_SRCS)) $(patsubst src/%,build/json/%.json,$(SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)

