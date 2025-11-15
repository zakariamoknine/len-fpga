include Makefile.conf

SRCDIR := firmware
OUTDIR := out

SRC := \
	$(SRCDIR)/entry.S \
	$(SRCDIR)/main.c  \
	$(SRCDIR)/uart.c

OBJ := $(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(SRC:.c=.o))
OBJ := $(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(OBJ:.S=.o))

ELF      := $(OUTDIR)/firmware.elf
FIRMWARE := $(OUTDIR)/firmware.bin
FIRMWARE_MEMFILE := $(OUTDIR)/firmware.mem

SBI := $(OUTDIR)/opensbi.bin
SBI_MEMFILE := $(OUTDIR)/opensbi.mem

all: $(FIRMWARE) sbi

$(FIRMWARE): $(ELF)
	$(OBJCOPY) -O binary $< $@
	echo "@00000000" > $(FIRMWARE_MEMFILE)
	xxd -ps -c4 -g4 $@ >> $(FIRMWARE_MEMFILE)

$(ELF): $(OBJ)
	$(LD) -T $(SRCDIR)/linker.ld -o $@ $^

$(OUTDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(OUTDIR)
	$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@

$(OUTDIR)/%.o: $(SRCDIR)/%.S
	@mkdir -p $(OUTDIR)
	$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@

-include $(OBJ:.o=.d)

sbi:
	make -C external/opensbi PLATFORM=len-fpga CROSS_COMPILE=$(SBICC)
	mv external/opensbi/build/platform/len-fpga/firmware/fw_jump.bin $(SBI)
	echo "@00000000" > $(SBI_MEMFILE)
	xxd -ps -c4 -g4 $(SBI) >> $(SBI_MEMFILE)
	dd if=/dev/zero bs=1 count=$$((143360 - $$(stat -c%s $(SBI_MEMFILE)))) >> $(SBI_MEMFILE)

bram:
	./scripts/update_bram.sh

gencpu:
	./scripts/generate_cpu.sh
	mv external/VexiiRiscv/VexiiRiscv.v ip/VexiiRiscv.v

clean:
	rm -rf $(OUTDIR)
	make -C external/opensbi clean

.PHONY: all sbi bram gencpu clean
