#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"
 
#define BUFSIZE 4096
 
static char buf[BUFSIZE];
 
static int
copy_file(char *src, char *dst)
{
	int fdin, fdout, n;
	struct stat st;
 
	if((fdin = open(src, O_RDONLY)) < 0){
		fprintf(2, "cp: cannot open %s\n", src);
		return -1;
	}
	if(fstat(fdin, &st) < 0){
		fprintf(2, "cp: cannot stat %s\n", src);
		close(fdin);
		return -1;
	}
	if(st.type == T_DIR){
		fprintf(2, "cp: %s: is a directory\n", src);
		close(fdin);
		return -1;
	}
	if((fdout = open(dst, O_WRONLY|O_CREATE|O_TRUNC)) < 0){
		fprintf(2, "cp: cannot create %s\n", dst);
		close(fdin);
		return -1;
	}
	while((n = read(fdin, buf, BUFSIZE)) > 0){
		if(write(fdout, buf, n) != n){
			fprintf(2, "cp: write error on %s\n", dst);
			close(fdin);
			close(fdout);
			return -1;
		}
	}
	if(n < 0){
		fprintf(2, "cp: read error on %s\n", src);
		close(fdin);
		close(fdout);
		return -1;
	}
	close(fdin);
	close(fdout);
	return 0;
}
 
int
main(int argc, char *argv[])
{
	if(argc != 3){
		fprintf(2, "Usage: cp <src> <dst>\n");
		exit(1);
	}

	if(copy_file(argv[1], argv[2]) < 0) {
		exit(1);
	}
	exit(0);
}
