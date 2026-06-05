#include "len.h"

void start_kernel(void)
{
	/* Initliaze the console */
	consoleinit();
	printfinit();

	/* Setup common char devices */
	fbinit();
	pdevinit();

	/* Install interrupt vectors, start timer interrupts */
	timerinit();
	trapinit();
	trapinithart();

	/* Intialize the allocator and the kernel's virtual address space */
	allocator_init();
	kvminit();
	kvminithart();

	/* Initialize the proc table */
	procinit();

	/* Initialize the interrupt controller */
	plicinit();
	plicinithart();

	/* Initliaze the filesystem and it's drivers */
	buffer_cache_init();
	iinit();
	fileinit();
	ramfsinit();

	/* Install the first user program */
	userinit();

	/* Wake up all CPUs and enter the scheduler! */
	scheduler();        
}
