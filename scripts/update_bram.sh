#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <path/to/data.mem>"
	exit 1
fi

updatemem -meminfo blk_rom.mmi \
	  -data $1 \
	  -bit len-fpga/len-fpga.runs/impl_1/topbd_wrapper.bit \
	  -proc dummy \
	  -out len-fpga/len-fpga.runs/impl_1/topbd_wrapper_with_init_rom.bit \
	  -force
