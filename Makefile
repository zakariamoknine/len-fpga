include Makefile.conf

SRCDIR   := firmware
OUTDIR   := out

SRC := \
	$(SRCDIR)/entry.S\
	$(SRCDIR)/main.c \
	$(SRCDIR)/uart.c

OBJ := $(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(SRC:.c=.o))
OBJ := $(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(OBJ:.S=.o))

ELF      := $(OUTDIR)/firmware.elf
FIRMWARE := $(OUTDIR)/firmware.img
MEMFILE  := $(OUTDIR)/firmware.mem

all: $(FIRMWARE)

$(FIRMWARE): $(ELF)
	$(OBJCOPY) -O binary $< $@
	echo "@0000" > $(MEMFILE)
	xxd -ps -c4 -g4 $@ >> $(MEMFILE)

$(ELF): $(OBJ)
	$(LD) -T $(SRCDIR)/linker.ld -o $@ $^

# Compile C
$(OUTDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(OUTDIR)
	$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@

# Compile Assembly
$(OUTDIR)/%.o: $(SRCDIR)/%.S
	@mkdir -p $(OUTDIR)
	$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@

-include $(OBJ:.o=.d)

bram:
	./scripts/update_bram.sh

gencpu:
	./scripts/generate_cpu.sh
	mv external/VexiiRiscv/VexiiRiscv.v ip/VexiiRiscv.v

clean:
	rm -rf $(OUTDIR)

.PHONY: all bram gencpu clean
