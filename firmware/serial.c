#include "serial.h"

#define LOAD_MIN_ADDR DDR2_BASE
#define LOAD_MAX_SIZE DDR2_SIZE

static uint8_t read_byte(void)
{
	return uart_getc();
}

static uint32_t read_u32(void) 
{
	uint32_t val = 0;

	val |= ((uint32_t)read_byte()) << 0;
	val |= ((uint32_t)read_byte()) << 8;
	val |= ((uint32_t)read_byte()) << 16;
	val |= ((uint32_t)read_byte()) << 24;

	return val;
}

static void read_payload(uint8_t *addr, size_t len) {
	for (size_t i = 0; i < len; i++) {
		addr[i] = read_byte();
	}
}

int serial_load(int jump_to_payload)
{
	struct serial_header ph;
	phys_addr_t load_addr, entry_addr;

	ph.magic       = read_u32();
	ph.size        = read_u32();
	ph.load_addr   = read_u32();
	ph.entry_addr  = read_u32();

	load_addr = ph.load_addr;
	entry_addr = ph.entry_addr;

	print("Serial loading... Waiting for data\n");

	if (ph.magic != SERIAL_MAGIC) {
		print("Invalid magic number: %x\n", ph.magic);
		return -1;
	}

	if (load_addr < LOAD_MIN_ADDR) {
		print("Invalid loading addr: %p\n", 
				load_addr);
		return -1;
	}

	if (load_addr + ph.size > LOAD_MIN_ADDR + LOAD_MAX_SIZE) {
		print("Invalid payload size, too large: %d bytes\n", 
				ph.size);
		return -1;
	}

	print("Header parsed successfully!\n");
	print("Payload size : %d bytes\n", ph.size);
	print("Payload addr : %p\n", load_addr);
	print("Entry addr   : %p\n", entry_addr);

	read_payload((uint8_t*)load_addr, ph.size);

	print("Loading done!\n");

	if (jump_to_payload) {
		print("Jumping to entry addr: %p\n", 
				entry_addr);

		void (*entry)(void) = (void(*)(void))(entry_addr);
		entry();
	}

	return 0;
}
