#I_x := -I./external/include -L./external/libs
#L_x := -L./external/libs
#l_j :=
#LD_x :=$(I_x) $(L_x) $(l_x)

rpath_j := -Wl,-rpath=./libs
I_j := -I./libs/include
L_j := -L./libs
l_j := -lj
l_jc := -ljc 
LD_j := $(I_j) $(L_j) $(l_j) $(rpath_j) -lmgl2-qt5 -lmgl2
LD_jc := $(I_j) $(L_j) $(l_jc) $(rpath_j) -lmgl2-qt5 -lmgl2

rpath_p := -Wl,-rpath=./build/libs
I_p := -I./src/inclucde
L_p := -L./build/libs
l_p := -lp
l_pc := -lpc
LD_p := $(I_p) $(L_p) $(l_p) $(rpath_p)
LD_pc := $(I_p) $(L_p) $(l_pc) $(rpath_p)

SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')
LIBS := $(shell find libs/src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_LIBS := $(shell find libs/src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')

all: libs/libjc.so $(patsubst src/%,build/%.out,$(SRCS) $(C_SRCS))

libs/build/%.c.o: libs/src/%.c
	@mkdir -p $(shell sed -En 's#libs/src/(.*/)*.+#libs/build/\1#p' <<< $<)
	gcc -fPIC -Wall $(I_j) -c -o$@ $<

libs/libjc.so: $(patsubst libs/src/%.c,libs/build/%.c.o,$(C_LIBS))
	gcc -shared -Wall -o$@ $^


build/%.c.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	gcc -g -Wall -o $@ $< $(LD_jc)

crun: $(patsubst src/%,build/%.out,$(C_SRCS))
	LD_LIBRARY_PATH+=$$(pwd)/libs ./$(word 1,$^)


libs/build/%.cpp.o: libs/src/%.cpp
	@mkdir -p $(shell sed -En 's#libs/src/(.*/)*.+#libs/build/\1#p' <<< $<)
	g++ -fPIC -Wall $(I_j) -c -o$@ $<


libs/libj.so: $(patsubst libs/src/%.cpp,libs/build/%.cpp.o,$(LIBS))
	g++ -shared -Wall -o$@ $^


build/%.cpp.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	g++ -g -Wall -std=c++20 -o $@ $< $(LD_j)

run: $(patsubst src/%,build/%.out,$(SRCS))
	LD_LIBRARY_PATH+=$$(pwd)/libs ./$(word 1,$^)


echo:
	echo $(C_LIBS)

tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|libs|test)/.*\.(hi|o|so|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
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

