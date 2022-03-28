#I_x := -I./external/include -L./external/libs
#L_x := -L./external/libs
#l_j :=
#LD_x :=$(I_x) $(L_x) $(l_x)

j_I := -I./libs/include
j_L := -L./libs

j_lc := -ljc
j_l := -lj

j_CFLAGS := $(j_I) $(j_L)

j_LD_FLAGS := $(j_lc)
j_LDXX_FLAGS := $(j_l)


p_I := -I./src/include
p_L := -L./build/libs

p_lc := -lpc
p_l := -lp

p_CFLAGS := $(p_I) $(p_L)

p_LDFLAGS := $(p_lc)
p_LDXXFLAGS := $(p_l)


CFLAGS :=
LDFLAGS := -lmgl2 -lmgl2-fltk -lmgl2-glut -lmgl2-qt5

CXXFLAGS :=
LDXXFLAGS := -lmgl2 -lmgl2-fltk -lmgl2-glut -lmgl2-qt5


SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')
LIBS := $(shell find libs/src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '\./test.cpp')
C_LIBS := $(shell find libs/src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '\./test.c')

all: $(patsubst src/%,build/%.out,$(SRCS) $(C_SRCS))

libs/build/%.c.o: libs/src/%.c
	@mkdir -p $(shell sed -En 's#libs/src/(.*/)*.+#libs/build/\1#p' <<< $<)
	gcc -fPIC -Wall $(I_j) -c -o$@ $<

libs/libjc.so: $(patsubst libs/src/%.c,libs/build/%.c.o,$(C_LIBS))
	gcc -shared -Wall -o$@ $^


build/%.c.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	gcc -g -Wall $(CFLAGS) $(LDFLAGS) -o $@ $< 

crun: $(patsubst src/%,build/%.out,$(C_SRCS))
	LD_LIBRARY_PATH+=$$(pwd)/libs ./$(word 1,$^)


libs/build/%.cpp.o: libs/src/%.cpp
	@mkdir -p $(shell sed -En 's#libs/src/(.*/)*.+#libs/build/\1#p' <<< $<)
	g++ -fPIC -Wall $(I_j) -c -o$@ $<


libs/libj.so: $(patsubst libs/src/%.cpp,libs/build/%.cpp.o,$(LIBS))
	g++ -shared -Wall -o$@ $^


build/%.cpp.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	g++ -g -Wall -std=c++20 $(CXXFLAGS) $(LDXXFLAGS) -o $@ $< 

run: $(patsubst src/%,build/%.out,$(SRCS))
	LD_LIBRARY_PATH+=$$(pwd)/libs ./$(word 1,$^)


echo:
	echo $(C_LIBS)

tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|libs|test)/.*\.(hi|o|so|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')

clean:
	rm $(tmp)


build/json/%.cpp.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20  $(CXXFLAGS) $(LDXXFLAGS) -o/dev/null $<

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(CFLAGS) $(LDFLAGS) -o/dev/null $<

compile_commands.json:  $(patsubst src/%,build/json/%.json,$(C_SRCS)) $(patsubst src/%,build/json/%.json,$(SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)

