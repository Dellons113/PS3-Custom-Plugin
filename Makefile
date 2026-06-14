# Path wajib untuk toolchain
PS3DEV = /usr/local/ps3dev
PPU_CC = ppu-gcc
PPU_OBJCOPY = ppu-objcopy

# Include dan Flags
INCLUDE = -I. -I$(PS3DEV)/ppu/include -I$(PS3DEV)/psl1ght/include
CFLAGS = -O2 -Wall -fno-builtin -fno-exceptions -ffunction-sections -fdata-sections
LDFLAGS = -L$(PS3DEV)/ppu/lib -T $(PS3DEV)/ppu/lib/prx.ld -nostartfiles -nostdlib -nodefaultlibs -Wl,-q -Wl,--gc-sections

all: custom_plugin.sprx

custom_plugin.sprx: main.o
	$(PPU_CC) $(LDFLAGS) -o custom_plugin.elf main.o -lio
	$(PPU_OBJCOPY) -O binary custom_plugin.elf custom_plugin.prx
	make_self_npdrm custom_plugin.prx custom_plugin.sprx

main.o: main.c
	$(PPU_CC) $(INCLUDE) $(CFLAGS) -c main.c -o main.o

clean:
	rm -f *.o *.elf *.prx *.sprx
