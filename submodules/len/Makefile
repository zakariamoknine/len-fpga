ifdef O
	BUILD_DIR=$(shell readlink -m $(O))
else
	BUILD_DIR=$(CURDIR)/build
endif

MISC := $(CURDIR)/misc

RISCV_CROSS_COMPILE ?= riscv64-linux-gnu-
CC      := $(RISCV_CROSS_COMPILE)gcc
LD      := $(RISCV_CROSS_COMPILE)ld
OBJCOPY := $(RISCV_CROSS_COMPILE)objcopy
OBJDUMP := $(RISCV_CROSS_COMPILE)objdump

CCFLAGS := -c -g -O3 \
           -MMD -MP \
           -Wall -Werror \
           -Wunused \
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
           -mabi=lp64d \
           -mcmodel=medany \
           -I$(CURDIR) \
           -std=gnu99

LDFLAGS := --no-warn-rwx-segments

KBUILD_DIR := $(BUILD_DIR)/kernel
UBUILD_DIR := $(BUILD_DIR)/user

#
# KERNEL
#

KCSRCS := $(shell find $(CURDIR)/kernel -type f -name '*.c')
KSSRCS := $(shell find $(CURDIR)/kernel -type f -name '*.S')
KCOBJS := $(patsubst $(CURDIR)/kernel/%.c, $(KBUILD_DIR)/%.o, $(KCSRCS))
KSOBJS := $(patsubst $(CURDIR)/kernel/%.S, $(KBUILD_DIR)/%.o, $(KSSRCS))
KOBJS  := $(KSOBJS) $(KCOBJS)
KDEPS  := $(KOBJS:.o=.d)

ELF    := $(KBUILD_DIR).elf
KERNEL := $(KBUILD_DIR).bin

all: $(KERNEL)

$(KERNEL): $(ELF)
	@$(OBJCOPY) -O binary $< $@
	@echo "  OBJCOPY $(notdir $@)"

$(ELF): $(KOBJS)
	@mkdir -p $(dir $@)
	@$(LD) $(LDFLAGS) -T $(CURDIR)/kernel.ld -o $@ $^
	@echo "  LD      $(notdir $@)"

$(KBUILD_DIR)/%.o: $(CURDIR)/kernel/%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@
	@echo "  CC      $(notdir $<)"

$(KBUILD_DIR)/%.o: $(CURDIR)/kernel/%.S
	@mkdir -p $(dir $@)
	@$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@
	@echo "  AS      $(notdir $<)"

#
# USER
#

RAMFS := $(BUILD_DIR)/ramfs.img
MKFS  := $(BUILD_DIR)/mkfs

USRCS := $(shell find $(CURDIR)/user -type f -name '*.c' ! -name "lib.c")
UOBJS := $(patsubst $(CURDIR)/user/%.c, $(UBUILD_DIR)/%.o, $(USRCS))
UAPPS := $(patsubst $(CURDIR)/user/%.c, $(UBUILD_DIR)/_%, $(USRCS))
UDEPS := $(UOBJS:.o=.d)

ULIB := $(UBUILD_DIR)/lib.o $(UBUILD_DIR)/syscall.o

$(UBUILD_DIR)/_%: $(UBUILD_DIR)/%.o $(ULIB)
	@mkdir -p $(dir $@)
	@$(LD) $(LDFLAGS) -T $(CURDIR)/user/user.ld -o $@ $< $(ULIB)
	@$(OBJDUMP) -S $@ > $(basename $@).asm
	@$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(basename $@).sym
	@echo "  LD      $(notdir $@)"

$(UBUILD_DIR)/%.o: $(CURDIR)/user/%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@
	@echo "  CC      $(notdir $<)"

$(UBUILD_DIR)/syscall.S: $(CURDIR)/scripts/syscall_stubs.sh
	@mkdir -p $(dir $@)
	@$(CURDIR)/scripts/syscall_stubs.sh > $@
	@echo "  SH      $(notdir $<)"

$(UBUILD_DIR)/syscall.o: $(UBUILD_DIR)/syscall.S
	@mkdir -p $(dir $@)
	@$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@
	@echo "  CC      $(notdir $<)"

$(UBUILD_DIR)/lib.o: $(CURDIR)/user/lib.c
	@mkdir -p $(dir $@)
	@$(CC) $(CCFLAGS) -MMD -MP -c $< -o $@
	@echo "  CC      $(notdir $<)"

$(MKFS): $(CURDIR)/mkfs/mkfs.c
	@mkdir -p $(dir $@)
	@gcc -Wno-unknown-attributes -I$(CURDIR) -o $@ $<
	@echo "  CC      $(notdir $<)"

#
# To stop the Makefile from removing *.o files
#
.SECONDARY: $(UOBJS) $(KOBJS) $(ULIB)

$(RAMFS): $(MKFS) $(UAPPS)
	@$(BUILD_DIR)/mkfs $(BUILD_DIR)/ramfs.img $(UAPPS) $(MISC)/picture.bin
	@echo "  MKFS    ramfs.img"

fs: $(RAMFS)

tags:
	@ctags -R .

clean:
	rm -rf $(BUILD_DIR)

-include $(KDEPS) $(UDEPS)

.PHONY: all fs tags clean
