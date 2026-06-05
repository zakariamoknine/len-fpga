#ifndef _LEN_STAT_H_
#define _LEN_STAT_H_

#define T_DIR     1
#define T_FILE    2
#define T_DEVICE  3

struct stat {
	int dev;
	uint32_t ino;
	short type;
	short nlink;
	uint64_t size;
};

#endif /* _LEN_STAT_H_ */
