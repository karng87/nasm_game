
AS = nasm
ASFLAGS = -felf64 -g -Fdwarf

LD = ld
LDFLAGS = -emain

SRC = test.asm
OBJ = test.o
TARGET = test.out

.PHONY: all clean
MAKEFLAGS += --silent
.INTERMEDIATE:
.PRECIOUS:

all: $(TARGET)
		./$(TARGET)

%.o: %.asm
		$(AS) $(ASFLAGS) $< -o$@

%.out: %.o
		$(LD) $(LDFLAGS) $< -o$@

clean:
		-rm $(TARGET)
