#include "internal.h"
#include "print.h"
#include "panic.h"
#include "serial.h"
#include "dev.h"

extern uintptr_t __dtb;
extern uintptr_t __dtb_end;

static void copy_dtb(phys_addr_t addr)
{
	uintptr_t len = &__dtb_end - &__dtb;
	memcpy((void*)addr, (const void*)&__dtb, (size_t)len);
}

static void jump_to_payload(phys_addr_t addr)
{
	/* Flush the i-cache and fill it with nops */
	asm volatile("fence.i" ::: "memory");
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");

	/* Off we go */
	void (*entry_point)(void) = (void(*)(void))(addr);
	entry_point();

	/* Unreachable */
	__builtin_unreachable();

	while (1)
		;
}

static void load_images(void)
{
	if (serial_load(DDR2_BASE_ADDR) != 0) {
		panic("Kernel loading failed.\n");
	}

	if (serial_load(RAMFS_BASE_ADDR) != 0) {
		panic("Ramfs loading failed.\n");
	}
}

void start_firmware(void)
{
	/* Initialize uart8250 */
	uart_init(UART_BAUDRATE, SYS_CLK_FREQ);

	/* Initialize devices */
	dev_init();

	/* Indicate we're in */
	print("len-fpga is booting...\n\n");

	/* Copy the fdt somewhere safe in memory */
	copy_dtb(DDR2_BASE_ADDR + 0x07000000);

	/* Load everything */
	load_images();

	/* Off we go! */
	jump_to_payload(DDR2_BASE_ADDR);
}
