#include "print.h"

/*
 * We try to avoid standard headers, but <stdarg.h> is a must
 * for implementing print()
 */
#include <stdarg.h>

static void putchar(char c)
{
	if (c == '\n') {
		uart_putc('\r');
		uart_putc('\n');
		return;
	}

	uart_putc(c);
}

static void putstring(const char* str)
{
	while(*str) {
		putchar(*str++);
	}
}

static const char* digits_str = "0123456789abcdef";

static void putnumber(uint64_t num, uint8_t base, uint8_t sign)
{
	char buf[32];
	int32_t i = 0;

	if (sign && (int64_t)num < 0) {
		putchar('-');
		num = -(int64_t)num;
	}

	if (num == 0) {
		putchar('0');
		return;
	}

	while (num > 0) {
		buf[i++] = digits_str[num % base];
		num /= base;
	}

	while (--i >= 0) {
		putchar(buf[i]);
	}
}

static void vprint(const char* str, va_list ap)
{
	for (const char* c = str; *c; c++) {
		if (*c != '%') {
			putchar(*c);
			continue;
		}

		c++;

		switch (*c) {
		case 'c': {
			char ch = (char)va_arg(ap, int);
			putchar(ch);
			break;
		}
		case 's': {
			const char* s = va_arg(ap, const char*);
			putstring(s ? s : "(null)");
			break;
		}
		case 'd': {
			int val = va_arg(ap, int);
			putnumber(val, 10, 1);
			break;
		}
		case 'u': {
			uint32_t val = va_arg(ap, unsigned);
			putnumber(val, 10, 0);
			break;
		}
		case 'x': {
			uint32_t val = va_arg(ap, unsigned);
			putnumber(val, 16, 0);
			break;
		}
		case 'p': {
			uintptr_t val = (uintptr_t)va_arg(ap, void*);
			putstring("0x");
			putnumber(val, 16, 0);
			break;
		}
		case '%':
			putchar('%');
			break;
		default:
			putchar('%');
			putchar(*c);
			break;
		}
	}
}

void print(const char* str, ...)
{
	va_list ap;
	va_start(ap, str);
	vprint(str, ap);
	va_end(ap);
}
