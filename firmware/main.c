#include "print.h"

void start(void)
{
	uart_init(115200, 100000000);

	print("Hello from FPGA\n");

	while (1);
}
