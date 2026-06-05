#ifndef _LEN_RISCV_SBI_H_
#define _LEN_RISCV_SBI_H_

#include "types.h"

#define SBI_EXT_TIME            0x54494D45
#define SBI_EXT_LEGACY_PUTCHAR  0x01

#define SBI_TIME_SET_TIMER      0

static inline long sbi_set_timer(uint64_t stime_value)
{
    register long a0 asm("a0") = stime_value;
    register long a6 asm("a6") = SBI_TIME_SET_TIMER;
    register long a7 asm("a7") = SBI_EXT_TIME;
    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a6), "r"(a7)
        : "memory");
    return a0;
}

static inline void sbi_console_putchar(int c)
{
    register long a0 asm("a0") = c;
    register long a7 asm("a7") = SBI_EXT_LEGACY_PUTCHAR;
    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a7)
        : "memory");
}

static inline void sbi_puts(const char *s)
{
    while (*s) {
        sbi_console_putchar(*s++);
	}
}

#endif /* _LEN_RISCV_SBI_H_ */
