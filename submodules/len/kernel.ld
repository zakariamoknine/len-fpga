OUTPUT_ARCH(riscv)
ENTRY(_start)
SECTIONS
{
	. = 0x80200000;
	__image_start = .;

	__text_start = .;
	.text.boot : {
		KEEP(*(.text.boot._start))
		*(.text.boot)
	}
	.text : {
		*(.text*)
		. = ALIGN(0x1000);
		__trampoline = .;
		*(trampsec)
		. = ALIGN(0x1000);
	}
	__text_end = .;

	.rodata : {
		*(.srodata .srodata.*)
		*(.rodata .rodata.*)
	}

	.data : {
		. = ALIGN(16);
		__global_pointer$ = . + 0x800;
		*(.sdata .sdata.*)
		*(.data .data.*)
	}

	.bss : {
		. = ALIGN(16);
		__bss_start = .;
		*(.sbss .sbss.*)
		*(.bss .bss.*)
		. = ALIGN(16);
		__bss_end = .;
	}

	__image_end = .;
}
