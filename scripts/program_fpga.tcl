set device [lindex $argv 0]

open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
set_property PROBES.FILE {} [get_hw_devices $device]
set_property FULL_PROBES.FILE {} [get_hw_devices $device]
set_property PROGRAM.FILE {/home/zakaria/devspace/len-fpga/len-fpga/len-fpga.runs/impl_1/topbd_wrapper_with_init_rom.bit} [get_hw_devices $device]
program_hw_devices [get_hw_devices $device]
refresh_hw_device [lindex [get_hw_devices $device] 0]
close_hw_target
disconnect_hw_server
close_hw_manager
