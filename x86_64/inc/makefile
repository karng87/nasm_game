AS = nasm
LD = ld

TARGETS = test.out elf_i386-float_print.out args.out
TARGET_T = test.out
TARGET_A = args.out
TARGET_F = elf_i386-float_print.out

.PHONY: all clean t f
#MAKEFLAGS += --silent
MAKEFLAGS += --always-make
.INTERMEDIATE:
.PRECIOUS:

all: $(TARGETS)

test.out: test.o
		$(LD) -e main $< -o $@
		rm $<
test.o: test.asm
		$(AS) -f elf64 -g -F dwarf $< -o $@

args.o: args.asm
		$(AS) -f elf64 -g -F dwarf $< -o $@

args.out: args.o
		$(LD) -m elf_x86_64 -e main $< -o $@
		rm $<

elf_i386-float_print.o: elf_i386-float_print.asm
		$(AS) -felf32 -g -F dwarf $< -o $@

elf_i386-float_print.out: elf_i386-float_print.o
		$(LD) -m elf_i386 $< -o $@
		rm $<

clean:
		-rm $(TARGETS)

t:
		./$(TARGET_T)
f:
		./$(TARGET_F)
a:
		./$(TARGET_A)
