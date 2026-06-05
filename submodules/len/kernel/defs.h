#ifndef _LEN_DEFS_H_
#define _LEN_DEFS_H_

struct buf;
struct context;
struct file;
struct inode;
struct pipe;
struct proc;
struct spinlock;
struct sleeplock;
struct stat;
struct superblock;
struct vma;

// bio.c
void            buffer_cache_init(void);
struct buf*     bread(uint32_t, uint32_t);
void            brelse(struct buf*);
void            bwrite(struct buf*);
void            bpin(struct buf*);
void            bunpin(struct buf*);

// console.c
void            consoleinit(void);
void            consoleintr(int);
void            consputc(int);

// exec.c
int             kexec(char*, char**);

// file.c
struct file*    filealloc(void);
void            fileclose(struct file*);
struct file*    filedup(struct file*);
void            fileinit(void);
int             fileread(struct file*, uint64_t, int n);
int             filestat(struct file*, uint64_t addr);
int             filewrite(struct file*, uint64_t, int n);

// fs.c
void            fsinit(int);
int             dirlink(struct inode*, char*, uint32_t);
struct inode*   dirlookup(struct inode*, char*, uint32_t*);
struct inode*   ialloc(uint32_t, short);
struct inode*   idup(struct inode*);
void            iinit();
void            ilock(struct inode*);
void            iput(struct inode*);
void            iunlock(struct inode*);
void            iunlockput(struct inode*);
void            iupdate(struct inode*);
int             namecmp(const char*, const char*);
struct inode*   namei(char*);
struct inode*   nameiparent(char*, char*);
int             readi(struct inode*, int, uint64_t, uint32_t, uint32_t);
void            stati(struct inode*, struct stat*);
int             writei(struct inode*, int, uint64_t, uint32_t, uint32_t);
void            itrunc(struct inode*);
void            ireclaim(int);

// kalloc.c
void            allocator_init(void);
void*           kalloc(void);
void            kfree(void *);

// log.c
void            initlog(int, struct superblock*);
void            log_write(struct buf*);
void            begin_op(void);
void            end_op(void);

// pipe.c
int             pipealloc(struct file**, struct file**);
void            pipeclose(struct pipe*, int);
int             piperead(struct pipe*, uint64_t, int);
int             pipewrite(struct pipe*, uint64_t, int);

// printf.c
int             printf(char*, ...) __attribute__ ((format (printf, 1, 2)));
void            panic(char*) __attribute__((noreturn));
void            printfinit(void);

// proc.c
int             cpuid(void);
void            kexit(int);
int             kfork(void);
int             growproc(int);
void            proc_mapstacks(pagetable_t);
pagetable_t     proc_pagetable(struct proc *);
void            proc_freepagetable(pagetable_t, uint64_t);
int             kkill(int);
int             killed(struct proc*);
void            setkilled(struct proc*);
struct cpu*     mycpu(void);
struct proc*    myproc();
void            procinit(void);
void            scheduler(void) __attribute__((noreturn));
void            sched(void);
void            sleep(void*, struct spinlock*);
void            userinit(void);
int             kwait(uint64_t);
void            wakeup(void*);
void            yield(void);
int             either_copyout(int user_dst, uint64_t dst, void *src, uint64_t len);
int             either_copyin(void *dst, int user_src, uint64_t src, uint64_t len);
void            procdump(void);

// swtch.S
void            swtch(struct context*, struct context*);

// spinlock.c
void            acquire(struct spinlock*);
int             holding(struct spinlock*);
void            initlock(struct spinlock*, char*);
void            release(struct spinlock*);
void            push_off(void);
void            pop_off(void);

// sleeplock.c
void            acquiresleep(struct sleeplock*);
void            releasesleep(struct sleeplock*);
int             holdingsleep(struct sleeplock*);
void            initsleeplock(struct sleeplock*, char*);

// string.c
int             memcmp(const void*, const void*, uint32_t);
void*           memmove(void*, const void*, uint32_t);
void*           memset(void*, int, uint32_t);
char*           safestrcpy(char*, const char*, int);
int             strlen(const char*);
int             strncmp(const char*, const char*, uint32_t);
char*           strncpy(char*, const char*, int);

// syscall.c
void            argint(int, int*);
int             argstr(int, char*, int);
void            argaddr(int, uint64_t *);
int             fetchstr(uint64_t, char*, int);
int             fetchaddr(uint64_t, uint64_t*);
void            syscall();

// trap.c
extern uint32_t     ticks;
void            trapinit(void);
void            trapinithart(void);
void            timerinit(void);
extern struct spinlock tickslock;
void            prepare_return(void);

// uart.c
void            uartinit(void);
void            uartintr(void);
void            uartwrite(char [], int);
void            uartputc_sync(int);
int             uartgetc(void);

// vm.c
void            kvminit(void);
void            kvminithart(void);
void            kvmmap(pagetable_t, uint64_t, uint64_t, uint64_t, int);
int             mappages(pagetable_t, uint64_t, uint64_t, uint64_t, int);
pagetable_t     uvmcreate(void);
uint64_t          uvmalloc(pagetable_t, uint64_t, uint64_t, int);
uint64_t          uvmdealloc(pagetable_t, uint64_t, uint64_t);
int             uvmcopy(pagetable_t, pagetable_t, uint64_t);
void            uvmfree(pagetable_t, uint64_t);
void            uvmunmap(pagetable_t, uint64_t, uint64_t, int);
void            uvmclear(pagetable_t, uint64_t);
pte_t *         walk(pagetable_t, uint64_t, int);
uint64_t          walkaddr(pagetable_t, uint64_t);
int             copyout(pagetable_t, uint64_t, char *, uint64_t);
int             copyin(pagetable_t, char *, uint64_t, uint64_t);
int             copyinstr(pagetable_t, char *, uint64_t, uint64_t);
int             ismapped(pagetable_t, uint64_t);
uint64_t          vmfault(pagetable_t, uint64_t, int);
uint64_t          vma_find_addr(struct proc*, uint64_t);
int             vmafault(struct proc*, uint64_t);
void            vma_unmap_range(struct proc*, uint64_t, uint64_t);
void            vma_free_all(struct proc*);

// plic.c
void            plicinit(void);
void            plicinithart(void);
int             plic_claim(void);
void            plic_complete(int);

// ramfs.c
void            ramfsinit(void);
void            ramfs_rw(struct buf *b, int write);

// fb.c
void            fbinit(void);

// pdev.c
void            pdevinit(void);

// number of elements in fixed-size array
#define NELEM(x) (sizeof(x)/sizeof((x)[0]))

#endif /* _LEN_DEFS_H_ */
