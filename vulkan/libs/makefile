vulkan_LD := -lglfw -lvulkan -ldl -lpthread -lxcb -lX11 -lX11-xcb -lxkbcommon -lXxf86vm -lXrandr -lXi
CFLAGS := -g -MM -Wall -Werror 
Define := -D_DEBUG


SRCS := $(shell find src -type f -regextype posix-extended -regex '.*\.c' -and -not -regex '.*/test.c')

.PHONY: run echo clean

all: build/libmce.so build/test

build/obj/%.c.o: $(SRCS)
	@mkdir -p $(shell sed -En 's,src/(.*/)*.+,build/obj/\1,p' <<< $<)
	gcc -g -Wall -Werror -fPIC $(I) -c -o$@ $<

build/libmce.so: $(patsubst src/%.c,build/obj/%.c.o,$(SRCS))
	gcc -shared -Wall -o$@ $^

build/%: src/test.c 
	@mkdir -p $(shell sed -En 's,src/(.*/)*.+,build/\1,p' <<< $<)
	gcc -g -Wall -Werror -Lbuild -Wl,-rpath,. $(vulkan_LD) -o $@ $< 

run: build/test
	#LD_LIBRARY_PATH+=$$(pwd)/build 
	./build/test

tmp := $(shell find -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|libs|test)/.*\.(hi|o|so|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')

echo:
	echo $(SRCS)

clean:
	rm $(tmp)

build/json/%.c.json: src/%.c
	@mkdir -p $(shell sed -En 's,src/(.*/)*.+,build/json/\1,p' <<< $<)
	clang -MJ $@ -Wall -Lbuild -lmce $(vulkan_LD) -o/dev/null $<

compile_commands.json:  $(patsubst src/%,build/json/%.json,$(SRCS))
	$(shell sed -E -e '1s#^#[\n#' -e '$$s#,$$#\n]#' `find build -type f -name "*.json"` > compile_commands.json)
