#include "uart.h"

#include <stdarg.h>

#define UART_BASE        0x30000000ULL

#define UART_RBR         0x00
#define UART_THR         0x00
#define UART_DLL         0x00
#define UART_IER         0x04
#define UART_DLM         0x04
#define UART_FCR         0x08
#define UART_LCR         0x0C
#define UART_MCR         0x10
#define UART_LSR         0x14
#define UART_MSR         0x18
#define UART_SCR         0x1C

#define LCR_DLAB         (1 << 7)
#define LCR_8N1          0x03
#define FCR_ENABLE_FIFO  (1 << 0)
#define FCR_CLEAR_RX     (1 << 1)
#define FCR_CLEAR_TX     (1 << 2)
#define MCR_DTR          (1 << 0)
#define MCR_RTS          (1 << 1)

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

static void pchar(char c)
{
	uart_putc(c);
}

static void pstring(const char* str)
{
	while(*str) {
		pchar(*str++);
	}
}

static const char* digits = "0123456789abcdef";

static void pnumber(uint64_t num, uint8_t base, uint8_t sign)
{
	char buf[32];
	int32_t i = 0;

	if (sign && (int64_t)num < 0) {
		pchar('-');
		num = -(int64_t)num;
	}

	if (num == 0) {
		pchar('0');
		return;
	}

	while (num > 0) {
		buf[i++] = digits[num % base];
		num /= base;
	}

	while (--i >= 0) {
		pchar(buf[i]);
	}
}

static void vprintk(const char* str, va_list ap)
{
	for (const char* c = str; *c; c++) {
		if (*c == '\n') {
			pchar('\r');
			pchar('\n');
			continue;
		}
		if (*c != '%') {
			pchar(*c);
			continue;
		}

		c++;

		switch (*c) {
		case 'c': {
			char ch = (char)va_arg(ap, int);
			pchar(ch);
			break;
		}
		case 's': {
			const char* s = va_arg(ap, const char*);
			pstring(s ? s : "(null)");
			break;
		}
		case 'd': {
			int val = va_arg(ap, int);
			pnumber(val, 10, 1);
			break;
		}
		case 'u': {
			uint32_t val = va_arg(ap, unsigned);
			pnumber(val, 10, 0);
			break;
		}
		case 'x': {
			uint32_t val = va_arg(ap, unsigned);
			pnumber(val, 16, 0);
			break;
		}
		case 'p': {
			uintptr_t val = (uintptr_t)va_arg(ap, void*);
			pstring("0x");
			pnumber(val, 16, 0);
			break;
		}
		case '%':
			pchar('%');
			break;
		default:
			pchar('%');
			pchar(*c);
			break;
		}
	}
}

void printk(const char* str, ...)
{
	va_list ap;
	va_start(ap, str);
	vprintk(str, ap);
	va_end(ap);
}
