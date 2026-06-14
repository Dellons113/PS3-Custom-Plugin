CELL_MK_DIR = $(PS3DEV)/ppu/lv2/include/ppu

PRX_DIR		= .
OUTNAME		= custom_plugin
CC			= ppu-gcc
CXX			= ppu-g++
LD			= ppu-ld
OBJCOPY		= ppu-objcopy

CFLAGS		= -O2 -Wall -I. -fno-builtin -fno-exceptions -ffunction-sections -fdata-sections
LDFLAGS		= -T $(CELL_MK_DIR)/prx.ld -nostartfiles -nostdlib -nodefaultlibs -Wl,-q -Wl,--gc-sections

OBJS		= main.o

all: $(OUTNAME).prx

$(OUTNAME).prx: $(OUTNAME).elf
	$(OBJCOPY) -O binary $< $@
	make_self_npdrm $@ $(OUTNAME).sprx

$(OUTNAME).elf: $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o *.elf *.prx *.sprx
