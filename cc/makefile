CC=clang
CFLAGS=-g -Wall -lSDL2

c_SRCS=$(shell find src -type f -regextype posix-extended -regex '.*\.c$$' -and -not -regex '\./(lib|build)/.*')
c_TARGETS=$(patsubst src/%.c,build/bin/%,$(c_SRCS))

.PHONEY: compile_commands.json all run clean echo

all:compile_commands.json $(c_TARGETS)


build/bin/%: src/%.c
	@mkdir -p $(shell sed -En 's#src/(.*/)*.+#build/bin/\1#p' <<< $<)
	$(CC) $(CFLAGS) -o $@ $<

run: $(c_TARGETS)
ifdef args 
	./$(word 1,$^) $(args)
else
	./$(word 1,$^) 
endif

echo:
	echo $(c_SRCS)
	echo $(c_TARGETS)
	echo "This is CC"

tmp := $(shell find . -type f,l -regextype posix-extended -regex '(./compile_commands.json$$)|(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')
clean:
	rm $(tmp)

compile_commands.json:
	make --no-print-directory --always-make --dry-run | sed -En '/\.c\s*$$/p' | jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' > compile_commands.json


