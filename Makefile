include Makefile.conf

BUILD_DIR = $(CURDIR)/build

SBI_BUILD_DIR := $(BUILD_DIR)/opensbi
KERNEL_BUILD_DIR := $(BUILD_DIR)/len
FIRMWARE_BUILD_DIR := $(BUILD_DIR)/firmware
DTB_BUILD_DIR := $(BUILD_DIR)/dtb

all: sbi

sbi: kernel
	@mkdir -p $(dir $(SBI_BUILD_DIR))

	$(MAKE) -C external/opensbi \
		PLATFORM=len \
		CROSS_COMPILE=$(SBI_CROSS_COMPILE) \
		FW_TEXT_START=0x80000000 \
		FW_FDT_PATH=$(DTB_BUILD_DIR)/len-fpga.dtb \
		FW_PAYLOAD_PATH=$(KERNEL_BUILD_DIR)/kernel.bin \
		O=$(SBI_BUILD_DIR)


kernel: firmware
	@mkdir -p $(dir $(KERNEL_BUILD_DIR))
	$(MAKE) -C external/len O=$(KERNEL_BUILD_DIR)

firmware: dtb
	@mkdir -p $(dir $(FIRMWARE_BUILD_DIR))
	$(MAKE) -C firmware O=$(FIRMWARE_BUILD_DIR)

dtb:
	@mkdir -p $(DTB_BUILD_DIR)
	$(DTC) -I dts -O dtb -o $(DTB_BUILD_DIR)/len-fpga.dtb $(CURDIR)/dts/len-fpga.dts

serial_boot:
	./scripts/serial_boot.py

bram:
	./scripts/update_bram.sh $(FIRMWARE_BUILD_DIR)/firmware.mem

cpu:
	./scripts/generate_riscv_cpu.sh
	mv external/VexiiRiscv/VexiiRiscv.v ip/VexiiRiscv.v

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all sbi kernel firmware dtb serial_boot bram cpu clean
