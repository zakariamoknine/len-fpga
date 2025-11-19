#include "print.h"
#include "serial.h"

void start()
{
	uart_init(115200, 100000000);
	print("len-fpga booting...\n");

	volatile uint64_t *mtime = (volatile uint64_t*)(CLINT_MTIME);
	for (int i = 0; i < 10; i++) {
		print("mtime: %p\n", *mtime);
	}

	serial_load(true);

	while (1);
}
