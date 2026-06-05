#ifndef _LEN_SPINLOCK_H_
#define _LEN_SPINLOCK_H_

struct spinlock {
	uint32_t locked;

	char *name;
	struct cpu *cpu;
};

#endif /* _LEN_SPINLOCK_H_ */
