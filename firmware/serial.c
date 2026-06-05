#include "serial.h"

static uint8_t read8(void)
{
	return uart_getc();
}

static uint32_t read32(void) 
{
	uint32_t val = 0;

	val |= ((uint32_t)read8()) << 0;
	val |= ((uint32_t)read8()) << 8;
	val |= ((uint32_t)read8()) << 16;
	val |= ((uint32_t)read8()) << 24;

	return val;
}

static void read_payload(uint8_t *addr, size_t len, uint32_t *crc_out)
{
    uint32_t crc = crc32_init();

    for (size_t i = 0; i < len; i++) {
        uint8_t b = read8();
        addr[i]   = b;
        crc       = crc32_update(crc, b);
    }

    *crc_out = crc32_final(crc);
}

int serial_load(phys_addr_t addr)
{
	struct serial_header hdr;

	print("Serial loading... Waiting for data\n");

	hdr.magic = read32();
	hdr.size  = read32();

	if (hdr.magic != SERIAL_MAGIC) {
		print("Bad magic: 0x%x\n", hdr.magic);
		return -1;
	}

	if (hdr.size > DDR2_SIZE) {
		print("Payload too large: %d\n", hdr.size);
		return -1;
	}

	print("Header parsed successfully!\n");
	print(" - Payload size   : %d bytes\n", hdr.size);
	print(" - Payload addr   : %p\n", addr);

	uint32_t computed_crc;
    read_payload((uint8_t *)addr, hdr.size, &computed_crc);
    uint32_t received_crc = read32();

	if (computed_crc != received_crc) {
		print("CRC FAIL: computed 0x%x  received 0x%x\n", computed_crc, received_crc);
		return -1;
	}

	print("CRC OK: 0x%x\n", received_crc);

	return 0;
}
