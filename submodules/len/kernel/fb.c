#include "len.h"

#include "stat.h"
#include "proc.h"
#include "fs.h"
#include "buf.h"
#include "file.h"

static uint64_t fb_mmap(uint64_t offset)
{
	if(offset + PGSIZE > FRAMEBUFFER_SIZE)
		return 0;

	return FRAMEBUFFER_BASE + offset;
}

int fb_write(int user_src, uint64_t src, uint64_t off, int n)
{
	if(off >= FRAMEBUFFER_SIZE) return 0;
	if(off + n > FRAMEBUFFER_SIZE) n = FRAMEBUFFER_SIZE - off;

	if(either_copyin((void*)(FRAMEBUFFER_BASE + off), user_src, src, n) == -1)
		return -1;

	return n;
}

int fb_read(int user_dst, uint64_t dst, uint64_t off, int n, int nonblock)
{
	if(off >= FRAMEBUFFER_SIZE)
		return 0;

	if(off + n > FRAMEBUFFER_SIZE)
		n = FRAMEBUFFER_SIZE - off;

	if(either_copyout(user_dst, dst, (void*)(FRAMEBUFFER_BASE + off), n) == -1)
		return -1;

	return n;
}

void fbinit(void)
{
	devsw[FB_DEV].read  = fb_read;
	devsw[FB_DEV].write = fb_write;
	devsw[FB_DEV].mmap  = fb_mmap;
}
