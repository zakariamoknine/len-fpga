#ifndef _LEN_FPGA_TYPES_H_
#define _LEN_FPGA_TYPES_H_

#if __riscv_xlen != 64
	#error "len-fpga firmware works only on 64-bit processors"
#endif

#undef NULL
#define NULL ((void*)0)

enum {
	true  = 1,
	false = 0
};

typedef char                int8_t;
typedef short               int16_t;
typedef int                 int32_t;
typedef long                int64_t;

typedef unsigned char       uint8_t;
typedef unsigned short      uint16_t;
typedef unsigned int        uint32_t;
typedef unsigned long       uint64_t;
typedef unsigned long       uintptr_t;

typedef uintptr_t           size_t;
typedef long                ptrdiff_t;

typedef uint16_t            be16;
typedef uint32_t            be32;
typedef uint64_t            be64;

typedef uintptr_t           phys_addr_t;

#endif /* !_LEN_FPGA_TYPES_H_ */
