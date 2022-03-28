#I_x := -I./external/include -L./external/libs
#L_x := -L./external/libs
#l_j :=
#LD_x :=$(I_x) $(L_x) $(l_x)

I_j := -I./libs/include
L_j := -L./libs
l_j := -lj
l_jc := -ljc
C_j := $(I_j) $(L_j)
L_j := $(l_j)
L_jc := $(l_jc)

I_p := -I./src/include
L_p := -L./build/libs
l_p := -lp
l_pc := -lpc
C_p := $(I_p) $(L_p)
L_p := $(l_p)
L_pc := $(l_pc)

CFLAGS := $(C_jc) $(C_pc)
LDFLAGS := -lplplot

CXXFLAGS := $(C_j) $(C_p)
LDXXFLAGS := $(L_j) $(L_p)

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
	clang++ -MJ $@ -Wall -std=c++20 $(LD_j) -o/dev/null $<

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(LD_jc) -o/dev/null $<

compile_commands.json:  $(patsubst src/%,build/json/%.json,$(C_SRCS)) $(patsubst src/%,build/json/%.json,$(SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find -type f -name "*.json"` > compile_commands.json)

