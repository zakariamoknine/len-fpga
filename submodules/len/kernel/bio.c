#include "len.h"

#include "buf.h"
#include "fs.h"

struct {
	struct spinlock lock;
	struct buf buf[NBUF];
	struct buf head;
} bcache;

void buffer_cache_init(void)
{
	struct buf *b;

	initlock(&bcache.lock, "bcache");

	bcache.head.prev = &bcache.head;
	bcache.head.next = &bcache.head;
	for(b = bcache.buf; b < bcache.buf+NBUF; b++){
		b->next = bcache.head.next;
		b->prev = &bcache.head;
		initsleeplock(&b->lock, "buffer");
		bcache.head.next->prev = b;
		bcache.head.next = b;
	}
}

static struct buf* bget(uint32_t dev, uint32_t blockno)
{
	struct buf *b;

	acquire(&bcache.lock);

	for(b = bcache.head.next; b != &bcache.head; b = b->next){
		if(b->dev == dev && b->blockno == blockno){
			b->refcnt++;
			release(&bcache.lock);
			acquiresleep(&b->lock);
			return b;
		}
	}

	for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
		if(b->refcnt == 0) {
			b->dev = dev;
			b->blockno = blockno;
			b->valid = 0;
			b->refcnt = 1;
			release(&bcache.lock);
			acquiresleep(&b->lock);
			return b;
		}
	}
	panic("bget: no buffers");
}

struct buf* bread(uint32_t dev, uint32_t blockno)
{
	struct buf *b;

	b = bget(dev, blockno);
	if(!b->valid) {
		ramfs_rw(b, 0);
		b->valid = 1;
	}
	return b;
}

void bwrite(struct buf *b)
{
	if(!holdingsleep(&b->lock))
		panic("bwrite");

	ramfs_rw(b, 1);
}

void brelse(struct buf *b)
{
	if(!holdingsleep(&b->lock))
		panic("brelse");

	releasesleep(&b->lock);

	acquire(&bcache.lock);
	b->refcnt--;
	if (b->refcnt == 0) {
		b->next->prev = b->prev;
		b->prev->next = b->next;
		b->next = bcache.head.next;
		b->prev = &bcache.head;
		bcache.head.next->prev = b;
		bcache.head.next = b;
	}

	release(&bcache.lock);
}

void bpin(struct buf *b) {
	acquire(&bcache.lock);
	b->refcnt++;
	release(&bcache.lock);
}

void bunpin(struct buf *b) {
	acquire(&bcache.lock);
	b->refcnt--;
	release(&bcache.lock);
}

