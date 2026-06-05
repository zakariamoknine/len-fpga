ifdef O
	BUILD_DIR=$(shell readlink -m $(O))
else
	BUILD_DIR=$(CURDIR)/../build/firmware
endif

RISCV_CROSS_COMPILE ?= riscv64-linux-gnu-
CC      := $(RISCV_CROSS_COMPILE)gcc
LD      := $(RISCV_CROSS_COMPILE)ld
OBJCOPY := $(RISCV_CROSS_COMPILE)objcopy

DTC := dtc

CCFLAGS := -c -g -O2 \
           -MMD -MP \
		   -Wall -Wextra \
	   	   -Wunused \
	   	   -Wunused-parameter \
	   	   -Wunused-variable \
	   	   -Wunused-function \
           -ffreestanding \
           -fno-builtin \
           -fno-strict-aliasing \
           -fno-omit-frame-pointer \
           -fno-stack-protector \
           -finline-functions \
           -fno-pic -fno-pie \
           -march=rv64gc \
           -mabi=lp64 \
           -mcmodel=medany \
           -std=gnu99

LDFLAGS := -T $(CURDIR)/firmware.ld \
           --no-warn-rwx-segments

SRC := \
	$(CURDIR)/entry.S \
	$(CURDIR)/start.c \
	$(CURDIR)/print.c \
	$(CURDIR)/serial.c \
	$(CURDIR)/crc32.c \
	$(CURDIR)/uart.c \
	$(CURDIR)/string.c \
	$(CURDIR)/panic.c \
	$(CURDIR)/dev.c \

OBJ := $(patsubst $(CURDIR)/%,$(BUILD_DIR)/%,$(SRC:.c=.o))
OBJ := $(patsubst $(CURDIR)/%,$(BUILD_DIR)/%,$(OBJ:.S=.o))

ELF      := $(BUILD_DIR)/firmware.elf
FIRMWARE := $(BUILD_DIR)/firmware.bin
MEM      := $(BUILD_DIR)/firmware.mem
DEPS     := $(OBJ:.o=.d)

all: dtb $(FIRMWARE)

$(FIRMWARE): $(ELF)
	@$(OBJCOPY) -O binary $< $@
	@echo "  OBJCOPY $(notdir $@)"
	@echo "@00000000" > $(MEM)
	@xxd -ps -c4 -g4 $@ >> $(MEM)

$(ELF): $(OBJ)
	@echo "  LD      $(notdir $@)"
	@$(LD) $(LDFLAGS) -o $@ $^

$(BUILD_DIR)/%.o: $(CURDIR)/%.c
	@mkdir -p $(BUILD_DIR)
	@$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@
	@echo "  CC      $(notdir $<)"

$(BUILD_DIR)/%.o: $(CURDIR)/%.S
	@mkdir -p $(BUILD_DIR)
	@$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@
	@echo "  AS      $(notdir $<)"

dtb:
	@$(DTC) -I dts -O dtb -o len-fpga.dtb len-fpga.dts
	@echo "  DTC     len-fpga.dts"

clean:
	rm -rf $(BUILD_DIR)

-include $(DEPS)

.PHONY: all clean
