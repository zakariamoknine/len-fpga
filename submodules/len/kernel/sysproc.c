#include "len.h"

#include "proc.h"
#include "vm.h"

uint64_t sys_exit(void)
{
	int n;
	argint(0, &n);
	kexit(n);
	return 0;
}

uint64_t sys_getpid(void)
{
	return myproc()->pid;
}

uint64_t sys_fork(void)
{
	return kfork();
}

uint64_t sys_wait(void)
{
	uint64_t p;
	argaddr(0, &p);
	return kwait(p);
}

uint64_t sys_sbrk(void)
{
	uint64_t addr;
	int t;
	int n;

	argint(0, &n);
	argint(1, &t);
	addr = myproc()->sz;

	if(t == SBRK_EAGER || n < 0) {
		if(growproc(n) < 0) {
			return -1;
		}
	} else {
		if(addr + n < addr)
			return -1;
		if(addr + n > TRAPFRAME)
			return -1;
		myproc()->sz += n;
	}
	return addr;
}

uint64_t sys_pause(void)
{
	int n;
	uint32_t ticks0;

	argint(0, &n);
	if(n < 0)
		n = 0;
	acquire(&tickslock);
	ticks0 = ticks;
	while(ticks - ticks0 < n){
		if(killed(myproc())){
			release(&tickslock);
			return -1;
		}
		sleep(&ticks, &tickslock);
	}
	release(&tickslock);
	return 0;
}

uint64_t sys_kill(void)
{
	int pid;

	argint(0, &pid);
	return kkill(pid);
}

uint64_t sys_uptime(void)
{
	uint32_t xticks;

	acquire(&tickslock);
	xticks = ticks;
	release(&tickslock);
	return xticks;
}
