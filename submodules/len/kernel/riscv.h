#ifndef _LEN_RISCV_H_
#define _LEN_RISCV_H_

#ifndef __ASSEMBLER__

static inline uint64_t
r_mhartid()
{
  uint64_t x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
  return x;
}

#define MSTATUS_MPP_MASK (3L << 11)
#define MSTATUS_MPP_M (3L << 11)
#define MSTATUS_MPP_S (1L << 11)
#define MSTATUS_MPP_U (0L << 11)

static inline uint64_t
r_mstatus()
{
  uint64_t x;
  asm volatile("csrr %0, mstatus" : "=r" (x) );
  return x;
}

static inline void 
w_mstatus(uint64_t x)
{
  asm volatile("csrw mstatus, %0" : : "r" (x));
}

static inline void 
w_mepc(uint64_t x)
{
  asm volatile("csrw mepc, %0" : : "r" (x));
}

#define SSTATUS_SPP (1L << 8)
#define SSTATUS_SPIE (1L << 5)
#define SSTATUS_UPIE (1L << 4)
#define SSTATUS_SIE (1L << 1)
#define SSTATUS_UIE (1L << 0)

#define SSTATUS_FS          (3L << 13)
#define SSTATUS_FS_OFF      (0L << 13)
#define SSTATUS_FS_INITIAL  (1L << 13)
#define SSTATUS_FS_CLEAN    (2L << 13)
#define SSTATUS_FS_DIRTY    (3L << 13)

static inline uint64_t
r_sstatus()
{
  uint64_t x;
  asm volatile("csrr %0, sstatus" : "=r" (x) );
  return x;
}

static inline void 
w_sstatus(uint64_t x)
{
  asm volatile("csrw sstatus, %0" : : "r" (x));
}

static inline uint64_t
r_sip()
{
  uint64_t x;
  asm volatile("csrr %0, sip" : "=r" (x) );
  return x;
}

static inline void 
w_sip(uint64_t x)
{
  asm volatile("csrw sip, %0" : : "r" (x));
}

#define SIE_SEIE (1L << 9)
#define SIE_STIE (1L << 5)

static inline uint64_t
r_sie()
{
  uint64_t x;
  asm volatile("csrr %0, sie" : "=r" (x) );
  return x;
}

static inline void 
w_sie(uint64_t x)
{
  asm volatile("csrw sie, %0" : : "r" (x));
}

#define MIE_STIE (1L << 5)

static inline uint64_t
r_mie()
{
  uint64_t x;
  asm volatile("csrr %0, mie" : "=r" (x) );
  return x;
}

static inline void 
w_mie(uint64_t x)
{
  asm volatile("csrw mie, %0" : : "r" (x));
}

static inline void 
w_sepc(uint64_t x)
{
  asm volatile("csrw sepc, %0" : : "r" (x));
}

static inline uint64_t
r_sepc()
{
  uint64_t x;
  asm volatile("csrr %0, sepc" : "=r" (x) );
  return x;
}

static inline uint64_t
r_medeleg()
{
  uint64_t x;
  asm volatile("csrr %0, medeleg" : "=r" (x) );
  return x;
}

static inline void 
w_medeleg(uint64_t x)
{
  asm volatile("csrw medeleg, %0" : : "r" (x));
}

static inline uint64_t
r_mideleg()
{
  uint64_t x;
  asm volatile("csrr %0, mideleg" : "=r" (x) );
  return x;
}

static inline void 
w_mideleg(uint64_t x)
{
  asm volatile("csrw mideleg, %0" : : "r" (x));
}

static inline void 
w_stvec(uint64_t x)
{
  asm volatile("csrw stvec, %0" : : "r" (x));
}

static inline uint64_t
r_stvec()
{
  uint64_t x;
  asm volatile("csrr %0, stvec" : "=r" (x) );
  return x;
}

static inline uint64_t
r_stimecmp()
{
  uint64_t x;
  asm volatile("csrr %0, 0x14d" : "=r" (x) );
  return x;
}

static inline void 
w_stimecmp(uint64_t x)
{
  asm volatile("csrw 0x14d, %0" : : "r" (x));
}

static inline uint64_t
r_menvcfg()
{
  uint64_t x;
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
  return x;
}

static inline void 
w_menvcfg(uint64_t x)
{
  asm volatile("csrw 0x30a, %0" : : "r" (x));
}

static inline void
w_pmpcfg0(uint64_t x)
{
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
}

static inline void
w_pmpaddr0(uint64_t x)
{
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
}

#define SATP_SV39 (8L << 60)

#define MAKE_SATP(pagetable) (SATP_SV39 | (((uint64_t)pagetable) >> 12))

static inline void 
w_satp(uint64_t x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
}

static inline uint64_t
r_satp()
{
  uint64_t x;
  asm volatile("csrr %0, satp" : "=r" (x) );
  return x;
}

static inline uint64_t
r_scause()
{
  uint64_t x;
  asm volatile("csrr %0, scause" : "=r" (x) );
  return x;
}

static inline uint64_t
r_stval()
{
  uint64_t x;
  asm volatile("csrr %0, stval" : "=r" (x) );
  return x;
}

static inline void 
w_mcounteren(uint64_t x)
{
  asm volatile("csrw mcounteren, %0" : : "r" (x));
}

static inline uint64_t
r_mcounteren()
{
  uint64_t x;
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
  return x;
}

static inline uint64_t
r_time()
{
  uint64_t x;
  asm volatile("csrr %0, time" : "=r" (x) );
  return x;
}

static inline void
intr_on()
{
  w_sstatus(r_sstatus() | SSTATUS_SIE);
}

static inline void
intr_off()
{
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
}

static inline int
intr_get()
{
  uint64_t x = r_sstatus();
  return (x & SSTATUS_SIE) != 0;
}

static inline uint64_t
r_sp()
{
  uint64_t x;
  asm volatile("mv %0, sp" : "=r" (x) );
  return x;
}

static inline uint64_t
r_tp()
{
  uint64_t x;
  asm volatile("mv %0, tp" : "=r" (x) );
  return x;
}

static inline void 
w_tp(uint64_t x)
{
  asm volatile("mv tp, %0" : : "r" (x));
}

static inline uint64_t
r_ra()
{
  uint64_t x;
  asm volatile("mv %0, ra" : "=r" (x) );
  return x;
}

static inline void
sfence_vma()
{
  asm volatile("sfence.vma zero, zero");
}

typedef uint64_t pte_t;
typedef uint64_t *pagetable_t;

#endif // __ASSEMBLER__

#define PGSIZE 4096
#define PGSHIFT 12

#define PGROUNDUP(sz)  (((sz)+PGSIZE-1) & ~(PGSIZE-1))
#define PGROUNDDOWN(a) (((a)) & ~(PGSIZE-1))

#define PTE_V (1L << 0)
#define PTE_R (1L << 1)
#define PTE_W (1L << 2)
#define PTE_X (1L << 3)
#define PTE_U (1L << 4)
#define PTE_D (1L << 7)
#define PTE_A (1L << 6)

#define PA2PTE(pa) ((((uint64_t)pa) >> 12) << 10)

#define PTE2PA(pte) (((pte) >> 10) << 12)

#define PTE_FLAGS(pte) ((pte) & 0x3FF)

#define PXMASK          0x1FF
#define PXSHIFT(level)  (PGSHIFT+(9*(level)))
#define PX(level, va) ((((uint64_t) (va)) >> PXSHIFT(level)) & PXMASK)

#define MAXVA (1L << (9 + 9 + 9 + 12 - 1))

#endif /* _LEN_RISCV_H_ */
