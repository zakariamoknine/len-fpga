#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"

#define MAXFIELDS 64
#define LINEBUF   4096

static int range_lo[MAXFIELDS];
static int range_hi[MAXFIELDS];
static int nranges;

static char delim = '\t';
static int  use_bytes = 0;  // -b: byte mode
static int  use_chars = 0;  // -c: char mode (same as -b here)
static int  use_fields = 0; // -f: field mode

static int
parse_list(char *s)
{
	nranges = 0;
	while(*s){
		int lo = 0, hi = 0;
		if(*s < '0' || *s > '9'){
			fprintf(2, "cut: invalid field specification\n");
			return -1;
		}
		while(*s >= '0' && *s <= '9')
			lo = lo * 10 + (*s++ - '0');
		if(*s == '-'){
			s++;
			if(*s >= '0' && *s <= '9'){
				while(*s >= '0' && *s <= '9')
					hi = hi * 10 + (*s++ - '0');
			} else {
				hi = 1<<30; // open-ended range
			}
		} else {
			hi = lo;
		}
		if(lo < 1 || hi < lo){
			fprintf(2, "cut: invalid range\n");
			return -1;
		}
		if(nranges >= MAXFIELDS){
			fprintf(2, "cut: too many fields\n");
			return -1;
		}
		range_lo[nranges] = lo;
		range_hi[nranges] = hi;
		nranges++;
		if(*s == ',') s++;
		else break;
	}
	return 0;
}

static int
in_range(int n)
{
	int i;
	for(i = 0; i < nranges; i++)
		if(n >= range_lo[i] && n <= range_hi[i])
			return 1;
	return 0;
}

static char linebuf[LINEBUF];

static void
cut_line(char *line, int len)
{
	// Remove trailing newline for processing; re-add at end
	int has_nl = (len > 0 && line[len-1] == '\n');
	if(has_nl) len--;

	if(use_bytes || use_chars){
		// Byte/char mode: select individual byte positions
		int i;
		for(i = 0; i < len; i++){
			if(in_range(i + 1))
				write(1, line + i, 1);
		}
	} else {
		// Field mode: split by delimiter
		int field = 1;
		int start = 0;
		int printed = 0;
		int i;
		for(i = 0; i <= len; i++){
			if(i == len || line[i] == delim){
				if(in_range(field)){
					if(printed) write(1, &delim, 1);
					write(1, line + start, i - start);
					printed = 1;
				}
				field++;
				start = i + 1;
			}
		}
	}
	if(has_nl){
		char nl = '\n';
		write(1, &nl, 1);
	} else if(len > 0){
		// Last line without newline
	}
}

static void
cut_fd(int fd)
{
	char buf[512];
	int m = 0, n;

	while((n = read(fd, buf + m, sizeof(buf) - m - 1)) > 0){
		m += n;
		buf[m] = '\0';
		char *p = buf;
		char *q;
		while((q = strchr(p, '\n')) != 0){
			// Process line p..q (inclusive of newline)
			int len = (int)(q - p + 1);
			if(len >= LINEBUF) len = LINEBUF - 1;
			memmove(linebuf, p, len);
			linebuf[len] = '\0';
			cut_line(linebuf, len);
			p = q + 1;
		}
		m -= (int)(p - buf);
		if(m > 0) memmove(buf, p, m);
	}
	// Handle last line (no trailing newline)
	if(m > 0){
		buf[m] = '\0';
		cut_line(buf, m);
	}
}

int
main(int argc, char *argv[])
{
	int i;
	int first_file = 1;
	char *list = 0;

	for(i = 1; i < argc; i++){
		if(argv[i][0] == '-' && argv[i][1] != '\0'){
			char opt = argv[i][1];
			if(opt == 'd'){
				if(argv[i][2]){
					delim = argv[i][2];
				} else {
					i++;
					if(i >= argc){ fprintf(2, "cut: option requires an argument -- 'd'\n"); exit(1); }
					delim = argv[i][0];
				}
				first_file = i + 1;
			} else if(opt == 'f' || opt == 'b' || opt == 'c'){
				if(opt == 'f') use_fields = 1;
				else           use_bytes  = 1;
				if(argv[i][2]){
					list = argv[i] + 2;
				} else {
					i++;
					if(i >= argc){ fprintf(2, "cut: option requires an argument -- '%c'\n", opt); exit(1); }
					list = argv[i];
				}
				first_file = i + 1;
			}
		} else {
			first_file = i;
			break;
		}
	}

	if(!list){
		fprintf(2, "Usage: cut -f list [-d delim] [file...]\n"
		           "       cut -b list [file...]\n");
		exit(1);
	}
	if(!use_fields && !use_bytes && !use_chars)
		use_fields = 1;

	if(parse_list(list) < 0)
		exit(1);

	if(first_file >= argc){
		cut_fd(0);
		exit(0);
	}

	for(i = first_file; i < argc; i++){
		int fd;
		if((fd = open(argv[i], O_RDONLY)) < 0){
			fprintf(2, "cut: cannot open %s\n", argv[i]);
			exit(1);
		}
		cut_fd(fd);
		close(fd);
	}

	exit(0);
}
