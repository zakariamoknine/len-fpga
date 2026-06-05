#include "len.h"

#include "fs.h"
#include "file.h"
#include "proc.h"

#include <stdarg.h>

volatile int panicking = 0;
volatile int panicked = 0;

static struct {
	struct spinlock lock;
} pr;

static char digits[] = "0123456789abcdef";

static void printint(long long xx, int base, int sign)
{
	char buf[20];
	int i;
	unsigned long long x;

	if(sign && (sign = (xx < 0)))
		x = -xx;
	else
		x = xx;

	i = 0;
	do {
		buf[i++] = digits[x % base];
	} while((x /= base) != 0);

	if(sign)
		buf[i++] = '-';

	while(--i >= 0)
		consputc(buf[i]);
}

static void printptr(uint64_t x)
{
	int i;
	consputc('0');
	consputc('x');
	for (i = 0; i < (sizeof(uint64_t) * 2); i++, x <<= 4)
		consputc(digits[x >> (sizeof(uint64_t) * 8 - 4)]);
}

int printf(char *fmt, ...)
{
	va_list ap;
	int i, cx, c0, c1, c2;
	char *s;

	if(panicking == 0)
		acquire(&pr.lock);

	va_start(ap, fmt);
	for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
		if(cx != '%'){
			consputc(cx);
			continue;
		}
		i++;
		c0 = fmt[i+0] & 0xff;
		c1 = c2 = 0;
		if(c0) c1 = fmt[i+1] & 0xff;
		if(c1) c2 = fmt[i+2] & 0xff;
		if(c0 == 'd'){
			printint(va_arg(ap, int), 10, 1);
		} else if(c0 == 'l' && c1 == 'd'){
			printint(va_arg(ap, uint64_t), 10, 1);
			i += 1;
		} else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
			printint(va_arg(ap, uint64_t), 10, 1);
			i += 2;
		} else if(c0 == 'u'){
			printint(va_arg(ap, uint32_t), 10, 0);
		} else if(c0 == 'l' && c1 == 'u'){
			printint(va_arg(ap, uint64_t), 10, 0);
			i += 1;
		} else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
			printint(va_arg(ap, uint64_t), 10, 0);
			i += 2;
		} else if(c0 == 'x'){
			printint(va_arg(ap, uint32_t), 16, 0);
		} else if(c0 == 'l' && c1 == 'x'){
			printint(va_arg(ap, uint64_t), 16, 0);
			i += 1;
		} else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
			printint(va_arg(ap, uint64_t), 16, 0);
			i += 2;
		} else if(c0 == 'p'){
			printptr(va_arg(ap, uint64_t));
		} else if(c0 == 'c'){
			consputc(va_arg(ap, uint32_t));
		} else if(c0 == 's'){
			if((s = va_arg(ap, char*)) == 0)
				s = "(null)";
			for(; *s; s++)
				consputc(*s);
		} else if(c0 == '%'){
			consputc('%');
		} else if(c0 == 0){
			break;
		} else {
			consputc('%');
			consputc(c0);
		}

	}
	va_end(ap);

	if(panicking == 0)
		release(&pr.lock);

	return 0;
}

void panic(char *s)
{
	panicking = 1;
	printf("panic: ");
	printf("%s\n", s);
	panicked = 1;
	for(;;)
		;
}

void printfinit(void)
{
	initlock(&pr.lock, "pr");
}
