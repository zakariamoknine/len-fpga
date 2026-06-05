#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"
 
int main(int argc, char *argv[])
{
	int i, fd;
 
	if(argc < 2){
		fprintf(stderr, "Usage: touch <file>...\n");
		exit(1);
	}
 
	for(i = 1; i < argc; i++){
		fd = open(argv[i], O_RDONLY);
		if(fd >= 0){
			close(fd);
		} else {
			fd = open(argv[i], O_WRONLY|O_CREATE);
			if(fd < 0){
				fprintf(2, "touch: cannot create %s\n", argv[i]);
				exit(1);
			}
			close(fd);
		}
	}
 
	exit(0);
}
