#include "serial.h"

#define LOAD_ADDR  DDR2_BASE
#define LOAD_SIZE  5456

void show_progress(size_t recvd)
{
	if ((recvd & 0xFFF) == 0) {
		print(".");
	}
}

void serial_load(void)
{
	print("Serial load starting...\n");
	print("Loading 'opensbi.mem' into addr=%p\n", LOAD_ADDR);

	volatile uint8_t *dest = (volatile uint8_t *)(LOAD_ADDR);	
	size_t recvd = 0;
	
	print("Reading bytes...\n");

	while (recvd < LOAD_SIZE) {
		uint8_t byte_data = uart_getc();
		*dest++ = byte_data;
		recvd++;

		show_progress(recvd);
	}

	print("\nFinished! jumping to load\n");

	void (*load_entry)(void) = (void (*)(void))(LOAD_ADDR);
	load_entry();

	__sync_synchronize();

	while (1);
}
