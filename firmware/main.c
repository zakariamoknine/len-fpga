#include "uart.h"

void start(void)
{
	uart_init(115200, 100000000);

	printk("Hello from FPGA!\n");
	printk("How we doing?\n");
	printk("Myself, doing pretty good!\n");

	while (1);
}
