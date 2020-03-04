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

run: kernel
	qemu-system-i386 -kernel $^