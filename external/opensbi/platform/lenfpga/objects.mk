#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2019 Western Digital Corporation or its affiliates.
#

platform-cppflags-y =
platform-cflags-y =
platform-asflags-y =
platform-ldflags-y =

PLATFORM_RISCV_XLEN = 64
PLATFORM_RISCV_ABI = lp64
PLATFORM_RISCV_ISA = rv64imac_zicsr_zifencei
PLATFORM_RISCV_CODE_MODEL = medany

platform-objs-y += platform.o

# If the platform support requires a builtin device tree file, the name of
# the device tree compiled file should be specified here. The device tree
# source file be in the form <dt file name>.dts
#
platform-objs-y += lenfpga.o

# Optional parameter for path to external FDT
# FW_FDT_PATH="path to platform flattened device tree file"

FW_TEXT_START=0x80000000

FW_PAYLOAD=y
FW_PAYLOAD_OFFSET=0x200000
FW_PAYLOAD_ALIGN=0x1000

# Keep it undefined, by default OpenSBI will use add test
# FW_PAYLOAD_PATH="path to next boot stage binary image file"

FW_PAYLOAD_FDT_ADDR=0x82200000
