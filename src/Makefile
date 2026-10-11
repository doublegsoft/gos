CC = gcc
AS = as
LD = ld

CFLAGS = -m32 -std=gnu99 -ffreestanding -O2 -Wall -Wextra
ASFLAGS = --32
LDFLAGS = -m elf_i386 -T linker.ld

TARGET = myos.bin
OBJS = boot.o kernel.o

all: $(TARGET)

$(TARGET): $(OBJS) linker.ld
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

boot.o: boot.s
	$(AS) $(ASFLAGS) $< -o $@

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

run: $(TARGET)
	qemu-system-i386 -kernel $(TARGET)

clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all run clean