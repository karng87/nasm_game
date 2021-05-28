.PHONY: all

all:
			nasm -f bin src/invaders.asm -o boot.img

run:
			qemu-system-i386 -drive format=raw,file=boot.img
