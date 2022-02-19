# sudo dd if=pong.img of=/dev/sdb count=1 bs=512
		#dd if=/dev/zero of=floppy.bin count=2878 bs=512
		#cat $(TARGET-1) $(TARGET-2) floppy.bin > $(OUT)
TARGET := build/pong.bin
TARGET += build/sector-1.bin
.PHONY: all run mkdir 

all: $(TARGET)

build/%.bin: mkdir ./%.asm
	nasm -f bin $(word 2,$^) -o $@

run: $(TARGET)
	qemu-system-i386 -drive file=$(TARGET),format=raw

xxd: $(word 1, $(TARGET))
	xxd $<

mkdir:
	mkdir -p build

clean:
	@rm $(TARGET)
