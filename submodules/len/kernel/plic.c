#include "len.h"

void plicinit(void)
{
	*(uint32_t*)(PLIC + UART0_IRQ*4) = 1;
}

void plicinithart(void)
{
	int hart = cpuid();

	*(uint32_t*)PLIC_SENABLE(hart) = (1 << UART0_IRQ);

	*(uint32_t*)PLIC_SPRIORITY(hart) = 0;

	w_sie(r_sie() | SIE_SEIE);
}

int plic_claim(void)
{
	int hart = cpuid();
	int irq = *(uint32_t*)PLIC_SCLAIM(hart);
	return irq;
}

void plic_complete(int irq)
{
	int hart = cpuid();
	*(uint32_t*)PLIC_SCLAIM(hart) = irq;
}
