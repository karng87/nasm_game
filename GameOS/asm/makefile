
TARGETS = main.img

all: $(TARGETS)

%.img: %.o
	ld --oformat binary -o $@ -T link.ld $^

%.o: %.S
	as -g $< -o $@

run:
	qemu-system-x86_64 -hda $(TARGETS)

usb:
	sudo dd if=main.img of=
