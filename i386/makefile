# https://stanislavs.org/helppc/idx_interrupt.html
CC = gcc
CCFLAGS = 
GAS = as
GASFLAGS = 
LD = ld
LDFLAGS = --oformat binary -Ttext 0x7c00

NASM = nasm
NASMFLAGS = -wall -f bin

nasm_SRCS = $(notdir $(shell find src -type f -name "*.asm"))
gas_SRCS = $(notdir $(shell find src -type f -name "*.S"))
lib_nasm_SRCS := $(notdir $(shell find -type f -regextype posix-extended -regex 'libs/.+\.asm$$'))
lib_gas_SRCS := $(notdir $(shell find -type f -regextype posix-extended -regex 'libs/.+\.S$$'))
test_nasm_SRCS := $(notdir $(shell find -type f -regextype posix-extended -regex 'tests/.+\.asm$$'))
tex_SRCS := $(notdir $(shell find -maxdepth 1 -type f -name "*.tex"))

nasm_BINS=$(patsubst %.asm,build/%.bin,$(nasm_SRCS))
gas_BINS = $(patsubst %.S,build/gas/%.bin,$(gas_SRCS))
lib_nasm_OBJS=$(patsubst %.asm,build/libs/%.o,$(lib_nasm_SRCS))

tex_SRCS := $(notdir $(shell find -maxdepth 1 -type f -name "*.tex"))
tex_BINS:= $(patsubst %.tex,build/pdf/%.pdf,$(tex_SRCS))

TMP := $(shell find . -type f -regextype posix-extended -regex '(./build/.*)|(.*compile_commands.json$$)|(./(app|src|test)/.*(hi|o|out|aux|log|toc|nav|snm|lot|lof)$$)' -and -not -regex '.*(\.git|pack|dist.*)/.*')

LIB_S=build/libs/libmylib.so}
LIB_A=build/libs/libmylib.a}

all: $(nasm_BINS) $(gas_BINS) $(lib_nasm_OBJS) $(test_BINS) $(tex_BINS) compile_commands.json

release: CFLAGS=-Wall -O2 -DNDEBUG
release: clean
release: $(LIB_A)

nasm: $(nasm_BINS)
	qemu-system-i386 -drive file=$(word 1,$<),format=raw

gas: $(gas_BINS)
	qemu-system-i386 -drive file=$(word 1,$<),format=raw

build/%.bin: src/%.asm
	$(MAKE) mkdir
	$(NASM) $(NASMFLAGS) -o $@ $<

build/%.bin: src/%.asm src/%.inc
	$(MAKE) mkdir
	$(NASM) $(NASMFLAGS) -o $@ $<

build/gas/%.o: src/%.S
	$(MAKE) mkdirgas
	$(AS) $(ASFLAGS) -o $@ $<

build/gas/%.bin: build/gas/%.o
	$(MAKE) mkdirgas
	$(LD) $(LDFLAGS) -o $@ $^

mkdir: 
	mkdir -p build

mkdirgas:
	mkdir -p build/gas

compile_commands.json:
	make --no-print-directory --always-make --dry-run | sed -En '/\.c\s*$$/p' | jq -nR '[inputs|{directory:".", command:., file:match(" [^ ]+$$").string[1:]}]' > compile_commands.json


build/pdf/%.pdf: %.tex
	$(MAKE) mkdirpdf
	pdflatex --jobname=$(patsubst %.tex,build/pdf/%, $<) $<

mkdirpdf:
	mkdir -p build/pdf

pdf :$(patsubst %.tex,build/pdf/%.pdf, $(tex_SRCS))
	@nohup zathura $(word 1, $<) &

clean:
	rm $(TMP)

echo:
	@echo $(TMP)
	@echo "This is the BootLoader"

