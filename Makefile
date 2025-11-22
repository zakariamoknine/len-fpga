include Makefile.conf

BUILD_DIR = $(PWD)/build

SBI_BUILD_DIR := $(BUILD_DIR)/opensbi
KERNEL_BUILD_DIR := $(BUILD_DIR)/len
FIRMWARE_BUILD_DIR := $(BUILD_DIR)/firmware
TEST_BUILD_DIR := $(BUILD_DIR)/test
DTB_BUILD_DIR := $(BUILD_DIR)/dtb

all: sbi

sbi: kernel
	@mkdir -p $(dir $(SBI_BUILD_DIR))

	$(MAKE) -C external/opensbi \
		PLATFORM=generic \
		CROSS_COMPILE=$(SBI_CROSS_COMPILE) \
		FW_TEXT_START=0x80000000 \
		FW_FDT_PATH=$(DTB_BUILD_DIR)/len-fpga.dtb \
		FW_PAYLOAD_ALIGN=0x1000\
		FW_PAYLOAD_PATH=$(KERNEL_BUILD_DIR)/kernel.bin \
		FW_PAYLOAD_FDT_OFFSET=0x2200000 \
		O=$(SBI_BUILD_DIR)

kernel: firmware
	@mkdir -p $(dir $(KERNEL_BUILD_DIR))
	$(MAKE) -C external/len O=$(KERNEL_BUILD_DIR)

firmware: dtb
	@mkdir -p $(dir $(FIRMWARE_BUILD_DIR))
	$(MAKE) -C firmware O=$(FIRMWARE_BUILD_DIR)

dtb:
	@mkdir -p $(DTB_BUILD_DIR)
	$(DTC) -I dts -O dtb -o $(DTB_BUILD_DIR)/len-fpga.dtb $(PWD)/dts/len-fpga.dts

test:
	@mkdir -p $(dir $(TEST_BUILD_DIR))
	$(MAKE) -C test O=$(TEST_BUILD_DIR)

serial_boot:
	./scripts/serial_boot.py \
		$(PWD)/build/opensbi/platform/generic/firmware/fw_payload.bin \
	       	-p /dev/ttyUSB1 -b 115200

bram:
	./scripts/update_bram.sh $(FIRMWARE_BUILD_DIR)/firmware.mem

cpu:
	./scripts/generate_riscv_cpu.sh
	@mv external/VexiiRiscv/VexiiRiscv.v ip/VexiiRiscv.v

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all sbi kernel firmware dtb test serial_boot bram cpu clean
