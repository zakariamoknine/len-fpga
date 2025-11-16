include ../Makefile.conf

ifdef O
	BUILD_DIR=$(shell readlink -m $(O))
else
	BUILD_DIR=$(CURDIR)/../build/firmware
endif

SRCDIR := .

SRC := \
	$(SRCDIR)/entry.S  \
	$(SRCDIR)/main.c   \
	$(SRCDIR)/print.c  \
	$(SRCDIR)/serial.c \
	$(SRCDIR)/test.c   \
	$(SRCDIR)/uart.c  

OBJ := $(patsubst $(SRCDIR)/%,$(BUILD_DIR)/%,$(SRC:.c=.o))
OBJ := $(patsubst $(SRCDIR)/%,$(BUILD_DIR)/%,$(OBJ:.S=.o))

ELF      := $(BUILD_DIR)/firmware.elf
FIRMWARE := $(BUILD_DIR)/firmware.bin
MEM      := $(BUILD_DIR)/firmware.mem

all: $(FIRMWARE)

$(FIRMWARE): $(ELF)
	$(OBJCOPY) -O binary $< $@
	echo "@00000000" > $(MEM)
	xxd -ps -c4 -g4 $@ >> $(MEM)

$(ELF): $(OBJ)
	$(LD) -T $(SRCDIR)/linker.ld -o $@ $^

$(BUILD_DIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@

$(BUILD_DIR)/%.o: $(SRCDIR)/%.S
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@

-include $(OBJ:.o=.d)

.PHONY: all
