#ifndef _LEN_FPGA_CRC32_H_
#define _LEN_FPGA_CRC32_H_

#include "internal.h"

uint32_t crc32_init(void);
uint32_t crc32_update(uint32_t crc, uint8_t byte);
uint32_t crc32_final(uint32_t crc);

#endif /* !_LEN_FPGA_CRC32_H_ */
