#include "print.h"
#include "serial.h"

void start()
{
	uart_init(115200, 100000000);
	print("len-fpga booting...");

	serial_load(true);

	while (1);
}
