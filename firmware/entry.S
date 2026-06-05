	.section .text.boot

	.global _start
_start:
	/* Setup the global pointer */
	lla     gp, __global_pointer$

	/* Setup the stack */
	lla     sp, __stack

	/* Clear BSS */
	lla     t0, __bss_start
	lla     t1, __bss_end
	beq     t0, t1, 2f
1:
	sd      x0, 0(t0)
	addi	t0, t0, 8
	bltu	t0, t1, 1b

	/* Off we go */
	tail    start_firmware
2:
	wfi
	j       2b

	/* Embed the dtb in the firmware image */
	.section .rodata, "a"
	.balign 8
	.global __dtb
__dtb:
	.incbin "len-fpga.dtb"
	.global __dtb_end
__dtb_end:
