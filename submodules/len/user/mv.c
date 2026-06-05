#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"
 
#define BUFSIZE 4096
 
static char buf[BUFSIZE];
 
static int
copy_and_remove(char *src, char *dst)
{
	int fdin, fdout, n;
 
	if((fdin = open(src, O_RDONLY)) < 0){
		fprintf(2, "mv: cannot open %s\n", src);
		return -1;
	}
	if((fdout = open(dst, O_WRONLY|O_CREATE|O_TRUNC)) < 0){
		fprintf(2, "mv: cannot create %s\n", dst);
		close(fdin);
		return -1;
	}
	while((n = read(fdin, buf, BUFSIZE)) > 0){
		if(write(fdout, buf, n) != n){
			fprintf(2, "mv: write error on %s\n", dst);
			close(fdin);
			close(fdout);
			return -1;
		}
	}
	if(n < 0){
		fprintf(2, "mv: read error on %s\n", src);
		close(fdin);
		close(fdout);
		return -1;
	}
	close(fdin);
	close(fdout);
	if(unlink(src) < 0){
		fprintf(2, "mv: cannot remove %s\n", src);
		return -1;
	}
	return 0;
}
 
int
main(int argc, char *argv[])
{
	struct stat st;
 
	if(argc != 3){
		fprintf(2, "Usage: mv <src> <dst>\n");
		exit(1);
	}
 
	if(stat(argv[1], &st) < 0){
		fprintf(2, "mv: cannot stat %s\n", argv[1]);
		exit(1);
	}
	if(st.type == T_DIR){
		fprintf(2, "mv: %s: is a directory\n", argv[1]);
		exit(1);
	}
 
	if(link(argv[1], argv[2]) == 0){
		if(unlink(argv[1]) < 0){
			fprintf(2, "mv: cannot remove %s\n", argv[1]);
			exit(1);
		}
		exit(0);
	}
 
	if(copy_and_remove(argv[1], argv[2]) < 0)
		exit(1);
 
	exit(0);
}
