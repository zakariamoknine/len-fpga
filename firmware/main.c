#include "print.h"
#include "serial.h"

void start(void)
{
	uart_init(115200, 100000000);

	print("Hello from FPGA!\n\n");

	serial_load(true);

	while (1);
}
