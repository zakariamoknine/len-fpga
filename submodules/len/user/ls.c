#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"
#include "user/user.h"

char* fmtname(char *path)
{
	static char buf[DIRSIZ+1];
	char *p;
	
	for(p = path + strlen(path); p >= path && *p != '/'; p--)
		;
	p++;
	
	if(strlen(p) >= DIRSIZ)
		return p;
	
	memmove(buf, p, strlen(p));
	buf[strlen(p)] = '\0';
	return buf;
}

char* typeperm(int type)
{
	static char buf[11];

	if(type == T_DIR)
		strcpy(buf, "drwxr-xr-x");
	else if(type == T_DEVICE)
		strcpy(buf, "crw-rw-rw-");
	else
		strcpy(buf, "-rw-r--r--");

	return buf;
}

void padding(int x, int width)
{
	char buf[32];
	int i = 0, j;

	if(x == 0){
		buf[i++] = '0';
	} else {
		while(x > 0){
			buf[i++] = '0' + (x % 10);
			x /= 10;
		}
	}

	for(j = i; j < width; j++)
		putc(1, ' ');

	while(i-- > 0)
		putc(1, buf[i]);
}

void print_entry(char *name, struct stat *st)
{
	char *perm = typeperm(st->type);

	printf("%s ", perm);

	padding(st->nlink, 3);
	putc(1, ' ');

	padding(st->ino, 5);
	putc(1, ' ');

	padding(st->size, 8);
	putc(1, ' ');

	printf("%s%s\n", name, (st->type == T_DIR) ? "/" : "");
}

void ls(char *path)
{
	char buf[512], *p;
	int fd;
	struct dirent de;
	struct stat st;

	if((fd = open(path, O_RDONLY)) < 0){
		fprintf(2, "ls: cannot open %s\n", path);
		return;
	}

	if(fstat(fd, &st) < 0){
		fprintf(2, "ls: cannot stat %s\n", path);
		close(fd);
		return;
	}

	switch(st.type){
	case T_DEVICE:
	case T_FILE:
		print_entry(fmtname(path), &st);
		break;

	case T_DIR:
		if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
			printf("ls: path too long\n");
			break;
		}
		strcpy(buf, path);
		p = buf+strlen(buf);
		*p++ = '/';
		while(read(fd, &de, sizeof(de)) == sizeof(de)){
			if(de.inum == 0)
				continue;
			memmove(p, de.name, DIRSIZ);
			p[DIRSIZ] = 0;
			if(stat(buf, &st) < 0){
				printf("ls: cannot stat %s\n", buf);
				continue;
			}
			print_entry(fmtname(buf), &st);
		}
		break;
	}
	close(fd);
}

int main(int argc, char *argv[])
{
	int i;

	if(argc < 2){
		ls(".");
		exit(0);
	}

	for(i=1; i<argc; i++) {
		ls(argv[i]);
	}

	exit(0);
}
