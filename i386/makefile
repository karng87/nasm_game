AS=nasm
ASFLAGS= -wall -f bin

NASMS = $(notdir $(shell find src -type f -name "*.asm"))
LIBS := $(notdir $(shell find -type f -regextype posix-extended -regex 'libs/.+\.asm$$'))
TESTS := $(notdir $(shell find -type f -regextype posix-extended -regex 'tests/.+\.asm$$'))

BINS=$(patsubst %.asm,build/%.bin,$(NASMS))
OBJS=$(patsubst %.asm,build/libs/%.o,$(LIBS))
TESTBINS=$(patsubst %.asm,build/tests/%.o,$(TESTS))

TMP := $(shell find . -type f -regextype posix-extended -regex '(./build/.*)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')


LIB_S=build/libs/libmylib.so
LIB_A=build/libs/libmylib.a

all: $(BINS)

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_A)

run: $(BINS)
	qemu-system-i386 -drive file=$(word 1,$<),format=raw

build/%.bin: src/%.asm
	$(MAKE) mkdir
	$(AS) $(ASFLAGS) $< -o $@

build/%.bin: src/%.asm src/%.inc
	$(MAKE) build
	$(AS) $(ASFLAGS) $< -o $@

mkdir:
	mkdir -p build

clean:
	rm $(TMP)

echo:
	@echo $(TMP)
	@echo "This is the BootLoader"


