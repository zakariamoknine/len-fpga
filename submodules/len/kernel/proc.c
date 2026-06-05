#include "len.h"

#include "proc.h"

struct cpu cpus[NCPU];

struct proc proc[NPROC];

struct proc *initproc;

int nextpid = 1;
struct spinlock pid_lock;

extern void forkret(void);
static void freeproc(struct proc *p);

extern char trampoline[];

struct spinlock wait_lock;

void proc_mapstacks(pagetable_t kpgtbl)
{
	struct proc *p;

	for(p = proc; p < &proc[NPROC]; p++) {
		char *pa = kalloc();
		if(pa == 0)
			panic("kalloc");
		uint64_t va = KSTACK((int) (p - proc));
		kvmmap(kpgtbl, va, (uint64_t)pa, PGSIZE, PTE_R | PTE_W);
	}
}

void procinit(void)
{
	struct proc *p;

	initlock(&pid_lock, "nextpid");
	initlock(&wait_lock, "wait_lock");
	for(p = proc; p < &proc[NPROC]; p++) {
		initlock(&p->lock, "proc");
		p->state = UNUSED;
		p->kstack = KSTACK((int) (p - proc));
	}
}

int cpuid()
{
	int id = r_tp();
	return id;
}

struct cpu* mycpu(void)
{
	int id = cpuid();
	struct cpu *c = &cpus[id];
	return c;
}

struct proc* myproc(void)
{
	push_off();
	struct cpu *c = mycpu();
	struct proc *p = c->proc;
	pop_off();
	return p;
}

int allocpid()
{
	int pid;

	acquire(&pid_lock);
	pid = nextpid;
	nextpid = nextpid + 1;
	release(&pid_lock);

	return pid;
}

static struct proc* allocproc(void)
{
	struct proc *p;

	for(p = proc; p < &proc[NPROC]; p++) {
		acquire(&p->lock);
		if(p->state == UNUSED) {
			goto found;
		} else {
			release(&p->lock);
		}
	}
	return 0;

found:
	p->pid = allocpid();
	p->state = USED;

	if((p->trapframe = (struct trapframe *)kalloc()) == 0){
		freeproc(p);
		release(&p->lock);
		return 0;
	}

	p->pagetable = proc_pagetable(p);
	if(p->pagetable == 0){
		freeproc(p);
		release(&p->lock);
		return 0;
	}

	memset(&p->context, 0, sizeof(p->context));
	p->context.ra = (uint64_t)forkret;
	p->context.sp = p->kstack + PGSIZE;

	return p;
}

static void freeproc(struct proc *p)
{
	if(p->trapframe)
		kfree((void*)p->trapframe);
	p->trapframe = 0;

	if(p->pagetable){
		vma_free_all(p);
		proc_freepagetable(p->pagetable, p->sz);
	}
	p->pagetable = 0;

	memset(p->vmas, 0, sizeof(p->vmas));

	p->sz = 0;
	p->pid = 0;
	p->parent = 0;
	p->name[0] = 0;
	p->chan = 0;
	p->killed = 0;
	p->xstate = 0;
	p->state = UNUSED;
}

pagetable_t proc_pagetable(struct proc *p)
{
	pagetable_t pagetable;

	pagetable = uvmcreate();
	if(pagetable == 0)
		return 0;

	if(mappages(pagetable, TRAMPOLINE, PGSIZE,
				(uint64_t)trampoline, PTE_R | PTE_X) < 0){
		uvmfree(pagetable, 0);
		return 0;
	}

	if(mappages(pagetable, TRAPFRAME, PGSIZE,
				(uint64_t)(p->trapframe), PTE_R | PTE_W) < 0){
		uvmunmap(pagetable, TRAMPOLINE, 1, 0);
		uvmfree(pagetable, 0);
		return 0;
	}

	return pagetable;
}

void proc_freepagetable(pagetable_t pagetable, uint64_t sz)
{
	uvmunmap(pagetable, TRAMPOLINE, 1, 0);
	uvmunmap(pagetable, TRAPFRAME, 1, 0);
	uvmfree(pagetable, sz);
}

void userinit(void)
{
	struct proc *p;

	p = allocproc();
	initproc = p;

	p->cwd = namei("/");

	p->state = RUNNABLE;

	release(&p->lock);
}

int growproc(int n)
{
	uint64_t sz;
	struct proc *p = myproc();

	sz = p->sz;
	if(n > 0){
		if(sz + n > TRAPFRAME) {
			return -1;
		}
		if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
			return -1;
		}
	} else if(n < 0){
		sz = uvmdealloc(p->pagetable, sz, sz + n);
	}
	p->sz = sz;
	return 0;
}

int kfork(void)
{
	int i, pid;
	struct proc *np;
	struct proc *p = myproc();

	if((np = allocproc()) == 0){
		return -1;
	}

	if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
		freeproc(np);
		release(&np->lock);
		return -1;
	}
	np->sz = p->sz;

	*(np->trapframe) = *(p->trapframe);

	np->trapframe->a0 = 0;

	for(i = 0; i < NOFILE; i++)
		if(p->ofile[i])
			np->ofile[i] = filedup(p->ofile[i]);
	np->cwd = idup(p->cwd);

	for(int j = 0; j < NVMA; j++){
		np->vmas[j] = p->vmas[j];
		if(np->vmas[j].used && np->vmas[j].type == VMA_DEV && np->vmas[j].f)
			np->vmas[j].f = filedup(np->vmas[j].f);
	}

	safestrcpy(np->name, p->name, sizeof(p->name));

	pid = np->pid;

	release(&np->lock);

	acquire(&wait_lock);
	np->parent = p;
	release(&wait_lock);

	acquire(&np->lock);
	np->state = RUNNABLE;
	release(&np->lock);

	return pid;
}

void reparent(struct proc *p)
{
	struct proc *pp;

	for(pp = proc; pp < &proc[NPROC]; pp++){
		if(pp->parent == p){
			pp->parent = initproc;
			wakeup(initproc);
		}
	}
}

void kexit(int status)
{
	struct proc *p = myproc();

	if(p == initproc)
		panic("init exiting");

	for(int fd = 0; fd < NOFILE; fd++){
		if(p->ofile[fd]){
			struct file *f = p->ofile[fd];
			fileclose(f);
			p->ofile[fd] = 0;
		}
	}

	begin_op();
	iput(p->cwd);
	end_op();
	p->cwd = 0;

	acquire(&wait_lock);

	reparent(p);

	wakeup(p->parent);

	acquire(&p->lock);

	p->xstate = status;
	p->state = ZOMBIE;

	release(&wait_lock);

	sched();
	panic("zombie exit");
}

int kwait(uint64_t addr)
{
	struct proc *pp;
	int havekids, pid;
	struct proc *p = myproc();

	acquire(&wait_lock);

	for(;;){
		havekids = 0;
		for(pp = proc; pp < &proc[NPROC]; pp++){
			if(pp->parent == p){
				acquire(&pp->lock);

				havekids = 1;
				if(pp->state == ZOMBIE){
					pid = pp->pid;
					if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
								sizeof(pp->xstate)) < 0) {
						release(&pp->lock);
						release(&wait_lock);
						return -1;
					}
					freeproc(pp);
					release(&pp->lock);
					release(&wait_lock);
					return pid;
				}
				release(&pp->lock);
			}
		}

		if(!havekids || killed(p)){
			release(&wait_lock);
			return -1;
		}

		sleep(p, &wait_lock);
	}
}

void scheduler(void)
{
	struct proc *p;
	struct cpu *c = mycpu();

	c->proc = 0;
	for(;;){
		intr_on();
		intr_off();

		int found = 0;
		for(p = proc; p < &proc[NPROC]; p++) {
			acquire(&p->lock);
			if(p->state == RUNNABLE) {
				p->state = RUNNING;
				c->proc = p;
				swtch(&c->context, &p->context);

				c->proc = 0;
				found = 1;
			}
			release(&p->lock);
		}
		if(found == 0) {
			asm volatile("wfi");
		}
	}
}

void sched(void)
{
	int intena;
	struct proc *p = myproc();

	if(!holding(&p->lock))
		panic("sched p->lock");
	if(mycpu()->noff != 1)
		panic("sched locks");
	if(p->state == RUNNING)
		panic("sched RUNNING");
	if(intr_get())
		panic("sched interruptible");

	intena = mycpu()->intena;
	swtch(&p->context, &mycpu()->context);
	mycpu()->intena = intena;
}

void yield(void)
{
	struct proc *p = myproc();
	acquire(&p->lock);
	p->state = RUNNABLE;
	sched();
	release(&p->lock);
}

void forkret(void)
{
	extern char userret[];
	static int first = 1;
	struct proc *p = myproc();

	release(&p->lock);

	if (first) {
		fsinit(ROOTDEV);

		first = 0;
		__sync_synchronize();

		p->trapframe->a0 = kexec("/init", (char *[]){ "/init", 0 });
		if (p->trapframe->a0 == -1) {
			panic("exec");
		}
	}

	prepare_return();
	uint64_t satp = MAKE_SATP(p->pagetable);
	uint64_t trampoline_userret = TRAMPOLINE + (userret - trampoline);
	((void (*)(uint64_t))trampoline_userret)(satp);
}

void sleep(void *chan, struct spinlock *lk)
{
	struct proc *p = myproc();

	acquire(&p->lock);
	release(lk);

	p->chan = chan;
	p->state = SLEEPING;

	sched();

	p->chan = 0;

	release(&p->lock);
	acquire(lk);
}

void wakeup(void *chan)
{
	struct proc *p;

	for(p = proc; p < &proc[NPROC]; p++) {
		if(p != myproc()){
			acquire(&p->lock);
			if(p->state == SLEEPING && p->chan == chan) {
				p->state = RUNNABLE;
			}
			release(&p->lock);
		}
	}
}

int kkill(int pid)
{
	struct proc *p;

	for(p = proc; p < &proc[NPROC]; p++){
		acquire(&p->lock);
		if(p->pid == pid){
			p->killed = 1;
			if(p->state == SLEEPING){
				p->state = RUNNABLE;
			}
			release(&p->lock);
			return 0;
		}
		release(&p->lock);
	}
	return -1;
}

void setkilled(struct proc *p)
{
	acquire(&p->lock);
	p->killed = 1;
	release(&p->lock);
}

int killed(struct proc *p)
{
	int k;

	acquire(&p->lock);
	k = p->killed;
	release(&p->lock);
	return k;
}

int either_copyout(int user_dst, uint64_t dst, void *src, uint64_t len)
{
	struct proc *p = myproc();
	if(user_dst){
		return copyout(p->pagetable, dst, src, len);
	} else {
		memmove((char *)dst, src, len);
		return 0;
	}
}

int either_copyin(void *dst, int user_src, uint64_t src, uint64_t len)
{
	struct proc *p = myproc();
	if(user_src){
		return copyin(p->pagetable, dst, src, len);
	} else {
		memmove(dst, (char*)src, len);
		return 0;
	}
}

void procdump(void)
{
	static char *states[] = {
		[UNUSED]    "unused",
		[USED]      "used",
		[SLEEPING]  "sleep ",
		[RUNNABLE]  "runble",
		[RUNNING]   "run   ",
		[ZOMBIE]    "zombie"
	};
	struct proc *p;
	char *state;

	printf("\n");
	for(p = proc; p < &proc[NPROC]; p++){
		if(p->state == UNUSED)
			continue;
		if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
			state = states[p->state];
		else
			state = "???";
		printf("%d %s %s", p->pid, state, p->name);
		printf("\n");
	}
}
