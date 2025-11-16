include Makefile.conf

BUILD_DIR = $(CURDIR)/build

SBI_BUILD_DIR := $(BUILD_DIR)/opensbi
KERNEL_BUILD_DIR := $(BUILD_DIR)/len
FIRMWARE_BUILD_DIR := $(BUILD_DIR)/firmware

all: sbi

sbi: kernel
	@mkdir -p $(dir $(SBI_BUILD_DIR))
	$(MAKE) -C external/opensbi \
		PLATFORM=len-fpga \
		CROSS_COMPILE=$(SBI_CROSS_COMPILE) \
		FW_PAYLOAD_PATH=$(KERNEL_BUILD_DIR)/kernel.bin \
		O=$(SBI_BUILD_DIR)

kernel: firmware
	@mkdir -p $(dir $(KERNEL_BUILD_DIR))
	$(MAKE) -C external/len O=$(KERNEL_BUILD_DIR)

firmware: 
	@mkdir -p $(dir $(FIRMWARE_BUILD_DIR))
	$(MAKE) -C firmware O=$(FIRMWARE_BUILD_DIR)

serial_boot:
	./scripts/serial_boot.py

bram:
	./scripts/update_bram.sh $(FIRMWARE_BUILD_DIR)/firmware.mem

cpu:
	./scripts/generate_riscv_cpu.sh
	mv external/VexiiRiscv/VexiiRiscv.v ip/VexiiRiscv.v

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all sbi kernel firmware serial bram cpu clean
