RISCV_CROSS_COMPILE ?= riscv64-linux-gnu-
CC      := $(RISCV_CROSS_COMPILE)gcc
LD      := $(RISCV_CROSS_COMPILE)ld
OBJCOPY := $(RISCV_CROSS_COMPILE)objcopy

DTC ?= dtc

VIVADO := vivado
FPGA_DEVICE ?= xc7a100t_0

BUILD_DIR := $(PWD)/build

SBI_BUILD_DIR      := $(BUILD_DIR)/opensbi
KERNEL_BUILD_DIR   := $(BUILD_DIR)/len
FIRMWARE_BUILD_DIR := $(BUILD_DIR)/firmware
RAMFS_BUILD_DIR    := $(BUILD_DIR)/ramfs

SBI_PAYLOAD_DIR := $(SBI_BUILD_DIR)/platform/generic/firmware

PHONY := all
all: sbi

PHONY += sbi
sbi: kernel
	@mkdir -p $(dir $(SBI_BUILD_DIR))
	@$(MAKE) -C submodules/opensbi \
		CROSS_COMPILE=$(RISCV_CROSS_COMPILE) \
		PLATFORM=generic \
		FW_PAYLOAD=y \
		FW_PAYLOAD_PATH=$(KERNEL_BUILD_DIR)/kernel.bin \
		FW_PAYLOAD_ALIGN=0x200000 \
		FW_PAYLOAD_FDT_ADDR=0x82000000 \
		FW_FDT_PATH=$(CURDIR)/firmware/len-fpga.dtb \
		FW_TEXT_START=0x80000000 \
		O=$(SBI_BUILD_DIR)

PHONY += kernel
kernel: firmware ramfs
	@mkdir -p $(KERNEL_BUILD_DIR)
	@$(MAKE) -C submodules/len O=$(KERNEL_BUILD_DIR)

PHONY += firmware
firmware:
	@mkdir -p $(dir $(FIRMWARE_BUILD_DIR))
	@$(MAKE) -C firmware O=$(FIRMWARE_BUILD_DIR)

PHONY += ramfs
ramfs:
	@mkdir -p $(RAMFS_BUILD_DIR)
	@$(MAKE) -C submodules/len fs O=$(RAMFS_BUILD_DIR)

PHONY += serial_boot
serial_boot:
	@./scripts/serial_boot.sh \
		$(SBI_PAYLOAD_DIR)/fw_payload.bin \
		$(RAMFS_BUILD_DIR)/ramfs.img \
		-p /dev/ttyUSB1 \
		-b 460800

PHONY += bram
bram:
	@./scripts/update_bram.sh $(FIRMWARE_BUILD_DIR)/firmware.mem

PHONY += cpu
cpu:
	@./scripts/generate_cpu.sh
	@mv submodules/VexiiRiscv/VexiiRiscv.v ip/cpu/VexiiRiscv.v

PHONY += fpga
fpga:
	@$(VIVADO) -nolog -nojournal \
		-mode batch \
		-source scripts/program_fpga.tcl \
		-tclargs $(FPGA_DEVICE)

PHONY += connect
connect:
	@picocom -b 460800 /dev/ttyUSB1 --imap lfcrlf

PHONY += clean
clean:
	$(MAKE) -C firmware clean
	$(MAKE) -C submodules/opensbi clean
	$(MAKE) -C submodules/len clean
	rm -rf $(BUILD_DIR)

PHONY += FORCE
FORCE:

.PHONY: $(PHONY)
