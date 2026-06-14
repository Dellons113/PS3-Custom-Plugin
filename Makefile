# Pastikan variabel ini menggunakan CFLAGS yang kita kirim dari GitHub Actions
CC = ppu-gcc
CFLAGS += -O2 -Wall -fno-builtin -fno-exceptions -ffunction-sections -fdata-sections
LDFLAGS = -T $(PS3DEV)/ppu/lib/prx.ld -nostartfiles -nostdlib -nodefaultlibs -Wl,-q -Wl,--gc-sections

all: custom_plugin.sprx

custom_plugin.sprx: main.o
	$(CC) $(LDFLAGS) -o custom_plugin.elf main.o -lio
	ppu-objcopy -O binary custom_plugin.elf custom_plugin.prx
	make_self_npdrm custom_plugin.prx custom_plugin.sprx

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o
