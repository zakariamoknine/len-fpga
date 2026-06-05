#include "len.h"

#include "stat.h"
#include "proc.h"
#include "fs.h"
#include "buf.h"
#include "file.h"

/*
 * null device
 */
static int nullread(int user_dst, uint64_t dst, uint64_t off, int n, int nonblock)
{
	return 0;
}

static int nullwrite(int user_src, uint64_t src, uint64_t off, int n)
{
	return n;
}

/*
 * zero device
 */
static int zeroread(int user_dst, uint64_t dst, uint64_t off, int n, int nonblock)
{
	char buf[128];
	int i = 0;

	memset(buf, 0, sizeof(buf));

	while(i < n){
		int nn = n - i;
		if(nn > sizeof(buf))
			nn = sizeof(buf);

		if(either_copyout(user_dst, dst + i, buf, nn) == -1)
			break;

		i += nn;
	}
	return i;
}

static int zerowrite(int user_src, uint64_t src, uint64_t off, int n)
{
	return n;
}

/*
 * urandom device
 */
struct {
	struct spinlock lock;
	uint32_t seed;
} urand;

static uint32_t xorshift32(void)
{
	uint32_t x = urand.seed;
	x ^= x << 13;
	x ^= x >> 17;
	x ^= x << 5;
	urand.seed = x;
	return x;
}

static int urandread(int user_dst, uint64_t dst, uint64_t off, int n, int nonblock)
{
	uint32_t r;
	int i = 0;

	acquire(&urand.lock);
	while(i < n){
		urand.seed ^= (uint32_t)r_time();
		r = xorshift32();
		int chunk = n - i;
		if(chunk > 4) chunk = 4;

		if(either_copyout(user_dst, dst + i, &r, chunk) == -1)
			break;

		i += chunk;
	}
	release(&urand.lock);

	return i;
}

static int urandwrite(int user_src, uint64_t src, uint64_t off, int n)
{
	uint32_t new_seed;
	if(n >= 4) {
		if(either_copyin(&new_seed, user_src, src, 4) != -1) {
			acquire(&urand.lock);
			urand.seed ^= new_seed;
			release(&urand.lock);
		}
	}
	return n;
}

void pdevinit(void)
{
	/* NULL */
	devsw[NULL_DEV].read = nullread;
	devsw[NULL_DEV].write = nullwrite;
	devsw[NULL_DEV].mmap = NULL;

	/* ZERO */
	devsw[ZERO_DEV].read = zeroread;
	devsw[ZERO_DEV].write = zerowrite;
	devsw[ZERO_DEV].mmap = NULL;

	/* URANDOM */
	initlock(&urand.lock, "urand");
	urand.seed = (uint32_t)r_time();
	if(urand.seed == 0) urand.seed = 0xF03932BA;
	devsw[URAND_DEV].read = urandread;
	devsw[URAND_DEV].write = urandwrite;
	devsw[URAND_DEV].mmap = NULL;
}
