TARGETS = boot.bin

OUT = MyOS.img
OUT = build/boot.bin

.PHONY: all clean run

all: build/$(TARGETS)
			#dd if=/dev/zero of=build/fda.bin count=2879 bs=512 
			#cat build/$(TARGETS) build/fda.bin > $(OUT)

build/%.bin: %.asm
			nasm -f bin $< -o $@

clean:
			rm build/*{.bin,.img}
xxd:
			xxd $(OUT) | less

run:
			$(MAKE)
			qemu-system-i386 -drive file=$(OUT),format=raw
