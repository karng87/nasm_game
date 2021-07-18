CC = clang
FPIC = -fPIC
CCFLAGS = -c
CCDEBUG= -c -gdwarf-2 -Wall -Werror -Wextra -DDEBUG

SHARED = -shared
CCLDFALAGS = -fsanitize=address -lmyasmprint

CXX = clang++

AS = nasm
ASFLAGS = -felf64
ASDEBUG = -gdwarf

C_SRCS := $(shell find src -name "*.c")
CXX_SRCS := $(shell find src -name "*.cpp")
A_SRCS := $(shell find src -name "*.asm")

SRCS := $(C_SRCS) $(A_SRCS)

C_OBJS := $(patsubst %.c,%.o,$(C_SRCS))
A_OBJS := $(patsubst %.asm,%.o,$(A_SRCS))

C_TARGET := libmycc.so
A_TARGET := libmyasm.so

.PHONY: all run clean echo

all: $(C_TARGET) $(A_TARGET)


$(C_TARGET): $(C_OBJS)
				$(CC) -shared -o$@ $^ 
				sudo mv /home/jkarng/Project/nasm_game/x86_64/lib/$(C_TARGET) /usr/local/lib/

$(A_TARGET): $(A_OBJS)
				$(CC) -shared -o$@ $^ 
				sudo mv /home/jkarng/Project/nasm_game/x86_64/lib/$(A_TARGET) /usr/local/lib/

src/%.o: src/%.c
				$(CC) -fPIC -c $< -o$@

src/%.o: src/%.asm 
				$(AS) -felf64 $< -o$@

run: test.out
		./test.out

test.out: test.cc
		clang++ -lmyasm -lmycc $^ -o$@

clean:
			sudo rm /usr/local/lib/$(C_TARGET) /usr/local/lib/$(A_TARGET)
			rm $(C_OBJS) $(A_OBJS) $(C_TARGET) $(A_TARGET) test.out

echo: 
			@echo $(C_SRCS)
			@echo $(A_SRCS)
			@echo ===============
			@echo $(C_OBJS)
			@echo $(A_OBJS)

			echo $(TARGET)
