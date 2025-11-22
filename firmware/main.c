#include "print.h"
#include "serial.h"

void start(void)
{
	uart_init(UART_BAUDRATE, UART_CLK_FREQ);
	print("len-fpga is booting...\n");

	serial_load(true);

	while (1);
}
