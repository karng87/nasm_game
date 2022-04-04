vulkan_LD := -lglfw -lvulkan -ldl -lpthread -lxcb -lX11 -lX11-xcb -lxkbcommon -lXxf86vm -lXrandr -lXi
mathgl_LD := -lmgl2-qt5 -lmgl2

jm_I:= -Ilibs/include
jm_L := -Llibs/build
jmc_l := -ljmc
jm_l := -ljm
jma_l := -ljma
Wl_rpath := -Wl,-rpath libs/build #-Wl,-rpath build/libs

I := $(jm_I)
L := $(jm_L)
lc := $(jmc_l) $(mathgl_LD) $(vulkan_LD)
lcxx := $(jm_l)$(mathgl_LD) $(vulkan_LD)
lasm := $(jma_l) $(vulkan_LD)

CFLAGS := -g -Wall $(I)
CXXFLAGS := $(CFLAGS)
LDFLAGS := $(L) $(lc) $(Wl_rpath)
LDXXFLAGS := $(L) $(lcxx) $(Wl_rpath)

SRC_C := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test.c')
SRC_CXX := $(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '.*/test.cpp')
SRC_ASM := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test.c')

.PHONY: compile_commands.json all run runc runasm clean echo

all: build_library $(patsubst src/%,build/%.out,$(SRC_C) $(SRC_CXX) $(SRC_ASM))

build_library:
	$(MAKE) -C libs


build/obj/%.asm.o: src/%.asm
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/obj/\1#p' <<< $<)
	nasm -felf64 -o$@ $<
build/%.asm.out: build/obj/%.asm.o
	gcc $(LDFLAGS) -o $@ $<

runasm: build_library $(patsubst src/%,build/%.out,$(SRC_C))
	./$(word 2,$^)


build/%.c.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	gcc -g -Wall $(CFLAGS) $(LDFLAGS) -o $@ $<

runc: build_library build/main.c.out
	./build/main.c.out

build/%.cpp.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	g++ -g -Wall -std=c++20 $(CXXFLAGS) $(LDXXFLAGS) -o $@ $< 

run: build_libarary $(patsubst src/%,build/%.out,$(SRC_CXX))
	./$(word 2,$^)


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
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find build -type f -name "*.json"` > compile_commands.json)

