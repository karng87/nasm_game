AS = nasm
FLAGS = -felf64
LD = ld
LD_FLAGS = -melf_x86_64 -emain

TARGET = build/tuto.out

OBJS := $(patsubst %.nasm,build/%.o,$(notdir $(shell find -name "*.nasm")))
TARGETS := $(patsubst %.o,%.out,$(OBJS))

.PHONY: all clean run
all : $(TARGETS)

build/%.out : build/%.o
				$(LD) $(LDFLAGS) $< -o $@
				
%.out : %.o
				$(LD) $(LDFLAGS) $< -o $@

build/%.o : src/%.nasm
				$(AS) $(FLAGS) $< -o $@

build/%.o : %.nasm
				$(AS) $(FLAGS) $< -o $@

clean:
		rm $(TARGET)

run:
		.$(TARGET)
