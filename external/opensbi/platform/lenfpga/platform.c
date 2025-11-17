/*
 * SPDX-License-Identifier: BSD-2-Clause
 *
 * Copyright (c) 2019 Western Digital Corporation or its affiliates.
 */

#include <sbi/riscv_asm.h>
#include <sbi/riscv_encoding.h>
#include <sbi/sbi_const.h>
#include <sbi/sbi_platform.h>
#include <sbi/sbi_system.h>

//#include <sbi_utils/fdt/fdt_helper.h>
//#include <sbi_utils/fdt/fdt_fixup.h>

/*
 * Include these files as needed.
 * See objects.mk PLATFORM_xxx configuration parameters.
 */
//#include <sbi_utils/ipi/aclint_mswi.h>
//#include <sbi_utils/irqchip/plic.h>
#include <sbi_utils/serial/uart8250.h>
//#include <sbi_utils/timer/aclint_mtimer.h>

//#define PLATFORM_PLIC_ADDR		0xc000000
//#define PLATFORM_PLIC_SIZE		(0x200000 + (PLATFORM_HART_COUNT * 0x1000))
//#define PLATFORM_PLIC_NUM_SOURCES	128

#define LENFPGA_HART_COUNT		1

//#define PLATFORM_CLINT_ADDR		0x2000000
//#define PLATFORM_ACLINT_MTIMER_FREQ	10000000
//#define PLATFORM_ACLINT_MSWI_ADDR	(PLATFORM_CLINT_ADDR + CLINT_MSWI_OFFSET)
//#define PLATFORM_ACLINT_MTIMER_ADDR	(PLATFORM_CLINT_ADDR + CLINT_MTIMER_OFFSET)

#define LENFPGA_UART_ADDR		0x44A00000
#define LENFPGA_UART_FREQ	        100000000
#define LENFPGA_UART_BAUDRATE		115200
#define LENFPGA_UART_REG_SHIFT		2
#define LENFPGA_UART_REG_WIDTH		4
#define LENFPGA_UART_REG_OFFSET		0
#define LENFPGA_UART_CAPS		0

//static struct plic_data plic = {
//	.addr = PLATFORM_PLIC_ADDR,
//	.size = PLATFORM_PLIC_SIZE,
//	.num_src = PLATFORM_PLIC_NUM_SOURCES,
//	.context_map = {
//		[0] = { 0, 1 },
//		[1] = { 2, 3 },
//		[2] = { 4, 5 },
//		[3] = { 6, 7 },
//	},
//};
//

static struct aclint_mtimer_data mtimer = {
	.mtime_freq = 100000000,
	.mtime_addr = 0x30000000,
	.mtime_size = 0,
	.mtimecmp_addr = 0x30030000,
	.mtimecmp_size = 0,
	.first_hartid = 0,
	.hart_count = LENFPGA_HART_COUNT,
	.has_64bit_mmio = false,
};

/*
 * Platform early initialization.
 */
static int lenfpga_early_init(bool cold_boot)
{
	//if (!cold_boot)
	//	return 0;
	

	uart8250_init(LENFPGA_UART_ADDR,
		      LENFPGA_UART_FREQ,
		      LENFPGA_UART_BAUDRATE,
		      LENFPGA_UART_REG_SHIFT,
		      LENFPGA_UART_REG_WIDTH,
		      LENFPGA_UART_REG_OFFSET,
		      LENFPGA_UART_CAPS);

	return 0;
}

/*
 * Platform final initialization.
 */
static int lenfpga_final_init(bool cold_boot)
{
	return 0;
}

/*
 * Initialize the platform interrupt controller during cold boot.
 */
static int lenfpga_irqchip_init(void)
{
	return 0;
}

/*
 * Initialize IPI during cold boot.
 */
static int lenfpga_ipi_init(void)
{
	return aclint_mtimer_cold_init(&mtimer, NULL);
}

/*
 * Initialize platform timer during cold boot.
 */
static int lenfpga_timer_init(void)
{
	return 0;
}

/*
 * Platform descriptor.
 */
const struct sbi_platform_operations platform_ops = {
	.early_init		= lenfpga_early_init,
	.final_init		= lenfpga_final_init,
	.irqchip_init		= lenfpga_irqchip_init,
	.ipi_init		= lenfpga_ipi_init,
	.timer_init		= lenfpga_timer_init
};
const struct sbi_platform platform = {
	.opensbi_version	= OPENSBI_VERSION,
	.platform_version	= SBI_PLATFORM_VERSION(0x0, 0x00),
	.name			= "lenfpga",
	.features		= 0,
	.hart_count		= LENFPGA_HART_COUNT,
	.hart_stack_size	= SBI_PLATFORM_DEFAULT_HART_STACK_SIZE,
	.heap_size		= SBI_PLATFORM_DEFAULT_HEAP_SIZE(1),
	.platform_ops_addr	= (unsigned long)&platform_ops
};
