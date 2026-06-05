#ifndef _LEN_FPGA_SERIAL_H_
#define _LEN_FPGA_SERIAL_H_

#include "internal.h"
#include "print.h"
#include "crc32.h"

#define SERIAL_MAGIC 0xACF3FA19

struct serial_header {
	uint32_t magic;
	uint32_t size;
};

int serial_load(phys_addr_t addr);

#endif /* !_LEN_FPGA_SERIAL_H_ */
