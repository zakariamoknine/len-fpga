include Makefile.conf

OUTDIR := out
ELF := $(OUTDIR)/firmware.elf
FIRMWARE := $(OUTDIR)/image

MEMFILE := $(OUTDIR)/firmware.mem

SRCDIRS := firmware

SRC := $(shell find $(SRCDIRS) -type f \( -name "*.c" -o -name "*.S" \))
OBJ := $(patsubst %.c, $(OUTDIR)/%.o, $(filter %.c,$(SRC))) $(patsubst %.S, $(OUTDIR)/%.o, $(filter %.S,$(SRC)))

all: $(FIRMWARE)

$(FIRMWARE): $(ELF)
	$(OBJCOPY) -O binary $< $@
	echo "@0000" > $(MEMFILE)
	xxd -ps -c4 -g4 $@ >> $(MEMFILE)

$(ELF): $(OBJ)
	$(LD) -T firmware/linker.ld -o $@ $^

$(OUTDIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CCFLAGS) -o $@ $<

$(OUTDIR)/%.o: %.S
	@mkdir -p $(dir $@)
	$(CC) $(CCFLAGS) -o $@ $<

-include $(OBJ:.o=.d)

bram:
	./scripts/update_bram.sh

gencpu:
	./scripts/generate_cpu.sh

clean:
	rm -rf $(OUTDIR)

.PHONY: all bram clean
