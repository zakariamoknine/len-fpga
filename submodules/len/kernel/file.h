#ifndef _LEN_FILE_H_
#define _LEN_FILE_H_

struct file {
	enum { FD_NONE, FD_PIPE, FD_INODE, FD_DEVICE } type;
	int ref;
	char readable;
	char writable;
	char nonblock;
	struct pipe *pipe;
	struct inode *ip;
	uint32_t off;
	short major;
};

#define major(dev)  ((dev) >> 16 & 0xFFFF)
#define minor(dev)  ((dev) & 0xFFFF)
#define	mkdev(m,n)  ((uint32_t)((m)<<16| (n)))

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

struct inode {
	uint32_t dev;
	uint32_t inum;
	int ref;
	struct sleeplock lock;
	int valid;

	short type;
	short major;
	short minor;
	short nlink;
	uint32_t size;
	uint32_t addrs[NDIRECT+2];
};

struct devsw {
	int (*read)(int, uint64_t, uint64_t, int, int);
	int (*write)(int, uint64_t, uint64_t, int);
	uint64_t (*mmap)(uint64_t);
};

extern struct devsw devsw[];

#define CONS_DEV   1
#define FB_DEV     2
#define URAND_DEV  3
#define ZERO_DEV   4
#define NULL_DEV   5

#endif /* _LEN_FILE_H_ */
