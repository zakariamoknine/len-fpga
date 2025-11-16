#ifndef _LEN_FPGA_UART_H_
#define _LEN_FPGA_UART_H_

#include "types.h"
#include "mmio.h"

void uart_init(uint32_t baudrate, uint32_t clk_hz);
void uart_putc(char c);
char uart_getc(void);

#endif /* !_LEN_FPGA_UART_H_ */
