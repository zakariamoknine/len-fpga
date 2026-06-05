#ifndef _LEN_SLEEPLOCK_H_
#define _LEN_SLEEPLOCK_H_

struct sleeplock {
	uint32_t locked;
	struct spinlock lk;

	char *name;
	int pid;
};

#endif /* _LEN_SLEEPLOCK_H_ */
