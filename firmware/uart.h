#ifndef _LEN_UART_H_
#define _LEN_UART_H_

#include <stdint.h>
#include <stddef.h>

void uart_init(uint32_t baudrate, uint32_t clk_hz);

void uart_putc(char c);
char uart_getc(void);

void printk(const char* str, ...);

#endif /* !_LEN_UART_H_ */
