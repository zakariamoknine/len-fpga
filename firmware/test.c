#include "test.h"

#define DDR2_WORDS  (DDR2_SIZE / 4)

void test_ddr2(void)
{
	print("Start DDR2 test\n");
	print("Writing to DDR2...\n");

	volatile uint32_t* memory = (volatile uint32_t*)(DDR2_BASE);

	for (size_t i = 0; i < DDR2_WORDS; i++) {
		memory[i] = 0xAAAAAAAA ^ i;
	}

	__sync_synchronize();

	print("Checking DDR2 content...\n");

	for (uint32_t i = 0; i < DDR2_WORDS; i++) {
		uint32_t exp = 0xAAAAAAAA ^ i;
		if (memory[i] != exp) {
			print("DDR ERROR at %08x: got %08x expected"
				       	"%08x\n", (DDR2_BASE + i*4),
				       	memory[i], exp);
			return;
		}
	}

	print("DDR2 test: Pass!");
}

static inline uint64_t read_time(void)
{
	uint64_t t;
	asm volatile ("rdtime %0" : "=r" (t));
	return t;
}

void test_rdtime(void)
{
	print("rdtime test starting...\n");

	int t = 100;

	while (t--) {
		uint64_t tick = read_time();
		print("rdtime = %x\n", (uint64_t)tick);

		for (volatile int i = 0; i < 1000000; i++);
	}
}
