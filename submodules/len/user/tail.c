#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"

#define MAXLINES  10000

#define STOREBUF  (1024 * 1024)

static char store[STOREBUF];
static int  store_len;

static int line_off[MAXLINES];
static int line_len[MAXLINES];
static int head_idx;
static int count;
static int nlines;

static void
tail(int fd)
{
	char buf[512];
	int n, i;
	int cur_line_start = 0;

	store_len = 0;
	head_idx  = 0;
	count     = 0;

	while((n = read(fd, buf, sizeof(buf))) > 0){
		for(i = 0; i < n; i++){
			if(store_len >= STOREBUF){
				fprintf(2, "tail: file too large, output may be truncated\n");
				goto done;
			}
			store[store_len++] = buf[i];
			if(buf[i] == '\n'){
				int end = store_len;
				int len = end - cur_line_start;
				int idx = (head_idx + count) % MAXLINES;
				line_off[idx] = cur_line_start;
				line_len[idx] = len;
				if(count < MAXLINES){
					count++;
				} else {
					head_idx = (head_idx + 1) % MAXLINES;
				}
				cur_line_start = end;
			}
		}
	}

	if(cur_line_start < store_len){
		int idx = (head_idx + count) % MAXLINES;
		line_off[idx] = cur_line_start;
		line_len[idx] = store_len - cur_line_start;
		if(count < MAXLINES){
			count++;
		} else {
			head_idx = (head_idx + 1) % MAXLINES;
		}
	}

done:
	int print_count = count < nlines ? count : nlines;
	int start = (head_idx + count - print_count + MAXLINES) % MAXLINES;
	for(i = 0; i < print_count; i++){
		int idx = (start + i) % MAXLINES;
		write(1, store + line_off[idx], line_len[idx]);
	}
}

int
main(int argc, char *argv[])
{
	int fd, i;
	int first_file = 1;

	nlines = 10;

	if(argc > 1 && argv[1][0] == '-' && argv[1][1] != '\0'){
		nlines = atoi(argv[1] + 1);
		if(nlines <= 0){
			fprintf(2, "tail: invalid line count '%s'\n", argv[1]);
			exit(1);
		}
		first_file = 2;
	}
	if(nlines > MAXLINES)
		nlines = MAXLINES;

	if(first_file >= argc){
		tail(0);
		exit(0);
	}

	int multiple = (argc - first_file) > 1;
	for(i = first_file; i < argc; i++){
		if((fd = open(argv[i], O_RDONLY)) < 0){
			fprintf(2, "tail: cannot open %s\n", argv[i]);
			exit(1);
		}
		if(multiple)
			printf("==> %s <==\n", argv[i]);
		tail(fd);
		if(multiple && i + 1 < argc)
			printf("\n");
		close(fd);
	}

	exit(0);
}
