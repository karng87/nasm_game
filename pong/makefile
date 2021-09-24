TARGETS = pong.img

.PHONY: all run xxd
all: $(TARGETS)

%.img: %.asm
		nasm -f bin $< -o $@


run:
		@$(MAKE)
		@qemu-system-i386 -drive file=$(TARGETS),format=raw

xxd:
		@$(MAKE)
		@xxd $(TARGETS)

vi:
		@vi $(TARGETS:%.img=%.asm)
