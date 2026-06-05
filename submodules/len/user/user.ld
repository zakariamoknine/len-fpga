OUTPUT_ARCH("riscv")
SECTIONS
{
	. = 0x00000000;
 
	.text : {
		*(.text .text.*)
	}

	.rodata : {
		*(.srodata .srodata.*)
		*(.rodata .rodata.*)
	}

	.eh_frame : {
		*(.eh_frame)
		*(.eh_frame.*)
	}

	. = ALIGN(0x1000);
	.data : {
		*(.sdata .sdata.*)
		*(.data .data.*)
	}

	.bss : {
		*(.sbss .sbss.*)
		*(.bss .bss.*)
	}
}
