#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"

#define MAXFILES 16
#define BUFSIZE  512

int
main(int argc, char *argv[])
{
	int fds[MAXFILES];
	int nfds = 0;
	int append = 0;
	int i, n;
	char buf[BUFSIZE];

	for(i = 1; i < argc; i++){
		if(argv[i][0] == '-' && argv[i][1] == 'a'){
			append = 1;
		} else {
			if(nfds >= MAXFILES){
				fprintf(2, "tee: too many files\n");
				exit(1);
			}
			int flags = append ? (O_WRONLY|O_CREATE) : (O_WRONLY|O_CREATE|O_TRUNC);
			fds[nfds] = open(argv[i], flags);
			if(fds[nfds] < 0){
				fprintf(2, "tee: cannot open %s\n", argv[i]);
				exit(1);
			}
			nfds++;
		}
	}

	while((n = read(0, buf, BUFSIZE)) > 0){
		if(write(1, buf, n) != n){
			fprintf(2, "tee: write error on stdout\n");
			exit(1);
		}
		for(i = 0; i < nfds; i++){
			if(write(fds[i], buf, n) != n){
				fprintf(2, "tee: write error\n");
				exit(1);
			}
		}
	}
	if(n < 0){
		fprintf(2, "tee: read error\n");
		exit(1);
	}

	for(i = 0; i < nfds; i++)
		close(fds[i]);

	exit(0);
}
