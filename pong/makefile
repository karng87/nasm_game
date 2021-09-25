# sudo dd if=pong.img of=/dev/sdb count=1 bs=512
		#dd if=/dev/zero of=floppy.bin count=2878 bs=512
		#cat $(TARGET-1) $(TARGET-2) floppy.bin > $(OUT)
TARGET = pong.bin
TARGET-1 += sector-1.bin
TARGET-2 += sector-2.bin
TARGETS = $(TARGET) $(TARGET-1) $(TARGET-2)
OUT = GameOS.img

OUT = pong.bin

.PHONY: all run 
all: $(OUT)

%.bin: %.asm
		nasm -f bin $< -o $@

run:
		@$(MAKE)
		@qemu-system-i386 -drive file=$(OUT),format=raw

clean:
		@rm *.img *.bin

