#include "len.h"

#include "elf.h"
#include "fs.h"
#include "file.h"
#include "proc.h"
#include "buf.h"
#include "vma.h"

/* the kernel's page table */
pagetable_t kernel_pagetable;

extern char __text_end[];
extern char trampoline[];

pagetable_t kvmmake(void)
{
	pagetable_t kpgtbl;

	kpgtbl = (pagetable_t) kalloc();
	memset(kpgtbl, 0, PGSIZE);

	// UART
	kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);

	// PLIC
	kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);

	// CLINT
	kvmmap(kpgtbl, CLINT, CLINT, 0x10000, PTE_R | PTE_W);

	// RAMFS
	kvmmap(kpgtbl, RAMFS_BASE, RAMFS_BASE, RAMFS_SIZE, PTE_R | PTE_W);

	// FRAMEBUFFER
	kvmmap(kpgtbl, FRAMEBUFFER_BASE, FRAMEBUFFER_BASE, FRAMEBUFFER_SIZE, PTE_R | PTE_W);

	// KTEXT
	kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64_t)__text_end-KERNBASE, PTE_R | PTE_X);

	// KDATA
	kvmmap(kpgtbl, (uint64_t)__text_end, (uint64_t)__text_end, PHYSTOP-(uint64_t)__text_end, PTE_R | PTE_W);

	// TRAMPOLINE
	kvmmap(kpgtbl, TRAMPOLINE, (uint64_t)trampoline, PGSIZE, PTE_R | PTE_X);

	// KSTACK
	proc_mapstacks(kpgtbl);

	return kpgtbl;
}

void kvmmap(pagetable_t kpgtbl, uint64_t va, uint64_t pa, uint64_t sz, int perm)
{
	if(mappages(kpgtbl, va, sz, pa, perm) != 0)
		panic("kvmmap");
}

void kvminit(void)
{
	kernel_pagetable = kvmmake();
}

void kvminithart()
{
	sfence_vma();

	w_satp(MAKE_SATP(kernel_pagetable));

	sfence_vma();
}


pte_t* walk(pagetable_t pagetable, uint64_t va, int alloc)
{
	if(va >= MAXVA)
		panic("walk");

	for(int level = 2; level > 0; level--) {
		pte_t *pte = &pagetable[PX(level, va)];
		if(*pte & PTE_V) {
			pagetable = (pagetable_t)PTE2PA(*pte);
		} else {
			if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
				return 0;
			memset(pagetable, 0, PGSIZE);
			*pte = PA2PTE(pagetable) | PTE_V;
		}
	}
	return &pagetable[PX(0, va)];
}

uint64_t walkaddr(pagetable_t pagetable, uint64_t va)
{
	pte_t *pte;
	uint64_t pa;

	if(va >= MAXVA)
		return 0;

	pte = walk(pagetable, va, 0);
	if(pte == 0)
		return 0;
	if((*pte & PTE_V) == 0)
		return 0;
	if((*pte & PTE_U) == 0)
		return 0;
	pa = PTE2PA(*pte);
	return pa;
}

int mappages(pagetable_t pagetable, uint64_t va, uint64_t size, uint64_t pa, int perm)
{
	uint64_t a, last;
	pte_t *pte;

	if((va % PGSIZE) != 0)
		panic("mappages: va not aligned");

	if((size % PGSIZE) != 0)
		panic("mappages: size not aligned");

	if(size == 0)
		panic("mappages: size");

	a = va;
	last = va + size - PGSIZE;
	for(;;){
		if((pte = walk(pagetable, a, 1)) == 0)
			return -1;
		if(*pte & PTE_V)
			panic("mappages: remap");
		*pte = PA2PTE(pa) | perm | PTE_V | PTE_A | PTE_D;
		if(a == last)
			break;
		a += PGSIZE;
		pa += PGSIZE;
	}
	return 0;
}

pagetable_t uvmcreate()
{
	pagetable_t pagetable;
	pagetable = (pagetable_t) kalloc();
	if(pagetable == 0)
		return 0;
	memset(pagetable, 0, PGSIZE);
	return pagetable;
}

void uvmunmap(pagetable_t pagetable, uint64_t va, uint64_t npages, int do_free)
{
	uint64_t a;
	pte_t *pte;

	if((va % PGSIZE) != 0)
		panic("uvmunmap: not aligned");

	for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
		if((pte = walk(pagetable, a, 0)) == 0)
			continue;   
		if((*pte & PTE_V) == 0)
			continue;
		if(do_free){
			uint64_t pa = PTE2PA(*pte);
			kfree((void*)pa);
		}
		*pte = 0;
	}
}

uint64_t uvmalloc(pagetable_t pagetable, uint64_t oldsz, uint64_t newsz, int xperm)
{
	char *mem;
	uint64_t a;

	if(newsz < oldsz)
		return oldsz;

	oldsz = PGROUNDUP(oldsz);
	for(a = oldsz; a < newsz; a += PGSIZE){
		mem = kalloc();
		if(mem == 0){
			uvmdealloc(pagetable, a, oldsz);
			return 0;
		}
		memset(mem, 0, PGSIZE);
		if(mappages(pagetable, a, PGSIZE, (uint64_t)mem, PTE_R|PTE_U|xperm) != 0){
			kfree(mem);
			uvmdealloc(pagetable, a, oldsz);
			return 0;
		}
	}
	return newsz;
}

uint64_t uvmdealloc(pagetable_t pagetable, uint64_t oldsz, uint64_t newsz)
{
	if(newsz >= oldsz)
		return oldsz;

	if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
		int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
		uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
	}

	return newsz;
}

void freewalk(pagetable_t pagetable)
{
	for(int i = 0; i < 512; i++){
		pte_t pte = pagetable[i];
		if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
			uint64_t child = PTE2PA(pte);
			freewalk((pagetable_t)child);
			pagetable[i] = 0;
		} else if(pte & PTE_V){
			panic("freewalk: leaf");
		}
	}
	kfree((void*)pagetable);
}

// then free page-table pages.
	void
uvmfree(pagetable_t pagetable, uint64_t sz)
{
	if(sz > 0)
		uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
	freewalk(pagetable);
}


int uvmcopy(pagetable_t old, pagetable_t new, uint64_t sz)
{
	pte_t *pte;
	uint64_t pa, i;
	uint32_t flags;
	char *mem;

	for(i = 0; i < sz; i += PGSIZE){
		if((pte = walk(old, i, 0)) == 0)
			continue;
		if((*pte & PTE_V) == 0)
			continue;
		pa = PTE2PA(*pte);
		flags = PTE_FLAGS(*pte);
		if((mem = kalloc()) == 0)
			goto err;
		memmove(mem, (char*)pa, PGSIZE);
		if(mappages(new, i, PGSIZE, (uint64_t)mem, flags) != 0){
			kfree(mem);
			goto err;
		}
	}
	return 0;

err:
	uvmunmap(new, 0, i / PGSIZE, 1);
	return -1;
}

void uvmclear(pagetable_t pagetable, uint64_t va)
{
	pte_t *pte;

	pte = walk(pagetable, va, 0);
	if(pte == 0)
		panic("uvmclear");
	*pte &= ~PTE_U;
}

int copyout(pagetable_t pagetable, uint64_t dstva, char *src, uint64_t len)
{
	uint64_t n, va0, pa0;
	pte_t *pte;

	while(len > 0){
		va0 = PGROUNDDOWN(dstva);
		if(va0 >= MAXVA)
			return -1;

		pa0 = walkaddr(pagetable, va0);
		if(pa0 == 0) {
			if(vmfault(pagetable, va0, 0) == 0) {
				struct proc *p = myproc();
				if(!p || !vmafault(p, va0))
					return -1;
			}
			pa0 = walkaddr(pagetable, va0);
			if(pa0 == 0)
				return -1;
		}

		pte = walk(pagetable, va0, 0);
		if(pte == 0 || (*pte & PTE_W) == 0)
			return -1;

		n = PGSIZE - (dstva - va0);
		if(n > len)
			n = len;
		memmove((void *)(pa0 + (dstva - va0)), src, n);

		len -= n;
		src += n;
		dstva = va0 + PGSIZE;
	}
	return 0;
}

int copyin(pagetable_t pagetable, char *dst, uint64_t srcva, uint64_t len)
{
	uint64_t n, va0, pa0;

	while(len > 0){
		va0 = PGROUNDDOWN(srcva);
		pa0 = walkaddr(pagetable, va0);
		if(pa0 == 0) {
			if(vmfault(pagetable, va0, 0) == 0) {
				struct proc *p = myproc();
				if(!p || !vmafault(p, va0))
					return -1;
			}
			pa0 = walkaddr(pagetable, va0);
			if(pa0 == 0)
				return -1;
		}
		n = PGSIZE - (srcva - va0);
		if(n > len)
			n = len;
		memmove(dst, (void *)(pa0 + (srcva - va0)), n);

		len -= n;
		dst += n;
		srcva = va0 + PGSIZE;
	}
	return 0;
}

int copyinstr(pagetable_t pagetable, char *dst, uint64_t srcva, uint64_t max)
{
	uint64_t n, va0, pa0;
	int got_null = 0;

	while(got_null == 0 && max > 0){
		va0 = PGROUNDDOWN(srcva);
		pa0 = walkaddr(pagetable, va0);
		if(pa0 == 0)
			return -1;
		n = PGSIZE - (srcva - va0);
		if(n > max)
			n = max;

		char *p = (char *) (pa0 + (srcva - va0));
		while(n > 0){
			if(*p == '\0'){
				*dst = '\0';
				got_null = 1;
				break;
			} else {
				*dst = *p;
			}
			--n;
			--max;
			p++;
			dst++;
		}

		srcva = va0 + PGSIZE;
	}
	if(got_null){
		return 0;
	} else {
		return -1;
	}
}

uint64_t vmfault(pagetable_t pagetable, uint64_t va, int read)
{
	uint64_t mem;
	struct proc *p = myproc();

	if (va >= p->sz)
		return 0;
	va = PGROUNDDOWN(va);
	if(ismapped(pagetable, va)) {
		return 0;
	}
	mem = (uint64_t) kalloc();
	if(mem == 0)
		return 0;
	memset((void *) mem, 0, PGSIZE);
	if (mappages(p->pagetable, va, PGSIZE, mem, PTE_W|PTE_U|PTE_R) != 0) {
		kfree((void *)mem);
		return 0;
	}
	return mem;
}

int ismapped(pagetable_t pagetable, uint64_t va)
{
	pte_t *pte = walk(pagetable, va, 0);
	if (pte == 0) {
		return 0;
	}
	if (*pte & PTE_V){
		return 1;
	}
	return 0;
}

uint64_t vma_find_addr(struct proc *p, uint64_t len)
{
	uint64_t addr = MMAPBASE;

retry:
	if(addr + len > TRAPFRAME)
		return 0;
	for(int i = 0; i < NVMA; i++){
		if(!p->vmas[i].used) continue;
		uint64_t vs = p->vmas[i].addr;
		uint64_t ve = vs + p->vmas[i].len;
		if(addr < ve && addr + len > vs){
			addr = ve;
			goto retry;
		}
	}
	return addr;
}

int vmafault(struct proc *p, uint64_t va)
{
	va = PGROUNDDOWN(va);

	if(ismapped(p->pagetable, va))
		return 0;

	struct vma *v = 0;
	for(int i = 0; i < NVMA; i++){
		if(p->vmas[i].used &&
				va >= p->vmas[i].addr &&
				va <  p->vmas[i].addr + p->vmas[i].len){
			v = &p->vmas[i];
			break;
		}
	}
	if(!v)
		return 0;

	int perm = PTE_U;
	if(v->prot & PROT_READ)  perm |= PTE_R;
	if(v->prot & PROT_WRITE) perm |= PTE_W;
	if(v->prot & PROT_EXEC)  perm |= PTE_X;

	if(v->type == VMA_ANON){
		char *mem = kalloc();
		if(!mem)
			return 0;
		memset(mem, 0, PGSIZE);
		if(mappages(p->pagetable, va, PGSIZE, (uint64_t)mem, perm) < 0){
			kfree(mem);
			return 0;
		}
		return 1;
	}

	if(v->type == VMA_DEV){
		uint64_t dev_off = v->offset + (va - v->addr);
		uint64_t pa = devsw[v->major].mmap(dev_off);
		if(!pa)
			return 0;
		if(mappages(p->pagetable, va, PGSIZE, pa, perm) < 0)
			return 0;
		return 1;
	}

	return 0;
}

void vma_unmap_range(struct proc *p, uint64_t addr, uint64_t len)
{
	for(int i = 0; i < NVMA; i++){
		struct vma *v = &p->vmas[i];
		if(!v->used) continue;

		uint64_t vs = v->addr;
		uint64_t ve = vs + v->len;

		uint64_t us = addr        > vs ? addr        : vs;
		uint64_t ue = addr + len  < ve ? addr + len  : ve;
		if(us >= ue) continue;

		for(uint64_t a = us; a < ue; a += PGSIZE){
			pte_t *pte = walk(p->pagetable, a, 0);
			if(!pte || !(*pte & PTE_V))
				continue;
			if(v->type == VMA_ANON){
				kfree((void*)PTE2PA(*pte));
			}
			*pte = 0;
		}

		if(us <= vs && ue >= ve){
			if(v->type == VMA_DEV && v->f){
				fileclose(v->f);
				v->f = 0;
			}
			v->used = 0;
			continue;
		}

		if(us == vs){
			v->addr   = ue;
			v->len    = ve - ue;
			if(v->type == VMA_DEV)
				v->offset += (ue - vs);
			continue;
		}

		if(ue == ve){
			v->len = us - vs;
			continue;
		}

		// no hole punch, keep the mapping
	}

	sfence_vma();
}

void vma_free_all(struct proc *p)
{
	if(!p->pagetable)
		return;
	for(int i = 0; i < NVMA; i++){
		if(!p->vmas[i].used) continue;
		vma_unmap_range(p, p->vmas[i].addr, p->vmas[i].len);
	}
}
