AS = nasm
AS_FLAGS = -felf64 -g -FDWARF

LD = ld
#LD_FLAGS 

SRC = test.asm
OBJ = test.o
TARGET = test

.PHONY: all run clean

all: $(TARGET)

%: %.o
		$(LD) $(LD_FLAGS) $< -o$@

%.o: %.asm
		$(AS) $(AS_FLAGS) $< -o$@

clean:
		rm $(OBJ) $(TARGET)

run:
		./$(TARGET)
