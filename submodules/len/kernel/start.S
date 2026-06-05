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
	addi    t0, t0, 8
	bltu    t0, t1, 1b
2:
	/* Assign tp to hartid passed by OpenSBI in a0 */
	mv      tp, a0

	/* Off we go */
	tail    start_kernel
3:
	wfi
	j       3b


	.section .data

	.balign 4096
	.space 4096
__stack:
