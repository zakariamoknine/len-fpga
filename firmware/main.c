#include "uart.h"

#define DDR_BASE   0x80000000ULL
#define DDR_SIZE   (128UL * 1024 * 1024)
#define DDR_WORDS  (DDR_SIZE / 4)

#define FB_BASE    0x20000000ULL

void start(void)
{
	uart_init(115200, 100000000);

	volatile uint8_t* fb = (volatile uint8_t*)(FB_BASE);

	printk("Coloring the screen..\n");
	for (int i = 0; i < 640 * 480; i++) {
		fb[i] = 0xFF;
	}

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

	printk("Coloring half of the screen..\n");
	for (int i = 0; i < 640 * 480; i++) {
		if (i < (640 * 480) / 2) {
			fb[i] = 0xFF;
		}
		else {
			fb[i] = 0x00;
		}
	}

	while (1);
}
