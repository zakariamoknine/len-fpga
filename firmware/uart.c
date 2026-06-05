#include "uart.h"

void uart_init(uint32_t baudrate, uint32_t clk_hz) {
	uint16_t divisor = (uint16_t)(clk_hz / (16 * baudrate));

	writeb(UART_LCR, UART_LCR_DLAB);
	writeb(UART_DLL, divisor & 0xFF);
	writeb(UART_DLM, (divisor >> 8) & 0xFF);
	writeb(UART_LCR, UART_LCR_8N1);
	writeb(UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RX | UART_FCR_CLEAR_TX);
	writeb(UART_MCR, UART_MCR_DTR | UART_MCR_RTS);

	/* Disable interrupts */
	writeb(UART_IER, 0x00);
}

void uart_putc(char c) {
	while ((readb(UART_LSR) & 0x20) == 0);
	writeb(UART_THR, c);
}

char uart_getc(void) {
	while ((readb(UART_LSR) & 0x01) == 0);
	return readb(UART_RBR);
}
