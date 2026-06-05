#include "len.h"

#include "proc.h"
#include "sbi.h"

struct spinlock tickslock;
uint32_t ticks;

extern char trampoline[], uservec[];

void kernelvec();

extern int devintr();

void trapinit(void)
{
	initlock(&tickslock, "time");
}

void trapinithart(void)
{
	w_stvec((uint64_t)kernelvec);
}

void timerinit(void)
{
	sbi_set_timer(r_time() + 1000000);
	w_sie(r_sie() | SIE_STIE);
}

uint64_t usertrap(void)
{
#ifdef LEN_DEBUG
	//printf("usertrap entered!\n");
#endif

	int which_dev = 0;

	if((r_sstatus() & SSTATUS_SPP) != 0)
		panic("usertrap: not from user mode");

	w_stvec((uint64_t)kernelvec);

	struct proc *p = myproc();

	p->trapframe->epc = r_sepc();

	if(r_scause() == 8){

		if(killed(p))
			kexit(-1);

		p->trapframe->epc += 4;

		intr_on();

		syscall();
	} else if((which_dev = devintr()) != 0){
		// ok
	} else if(r_scause() == 15 || r_scause() == 13){
		uint64_t va = r_stval();
		if(vmfault(p->pagetable, va, (r_scause() == 13)) != 0){
			// handled
		} else if(vmafault(p, va)){
			// handled
		} else {
			printf("usertrap(): page fault pid=%d va=%p scause=%p\n",
					p->pid, (void*)va, (void*)r_scause());
			setkilled(p);
		}
	} else {
		printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
		printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
		setkilled(p);
	}

	if(killed(p))
		kexit(-1);

	if(which_dev == 2)
		yield();

	prepare_return();

	uint64_t satp = MAKE_SATP(p->pagetable);

	return satp;
}

void prepare_return(void)
{
	struct proc *p = myproc();

	intr_off();

	uint64_t trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
	w_stvec(trampoline_uservec);

	p->trapframe->kernel_satp = r_satp();
	p->trapframe->kernel_sp = p->kstack + PGSIZE;
	p->trapframe->kernel_trap = (uint64_t)usertrap;
	p->trapframe->kernel_hartid = r_tp();

	unsigned long x = r_sstatus();
	x &= ~SSTATUS_SPP;
	x |= SSTATUS_SPIE;
	x &= ~SSTATUS_FS;
	x |= SSTATUS_FS_INITIAL;
	w_sstatus(x);

	w_sepc(p->trapframe->epc);
}

void kerneltrap()
{
	int which_dev = 0;
	uint64_t sepc = r_sepc();
	uint64_t sstatus = r_sstatus();
	uint64_t scause = r_scause();

	if((sstatus & SSTATUS_SPP) == 0)
		panic("kerneltrap: not from supervisor mode");
	if(intr_get() != 0)
		panic("kerneltrap: interrupts enabled");

	if((which_dev = devintr()) == 0){
		printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
		panic("kerneltrap");
	}

	if(which_dev == 2 && myproc() != 0)
		yield();

	w_sepc(sepc);
	w_sstatus(sstatus);
}

	void
clockintr()
{
	if(cpuid() == 0){
		acquire(&tickslock);
		ticks++;
		wakeup(&ticks);
		release(&tickslock);
	}

	sbi_set_timer(r_time() + 1000000);
#ifdef LEN_DEBUG
	//printf("tick!\n");
#endif
}

int devintr()
{
	uint64_t scause = r_scause();

	if(scause == 0x8000000000000009L){

		int irq = plic_claim();

		if(irq == UART0_IRQ){
			uartintr();
		} else if(irq){
			printf("unexpected interrupt irq=%d\n", irq);
		}

		if(irq)
			plic_complete(irq);

		return 1;
	} else if(scause == 0x8000000000000005L){
		clockintr();
		return 2;
	} else {
		return 0;
	}
}

