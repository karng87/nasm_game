
l_vulkan := -lvulkan -lxcb -lX11 -lX11-xcb -lxkbcommon

I_j := -Ilibs/include
L_j := -Llibs/build
l_jc := -ljc
l_j := -lj
l_ja := -lja
Wl_rpath := -Wl,-rpath libs/build #-Wl,-rpath build/libs
D := -D_DEBUG -DEXPORT

CFLAGS := -g -Wall $(I_j) $(D)
CXXFLAGS := $(CFLAGS)
LDFLAGS := $(L_j) $(l_jc) $(l_vulkan) $(Wl_rpath)
LDXXFLAGS := $(L_j) $(l_j) $(l_vulkan) $(Wl_rpath)

SRC_C := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test\.c')
SRC_CXX := $(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '.*/test\.cpp')
SRC_ASM := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test\.asm')

.PHONY: compile_commands.json all run runc runasm clean echo

all: build_library $(patsubst src/%,build/%.out,$(SRC_C) $(SRC_CXX) $(SRC_ASM)) compile_commands.json

tex_SRCS := $(notdir $(shell find -maxdepth 1 -type f -name "*.tex"))
tex_BINS:= $(patsubst %.tex,%.pdf,$(tex_SRCS))

build/pdf/%.pdf: %.tex
	@mkdir -p build/pdf
	pdflatex --jobname=$(patsubst %.tex,build/pdf/%, $<) $<

pdf :$(patsubst %.tex,build/pdf/%.pdf, $(tex_SRCS))
	@nohup zathura $(word 1, $^) &

build_library:
	$(MAKE) -C libs

build/obj/%.asm.o: src/%.asm
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	nasm -felf64 -o$@ $<
build/%.asm.out: build/obj/%.asm.o
	gcc $(LDFLAGS) -o $@ $<

runasm: build_library $(patsubst src/%,build/%.out,$(SRC_ASM))
	./build/main.asm.out


build/%.c.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	gcc -g -Wall $(CFLAGS) $(LDFLAGS) -o $@ $<

runc: build_library $(patsubst src/%,build/%.out,$(SRC_C))
	./build/entry.c.out

build/%.cpp.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	g++ -g -Wall -std=c++20 $(CXXFLAGS) $(LDXXFLAGS) -o $@ $< 

run: build_libarary $(patsubst src/%,build/%.out,$(SRC_CXX))
	./build/main.cpp.out


tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|libs|test)/.*\.(hi|o|so|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
echo:
	$(MAKE) -C libs echo
	echo $(tmp)
clean:
	$(MAKE) -C libs clean
	rm $(tmp)


build/json/%.cpp.json: src/%.cpp
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang++ -MJ $@ -Wall -std=c++20  $(CXXFLAGS) $(LDXXFLAGS) -o/dev/null $<

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/json/\1#p' <<< $<)
	clang -MJ $@ -Wall $(CFLAGS) $(LDFLAGS) -o/dev/null $<

compile_commands.json:  $(patsubst src/%,build/json/%.json,$(SRC_C)) $(patsubst src/%,build/json/%.json,$(SRC_CXX))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find build/json -type f -regextype posix-extended -regex ".*/.*\.json" -and -not -regex ".*/.*\.compile_commands.json"` > compile_commands.json)

