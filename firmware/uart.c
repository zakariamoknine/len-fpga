#include "uart.h"

static inline void uart_write_reg(uint32_t offset, uint8_t value) {
	*(volatile uint8_t *)(UART_BASE + offset) = value;
}

static inline uint8_t uart_read_reg(uint32_t offset) {
	return *(volatile uint8_t *)(UART_BASE + offset);
}

void uart_init(uint32_t baudrate, uint32_t clk_hz) {
	uint16_t divisor = (uint16_t)(clk_hz / (16 * baudrate));

	uart_write_reg(UART_LCR, LCR_DLAB);
	uart_write_reg(UART_DLL, divisor & 0xFF);
	uart_write_reg(UART_DLM, (divisor >> 8) & 0xFF);
	uart_write_reg(UART_LCR, LCR_8N1);
	uart_write_reg(UART_FCR, FCR_ENABLE_FIFO | FCR_CLEAR_RX | FCR_CLEAR_TX);
	uart_write_reg(UART_MCR, MCR_DTR | MCR_RTS);
}

void uart_putc(char c) {
	while ((uart_read_reg(UART_LSR) & 0x20) == 0);
	uart_write_reg(UART_THR, c);
}

char uart_getc(void) {
	while ((uart_read_reg(UART_LSR) & 0x01) == 0);
	return uart_read_reg(UART_RBR);
}
