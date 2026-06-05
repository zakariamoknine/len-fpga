#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"

#define COLS 16

static char hexchars[] = "0123456789abcdef";

static void
put_hex(int fd, uint8_t b)
{
	char buf[2];
	buf[0] = hexchars[(b >> 4) & 0xf];
	buf[1] = hexchars[b & 0xf];
	write(fd, buf, 2);
}

static void
put_u32_hex(int fd, uint32_t v)
{
	put_hex(fd, (v >> 24) & 0xff);
	put_hex(fd, (v >> 16) & 0xff);
	put_hex(fd, (v >>  8) & 0xff);
	put_hex(fd, (v      ) & 0xff);
}

static void
putch(int fd, char c)
{
	write(fd, &c, 1);
}

static void
puts_str(int fd, const char *s)
{
	write(fd, s, strlen(s));
}

static void
xxd_fd(int fd)
{
	uint8_t buf[COLS];
	uint32_t offset = 0;
	int n, i;

	while((n = read(fd, buf, COLS)) > 0){
		put_u32_hex(1, offset);
		puts_str(1, ": ");

		for(i = 0; i < COLS; i++){
			if(i == COLS/2)
				putch(1, ' ');
			if(i < n){
				put_hex(1, buf[i]);
				putch(1, ' ');
			} else {
				puts_str(1, "   ");
			}
		}

		puts_str(1, " ");

		for(i = 0; i < n; i++){
			char c = (buf[i] >= 0x20 && buf[i] < 0x7f) ? (char)buf[i] : '.';
			putch(1, c);
		}
		putch(1, '\n');

		offset += n;
	}
	if(n < 0){
		fprintf(2, "xxd: read error\n");
		exit(1);
	}
}

int
main(int argc, char *argv[])
{
	int i, fd;

	if(argc <= 1){
		xxd_fd(0);
		exit(0);
	}

	for(i = 1; i < argc; i++){
		if((fd = open(argv[i], O_RDONLY)) < 0){
			fprintf(2, "xxd: cannot open %s\n", argv[i]);
			exit(1);
		}
		xxd_fd(fd);
		close(fd);
	}

	exit(0);
}
