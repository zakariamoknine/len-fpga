#include "uart.h"

#define DDR_BASE   0x80000000UL
#define DDR_SIZE   (128UL * 1024 * 1024)
#define DDR_WORDS  (DDR_SIZE / 4)

#define LOAD_ADDR  0x80000000UL
//#define LOAD_SIZE  2146312
#define LOAD_SIZE  5456

void show_progress(size_t recvd)
{
	if ((recvd & 0xFFF) == 0) {
		printk(".");
	}
}

void serial_load(void)
{
	printk("Serial load starting...\n");
	printk("Loading 'opensbi.mem' into addr=%p\n", LOAD_ADDR);

	volatile uint8_t *dest = (volatile uint8_t *)(LOAD_ADDR);	
	size_t recvd = 0;
	
	printk("Reading bytes...\n");

	while (recvd < LOAD_SIZE) {
		uint8_t byte_data = uart_getc();
		*dest++ = byte_data;
		recvd++;

		show_progress(recvd);
	}

	printk("\nFinished! jumping to load\n");

	void (*load_entry)(void) = (void (*)(void))(LOAD_ADDR);
	load_entry();

	__sync_synchronize();

	while (1);
}

void ddr2_test(void)
{
	printk("Start DDR2 test\n");
	printk("Writing to DDR2...\n");

	volatile uint32_t* memory = (volatile uint32_t*)(DDR_BASE);

	for (size_t i = 0; i < DDR_WORDS; i++) {
		memory[i] = 0xAAAAAAAA ^ i;
	}

	__sync_synchronize();

	printk("Checking DDR2 content...\n");

	for (uint32_t i = 0; i < DDR_WORDS; i++) {
		uint32_t exp = 0xAAAAAAAA ^ i;
		if (memory[i] != exp) {
			printk("DDR ERROR at %08x: got %08x expected %08x\n",
					(DDR_BASE + i*4), memory[i], exp);
			return;
		}
	}

	printk("DDR2 test: ");
	printk("\033[1;32mPass\033[0m\n");
}

static inline uint64_t read_time(void)
{
	uint64_t t;
	asm volatile ("rdtime %0" : "=r" (t));
	return t;
}

void rdtime_test(void)
{
	printk("rdtime test starting...\n");

	while (1) {
		uint64_t t = read_time();
		printk("rdtime = %x\n", (uint64_t)t);

		for (volatile int i = 0; i < 1000000; i++);
	}
}

void start(void)
{
	uart_init(115200, 100000000);

	serial_load();

	while (1);
}
