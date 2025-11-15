include Makefile.conf

SBI := $(BUILD_DIR)/opensbi.bin
KERNEL := $(BUILD_DIR)/kernel.bin

all: sbi

sbi: kernel
	make -C external/opensbi \
		PLATFORM=len-fpga \
		CROSS_COMPILE=$(SBI_CROSS_COMPILE) \
		FW_PAYLOAD_PATH=$(BUILD_DIR)/kernel.bin
	cp external/opensbi/build/platform/len-fpga/firmware/fw_payload.bin $(SBI)

kernel: firmware
	make -C external/len
	cp external/len/build/kernel.bin $(KERNEL)

firmware: 
	mkdir -p build
	make -C firmware

serial:
	./scripts/serial_load.py

bram:
	./scripts/update_bram.sh

cpu:
	./scripts/generate_cpu.sh
	mv external/VexiiRiscv/VexiiRiscv.v ip/VexiiRiscv.v

clean:
	rm -rf $(BUILD_DIR)
	make -C external/opensbi clean
	make -C external/len clean

.PHONY: all sbi kernel firmware serial bram cpu clean
