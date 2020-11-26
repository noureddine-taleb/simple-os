.PHONY=all run
C_SOURCES=$(wildcard kernel/*.c drivers/*.c)
HEADERS=$(wildcard kernel/*.h drivers/*.h)
OBJ=${C_SOURCES:.c=.o}

all: os-image run

os-image: boot/boot_sect.bin kernel/kernel.bin
	cat $^ > $@

# kernel
kernel/kernel.bin: kernel/kernel_entry.o $(OBJ)
	ld -Ttext 0x1000 -m elf_i386 --oformat binary -o $@ $^ 

%.o: %.c $(HEADERS)
	gcc -Wall -ffreestanding -I . -m32 -fno-pie -c -o $@ $< 

%.o: %.S
	nasm -f elf -o $@ $<

# bootsector
%.bin: %.S
	nasm -f bin -o $@ $<

run: os-image
	qemu -fda $<

clean:
	-@rm **/*.bin os-image **/*.o
