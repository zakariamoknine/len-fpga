#include "len.h"

#include "proc.h"
#include "syscall.h"

int fetchaddr(uint64_t addr, uint64_t *ip)
{
	struct proc *p = myproc();
	if(addr >= p->sz || addr+sizeof(uint64_t) > p->sz)
		return -1;
	if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
		return -1;
	return 0;
}

int fetchstr(uint64_t addr, char *buf, int max)
{
	struct proc *p = myproc();
	if(copyinstr(p->pagetable, buf, addr, max) < 0)
		return -1;
	return strlen(buf);
}

static uint64_t argraw(int n)
{
	struct proc *p = myproc();
	switch (n) {
		case 0:
			return p->trapframe->a0;
		case 1:
			return p->trapframe->a1;
		case 2:
			return p->trapframe->a2;
		case 3:
			return p->trapframe->a3;
		case 4:
			return p->trapframe->a4;
		case 5:
			return p->trapframe->a5;
	}
	panic("argraw");
	return -1;
}

void argint(int n, int *ip)
{
	*ip = argraw(n);
}

void argaddr(int n, uint64_t *ip)
{
	*ip = argraw(n);
}

int argstr(int n, char *buf, int max)
{
	uint64_t addr;
	argaddr(n, &addr);
	return fetchstr(addr, buf, max);
}

extern uint64_t sys_fork(void);
extern uint64_t sys_exit(void);
extern uint64_t sys_wait(void);
extern uint64_t sys_pipe(void);
extern uint64_t sys_read(void);
extern uint64_t sys_kill(void);
extern uint64_t sys_exec(void);
extern uint64_t sys_fstat(void);
extern uint64_t sys_chdir(void);
extern uint64_t sys_dup(void);
extern uint64_t sys_getpid(void);
extern uint64_t sys_sbrk(void);
extern uint64_t sys_pause(void);
extern uint64_t sys_uptime(void);
extern uint64_t sys_open(void);
extern uint64_t sys_write(void);
extern uint64_t sys_mknod(void);
extern uint64_t sys_unlink(void);
extern uint64_t sys_link(void);
extern uint64_t sys_mkdir(void);
extern uint64_t sys_close(void);
extern uint64_t sys_mmap(void);
extern uint64_t sys_munmap(void);
extern uint64_t sys_lseek(void);
extern uint64_t sys_getcwd(void);

static uint64_t (*syscalls[])(void) = {
	[SYS_fork]    sys_fork,
	[SYS_exit]    sys_exit,
	[SYS_wait]    sys_wait,
	[SYS_pipe]    sys_pipe,
	[SYS_read]    sys_read,
	[SYS_kill]    sys_kill,
	[SYS_exec]    sys_exec,
	[SYS_fstat]   sys_fstat,
	[SYS_chdir]   sys_chdir,
	[SYS_dup]     sys_dup,
	[SYS_getpid]  sys_getpid,
	[SYS_sbrk]    sys_sbrk,
	[SYS_pause]   sys_pause,
	[SYS_uptime]  sys_uptime,
	[SYS_open]    sys_open,
	[SYS_write]   sys_write,
	[SYS_mknod]   sys_mknod,
	[SYS_unlink]  sys_unlink,
	[SYS_link]    sys_link,
	[SYS_mkdir]   sys_mkdir,
	[SYS_close]   sys_close,
	[SYS_mmap]    sys_mmap,
	[SYS_munmap]  sys_munmap,
	[SYS_lseek]   sys_lseek,
	[SYS_getcwd]  sys_getcwd,
};

void syscall(void)
{
	int num;
	struct proc *p = myproc();

	num = p->trapframe->a7;
	if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
#ifdef LEN_DEBUG
		printf("pid %d %s: syscall %d args(%p, %p, %p, %p, %p, %p)\n",
				p->pid, p->name, num,
				(void*)p->trapframe->a0, (void*)p->trapframe->a1, (void*)p->trapframe->a2,
				(void*)p->trapframe->a3, (void*)p->trapframe->a4, (void*)p->trapframe->a5);
#endif

		p->trapframe->a0 = syscalls[num]();
	} else {
		printf("%d %s: unknown sys call %d\n",
				p->pid, p->name, num);
		p->trapframe->a0 = -1;
	}
}
