external_I  := -I./external/build/include
external_ld := -L./external/build -l...

vulkan_ld := -lglfw -lvulkan -ldl -lpthread -lxcb -lX11 -lX11-xcb -lxcbcommon -lXxf86vm -lXrandr -lXi
mce_I := -I./libs/include
mce_ld := -L./libs -lmce
mcexx_ld := -L./libs -lmcexx


p_I := -I./src/include

CFLAGS := -g -Wall -Werror $(mce_I)
LDFLAGS := $(mce_ld)

CXXFLAGS := $(CFLAGS)
LDXXFLAGS := $(mcexx_ld)

SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '.*/test.cpp')
LIBS := $(shell find libs/src -type f -regextype posix-extended -regex '.*\.cpp' -and -not -regex '.*/test.cpp')
C_SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test.c')
C_LIBS := $(shell find libs/src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test.c')

all: libmce $(patsubst src/%,build/%.out,$(SRCS) $(C_SRCS))

.PHONY := libmce
libmce :
	make -f libs/makefile

build/%.c.out: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	gcc -g -Wall $(CFLAGS) $(LDFLAGS) -o $@ $< 

crun: $(patsubst src/%,build/%.out,$(C_SRCS))
	LD_LIBRARY_PATH+=$$(pwd)/build/libs ./$(word 1,$^)

ctest: 
	LD_LIBRARY_PATH+=$$(pwd)/build/libs ./libs/build/test

build/%.cpp.out: src/%.cpp 
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/\1#p' <<< $<)
	g++ -g -Wall -std=c++20 $(CXXFLAGS) $(LDXXFLAGS) -o $@ $< 

run: $(patsubst src/%,build/%.out,$(SRCS))
	LD_LIBRARY_PATH+=$$(pwd)/build/libs ./$(word 1,$^)


tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|libs|test)/.*\.(hi|o|so|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
echo:
	echo $(tmp)
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

