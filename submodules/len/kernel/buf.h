#ifndef _LEN_BUF_H_
#define _LEN_BUF_H_

#include "fs.h"

struct buf {
	int valid;
	int disk;
	uint32_t dev;
	uint32_t blockno;
	struct sleeplock lock;
	uint32_t refcnt;
	struct buf *prev;
	struct buf *next;
	uint8_t data[BSIZE];
};

#endif /* _LEN_BUF_H_ */
