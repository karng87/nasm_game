AS = nasm
ASFLAGS = -f elf64 -g -F dwarf

CXX = clang++
CXXFLAGS = -c -g -Wall -Werror -Wextra -gdwarf-2 -DDEBUG
CXXLDFLAGS = -lmyasm -fsanitize=address

BASIS = $(shell find -name "*.c" -o -name "*.cpp" -o -name "*.asm" | awk 'BEGIN{FS="[./]"}{print $$3}')

OBJS = $(patsubst %,%.o,$(BASIS))
TARGET = a.out

all: $(TARGET)

$(TARGET): $(OBJS)
			$(CXX) $(CXXLDFLAGS) $^

%.o: %.cpp
			$(CXX) $(CXXFLAGS) $< -o $@

%.o: %.asm
			$(AS) $(ASFLAGS) $<  -o $@

clean:
			@rm $(OBJS) $(TARGET)
run:
			./$(TARGET)
echo:
		@echo $(BASIS)

