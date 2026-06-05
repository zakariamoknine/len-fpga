#include "len.h"

#include "fs.h"
#include "buf.h"

void ramfsinit(void)
{
}

void ramfs_rw(struct buf *b, int write)
{
	if(!holdingsleep(&b->lock))
		panic("include/ramdiskrw: buf not locked");

	if(b->blockno >= FSSIZE)
		panic("include/ramdiskrw: sectorno too big");

    uint64_t addr = RAMFS_BASE + (uint64_t)b->blockno * BSIZE;

    if((addr + BSIZE) > (RAMFS_BASE + RAMFS_SIZE))
        panic("ramfs: block out of range");

    if(write) {
        memmove((void*)addr, b->data, BSIZE);
	}
	else {
        memmove(b->data, (void*)addr, BSIZE);
	}
}
