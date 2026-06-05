#include "dev.h"

#include "wallpaper.h"

static inline uint64_t rdtime(void)
{
	uint64_t value;

	asm volatile (
		"rdtime %0"
		: "=r"(value)
	);

	return value;
}

void udelay(uint32_t us)
{
	uint64_t start = rdtime();

	uint64_t wait_ticks =
		(uint64_t)us * SYS_TIMEBASE_CLK_FREQ / 1000000;

	while (rdtime() - start < wait_ticks)
		;
}

static void init_irqchips(void)
{
	for (uint32_t i = 0; i < PLIC_MAX_SOURCES; i++) {
		writel(PLIC_M_PRIORITY + (4 * i), 0);
	}

	writel(PLIC_M_THRESHOLD, 0);

	writel(PLIC_M_ENABLE, 0);
	writel(PLIC_M_ENABLE + 0x04, 0);
}

static void init_fb(void)
{
    writel(TFT_AR, FB_BASE_ADDR);
    writel(TFT_CR, 0x01);
    writel(TFT_IESR, 0x00);

    uint32_t *fb = (uint32_t*)FB_BASE_ADDR;

	for (uint32_t i = 0; i < 1024 * 480; i++) {
		fb[i] = 0x00101010;
	}

	/* Draw the boot screen */
	for (uint32_t row = 0; row < 480; row++) {
	    uint32_t fb_base = row * 1024;
	    uint32_t byte_base = row * 80;
	
	    for (uint32_t b = 0; b < 80; b++) {
	        uint8_t byte = wallpaper[byte_base + b];
	
	        for (uint32_t bit = 0; bit < 8; bit++) {
	            uint32_t col = b * 8 + bit;
	            uint8_t pixel = (byte >> (7 - bit)) & 1;
	
	            fb[fb_base + col] = pixel ? 0x00FFFFFF : 0x00101010;
	        }
	    }
}
}

static void init_pmc(void)
{
	writel(PMC_CONTROL, 0);
}

void dev_init(void)
{
	init_irqchips();
	init_fb();
	init_pmc();
}

void reboot(void)
{
	writeb(PMC_CONTROL, PMC_REBOOT);

	__builtin_unreachable();
}

void poweroff(void)
{
	writeb(PMC_CONTROL, PMC_POWEROFF);

	__builtin_unreachable();
}
