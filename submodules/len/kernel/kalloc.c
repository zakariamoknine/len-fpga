#include "len.h"

void freerange(void *pa_start, void *pa_end);

extern char __image_end[];

struct run {
	struct run *next;
};

struct {
	struct spinlock lock;
	struct run *freelist;
} kmem;

void allocator_init()
{
	initlock(&kmem.lock, "kmem");
	freerange(__image_end, (void*)PHYSTOP);
}

void freerange(void *pa_start, void *pa_end)
{
	char *p;
	p = (char*)PGROUNDUP((uint64_t)pa_start);
	for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
		kfree(p);
}

void kfree(void *pa)
{
	struct run *r;

	if(((uint64_t)pa % PGSIZE) != 0 || (char*)pa < __image_end || (uint64_t)pa >= PHYSTOP)
		panic("kfree");

	memset(pa, 1, PGSIZE);

	r = (struct run*)pa;

	acquire(&kmem.lock);
	r->next = kmem.freelist;
	kmem.freelist = r;
	release(&kmem.lock);
}

void* kalloc(void)
{
	struct run *r;

	acquire(&kmem.lock);
	r = kmem.freelist;
	if(r)
		kmem.freelist = r->next;
	release(&kmem.lock);

	if(r)
		memset((char*)r, 5, PGSIZE);

	return (void*)r;
}
