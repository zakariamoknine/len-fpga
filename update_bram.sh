#!/bin/bash

-updatemem -meminfo blk_mem_gen_0.mmi \
	   -data out/firmware.mem \
	   -bit len-fpga.runs/impl_1/topbd_wrapper.bit \
	   -proc dummy \
	   -out len-fpga.runs/impl_1/topbd_wrapper_with_data.bit \
	   -force
