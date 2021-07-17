AS = nasm
ASFLAGS = -felf64 -Fdwarf -g

LD = ld
LDFLAGS = -melf_86_64

CC = clang
CXX =clang++

CCFLAGS = -c -g
CXXFLAGS = -c -g

CCLDFLAGS = -no-pie
CXXLDFLAGS = -no-pie

CSRCS:= $(shell find . -name "*.cpp" -o -name "*.c")
ASRCS:= $(shell find . -name "*.asm")
SRCS := $(CSRCS) $(ASRCS)

COBJS:= $(patsubst %.cpp,%.o,$(notdir $(CSRCS)))
AOBJS:= $(patsubst %.asm,%.o,$(notdir $(ASRCS)))
OBJS := $(AOBJS) $(COBJS)

TARGET = main-out

.PHONY: all clean run echo

all: $(TARGET)

$(TARGET): $(OBJS)
		$(CXX) $(CXXLDFLAGS) $^ -o $@

%.o: %.asm
		$(AS) $(ASFLAGS) $< -o $@

%.o: %.c
		$(CC) $(CCFLAGS) $< -o $@

%.o: %.cpp
		$(CXX) $(CXXFLAGS) $< -o $@

clean:
		@rm $(OBJS) $(TARGET)

run:
		./$(TARGET)

echo:
		echo $(SRCS)
