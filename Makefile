# LLVM-kernel (c) Nikolas Wipper 2020

SRCS = $(shell find src/**.ll)
ASMS = $(addsuffix .s,$(basename $(SRCS)))
OBJS = $(addsuffix .o,$(basename $(SRCS)))

LLC = llc
ASM = x86_64-elf-gcc
LD  = x86_64-elf-ld

LLCFLAGS = -march=x86
ASMFLAGS = -m32 -Wall -ffreestanding -nostdlib -c
LDFLAGS  = -melf_i386 -Tkernel.ld

%.s: %.ll
	$(LLC) $(LLCFLAGS) $^ -o $@

%.o: %.s
	$(ASM) $(ASMFLAGS) $^ -o $@

kernel: $(OBJS)
	$(LD)  $(LDFLAGS)  $^ -o $@ 

kernel.iso: kernel
	mkdir -p iso
	mkdir -p iso/boot
	mkdir -p iso/boot/grub

	cp kernel iso/boot/

	echo 'set timeout=0' >> iso/boot/grub/grub.cfg
	echo 'set default=5' >> iso/boot/grub/grub.cfg
	echo '' >> iso/boot/grub/grub.cfg
	echo 'menuentry "LLVM-kernel" {' >> iso/boot/grub/grub.cfg
	echo '    multiboot /boot/kernel' >> iso/boot/grub/grub.cfg
	echo '    boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg

	i386-elf-grub-mkrescue --output=$@ iso
	@rm -rf iso

run: kernel.iso
	qemu-system-i386 -cdrom $^