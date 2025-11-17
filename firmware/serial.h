#ifndef _LEN_FPGA_SERIAL_H_
#define _LEN_FPGA_SERIAL_H_

#include "types.h"
#include "mmio.h"
#include "uart.h"
#include "print.h"

#define SERIAL_MAGIC 0x0dca18fb

struct serial_header {
	uint32_t magic;
	uint32_t size;
	uint32_t load_addr;
	uint32_t entry_addr;
};

int serial_load(int jump_to_payload);

#endif /* !_LEN_FPGA_SERIAL_H_ */
