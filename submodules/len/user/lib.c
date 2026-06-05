#include "kernel/types.h"
#include "kernel/param.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "kernel/riscv.h"
#include "kernel/vm.h"
#include "user/user.h"

#include <stdarg.h>

/* LIB */

void start(int argc, char **argv)
{
	int r;
	extern int main(int argc, char **argv);
	r = main(argc, argv);
	exit(r);
}

char *strcpy(char *s, const char *t)
{
	char *os;

	os = s;
	while((*s++ = *t++) != 0)
		;
	return os;
}

int strcmp(const char *p, const char *q)
{
	while(*p && *p == *q)
		p++, q++;
	return (uint8_t)*p - (uint8_t)*q;
}

uint32_t strlen(const char *s)
{
	int n;

	for(n = 0; s[n]; n++)
		;
	return n;
}

void *memset(void *dst, int c, uint32_t n)
{
	char *cdst = (char *) dst;
	int i;
	for(i = 0; i < n; i++){
		cdst[i] = c;
	}
	return dst;
}

char *strchr(const char *s, char c)
{
	for(; *s; s++)
		if(*s == c)
			return (char*)s;
	return 0;
}

char *strcat(char *dst, const char *src)
{
    char *os;

    os = dst;

    while(*dst) {
        dst++;
	}

    while((*dst++ = *src++) != 0)
        ;

    return os;
}

char *gets(char *buf, int max)
{
	int i, cc;
	char c;

	for(i=0; i+1 < max; ){
		cc = read(0, &c, 1);
		if(cc < 1)
			break;
		buf[i++] = c;
		if(c == '\n' || c == '\r')
			break;
	}
	buf[i] = '\0';
	return buf;
}

int stat(const char *n, struct stat *st)
{
	int fd;
	int r;

	fd = open(n, O_RDONLY);
	if(fd < 0)
		return -1;
	r = fstat(fd, st);
	close(fd);
	return r;
}

int atoi(const char *s)
{
	int n;

	n = 0;
	while('0' <= *s && *s <= '9')
		n = n*10 + *s++ - '0';
	return n;
}

void *memmove(void *vdst, const void *vsrc, int n)
{
	char *dst;
	const char *src;

	dst = vdst;
	src = vsrc;
	if (src > dst) {
		while(n-- > 0)
			*dst++ = *src++;
	} else {
		dst += n;
		src += n;
		while(n-- > 0)
			*--dst = *--src;
	}
	return vdst;
}

int memcmp(const void *s1, const void *s2, uint32_t n)
{
	const char *p1 = s1, *p2 = s2;
	while (n-- > 0) {
		if (*p1 != *p2) {
			return *p1 - *p2;
		}
		p1++;
		p2++;
	}
	return 0;
}

void *memcpy(void *dst, const void *src, uint32_t n)
{
	return memmove(dst, src, n);
}

void *usbrk(int n) {
	return sbrk(n, SBRK_EAGER);
}

void *usbrklazy(int n) {
	return sbrk(n, SBRK_LAZY);
}

/* MALLOC */

union header {
	struct {
		union header *ptr;
		uint32_t size;
	} s;
	long x;
};

typedef union header header;

static header base;
static header *freep;

void free(void *ap)
{
	header *bp, *p;

	bp = (header*)ap - 1;
	for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
		if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
			break;
	if(bp + bp->s.size == p->s.ptr){
		bp->s.size += p->s.ptr->s.size;
		bp->s.ptr = p->s.ptr->s.ptr;
	} else
		bp->s.ptr = p->s.ptr;
	if(p + p->s.size == bp){
		p->s.size += bp->s.size;
		p->s.ptr = bp->s.ptr;
	} else
		p->s.ptr = bp;
	freep = p;
}

static header *morecore(uint32_t nu)
{
	char *p;
	header *hp;

	if(nu < 4096)
		nu = 4096;
	p = (char*)usbrk(nu * sizeof(header));
	if(p == SBRK_ERROR)
		return 0;
	hp = (header*)p;
	hp->s.size = nu;
	free((void*)(hp + 1));
	return freep;
}

void *malloc(uint32_t nbytes)
{
	header *p, *prevp;
	uint32_t nunits;

	nunits = (nbytes + sizeof(header) - 1)/sizeof(header) + 1;
	if((prevp = freep) == 0){
		base.s.ptr = freep = prevp = &base;
		base.s.size = 0;
	}
	for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
		if(p->s.size >= nunits){
			if(p->s.size == nunits)
				prevp->s.ptr = p->s.ptr;
			else {
				p->s.size -= nunits;
				p += p->s.size;
				p->s.size = nunits;
			}
			freep = prevp;
			return (void*)(p + 1);
		}
		if(p == freep)
			if((p = morecore(nunits)) == 0)
				return 0;
	}
}

/* PRINTF */

static char digits[] = "0123456789ABCDEF";

void putc(int fd, char c)
{
	write(fd, &c, 1);
}

static void printint(int fd, long long xx, int base, int sgn)
{
	char buf[20];
	int i, neg;
	unsigned long long x;

	neg = 0;
	if(sgn && xx < 0){
		neg = 1;
		x = -xx;
	} else {
		x = xx;
	}

	i = 0;
	do{
		buf[i++] = digits[x % base];
	}while((x /= base) != 0);
	if(neg)
		buf[i++] = '-';

	while(--i >= 0)
		putc(fd, buf[i]);
}

static void printptr(int fd, uint64_t x) {
	int i;
	putc(fd, '0');
	putc(fd, 'x');
	for (i = 0; i < (sizeof(uint64_t) * 2); i++, x <<= 4)
		putc(fd, digits[x >> (sizeof(uint64_t) * 8 - 4)]);
}

void vprintf(int fd, const char *fmt, va_list ap)
{
	char *s;
	int c0, c1, c2, i, state;

	state = 0;
	for(i = 0; fmt[i]; i++){
		c0 = fmt[i] & 0xff;
		if(state == 0){
			if(c0 == '%'){
				state = '%';
			} else {
				putc(fd, c0);
			}
		} else if(state == '%'){
			c1 = c2 = 0;
			if(c0) c1 = fmt[i+1] & 0xff;
			if(c1) c2 = fmt[i+2] & 0xff;
			if(c0 == 'd'){
				printint(fd, va_arg(ap, int), 10, 1);
			} else if(c0 == 'l' && c1 == 'd'){
				printint(fd, va_arg(ap, uint64_t), 10, 1);
				i += 1;
			} else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
				printint(fd, va_arg(ap, uint64_t), 10, 1);
				i += 2;
			} else if(c0 == 'u'){
				printint(fd, va_arg(ap, uint32_t), 10, 0);
			} else if(c0 == 'l' && c1 == 'u'){
				printint(fd, va_arg(ap, uint64_t), 10, 0);
				i += 1;
			} else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
				printint(fd, va_arg(ap, uint64_t), 10, 0);
				i += 2;
			} else if(c0 == 'x'){
				printint(fd, va_arg(ap, uint32_t), 16, 0);
			} else if(c0 == 'l' && c1 == 'x'){
				printint(fd, va_arg(ap, uint64_t), 16, 0);
				i += 1;
			} else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
				printint(fd, va_arg(ap, uint64_t), 16, 0);
				i += 2;
			} else if(c0 == 'p'){
				printptr(fd, va_arg(ap, uint64_t));
			} else if(c0 == 'c'){
				putc(fd, va_arg(ap, uint32_t));
			} else if(c0 == 's'){
				if((s = va_arg(ap, char*)) == 0)
					s = "(null)";
				for(; *s; s++)
					putc(fd, *s);
			} else if(c0 == '%'){
				putc(fd, '%');
			} else {
				// Unknown % sequence.  Print it to draw attention.
				putc(fd, '%');
				putc(fd, c0);
			}

			state = 0;
		}
	}
}

void fprintf(int fd, const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vprintf(fd, fmt, ap);
}

void printf(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vprintf(1, fmt, ap);
}
