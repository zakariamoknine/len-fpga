#ifndef _LEN_FPGA_DEV_H_
#define _LEN_FPGA_DEV_H_

#include "internal.h"

void dev_init(void);

void udelay(uint32_t us);

void poweroff(void);
void reboot(void);

#endif /* !_LEN_FPGA_DEV_H_ */
