#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"
 
#define BUFSIZE 512
 
static char buf[BUFSIZE];
 
static void
head(int fd, int nlines)
{
	int n, i;
	int remaining = nlines;
 
	while(remaining > 0 && (n = read(fd, buf, BUFSIZE)) > 0){
		for(i = 0; i < n && remaining > 0; i++){
			if(write(1, buf + i, 1) != 1){
				fprintf(2, "head: write error\n");
				exit(1);
			}
			if(buf[i] == '\n')
				remaining--;
		}
	}
	if(n < 0){
		fprintf(2, "head: read error\n");
		exit(1);
	}
}
 
int
main(int argc, char *argv[])
{
	int fd, i;
	int nlines = 10;  // default
	int first_file = 1;
 
	if(argc > 1 && argv[1][0] == '-' && argv[1][1] != '\0'){
		nlines = atoi(argv[1] + 1);
		if(nlines <= 0){
			fprintf(2, "head: invalid line count '%s'\n", argv[1]);
			exit(1);
		}
		first_file = 2;
	}
 
	if(first_file >= argc){
		head(0, nlines);
		exit(0);
	}
 
	int multiple = (argc - first_file) > 1;
	for(i = first_file; i < argc; i++){
		if((fd = open(argv[i], O_RDONLY)) < 0){
			fprintf(2, "head: cannot open %s\n", argv[i]);
			exit(1);
		}
		if(multiple)
			printf("==> %s <==\n", argv[i]);
		head(fd, nlines);
		if(multiple && i + 1 < argc)
			printf("\n");
		close(fd);
	}
 
	exit(0);
}
