#ifndef _LEN_FPGA_CSR_H_
#define _LEN_FPGA_CSR_H_

#define CSR_CYCLE		0xc00
#define CSR_TIME		0xc01
#define CSR_INSTRET		0xc02
#define CSR_HPMCOUNTER3		0xc03
#define CSR_HPMCOUNTER4		0xc04
#define CSR_HPMCOUNTER5		0xc05
#define CSR_HPMCOUNTER6		0xc06
#define CSR_HPMCOUNTER7		0xc07
#define CSR_HPMCOUNTER8		0xc08
#define CSR_HPMCOUNTER9		0xc09
#define CSR_HPMCOUNTER10	0xc0a
#define CSR_HPMCOUNTER11	0xc0b
#define CSR_HPMCOUNTER12	0xc0c
#define CSR_HPMCOUNTER13	0xc0d
#define CSR_HPMCOUNTER14	0xc0e
#define CSR_HPMCOUNTER15	0xc0f
#define CSR_HPMCOUNTER16	0xc10
#define CSR_HPMCOUNTER17	0xc11
#define CSR_HPMCOUNTER18	0xc12
#define CSR_HPMCOUNTER19	0xc13
#define CSR_HPMCOUNTER20	0xc14
#define CSR_HPMCOUNTER21	0xc15
#define CSR_HPMCOUNTER22	0xc16
#define CSR_HPMCOUNTER23	0xc17
#define CSR_HPMCOUNTER24	0xc18
#define CSR_HPMCOUNTER25	0xc19
#define CSR_HPMCOUNTER26	0xc1a
#define CSR_HPMCOUNTER27	0xc1b
#define CSR_HPMCOUNTER28	0xc1c
#define CSR_HPMCOUNTER29	0xc1d
#define CSR_HPMCOUNTER30	0xc1e
#define CSR_HPMCOUNTER31	0xc1f
#define CSR_CYCLEH		0xc80
#define CSR_TIMEH		0xc81
#define CSR_INSTRETH		0xc82
#define CSR_HPMCOUNTER3H	0xc83
#define CSR_HPMCOUNTER4H	0xc84
#define CSR_HPMCOUNTER5H	0xc85
#define CSR_HPMCOUNTER6H	0xc86
#define CSR_HPMCOUNTER7H	0xc87
#define CSR_HPMCOUNTER8H	0xc88
#define CSR_HPMCOUNTER9H	0xc89
#define CSR_HPMCOUNTER10H	0xc8a
#define CSR_HPMCOUNTER11H	0xc8b
#define CSR_HPMCOUNTER12H	0xc8c
#define CSR_HPMCOUNTER13H	0xc8d
#define CSR_HPMCOUNTER14H	0xc8e
#define CSR_HPMCOUNTER15H	0xc8f
#define CSR_HPMCOUNTER16H	0xc90
#define CSR_HPMCOUNTER17H	0xc91
#define CSR_HPMCOUNTER18H	0xc92
#define CSR_HPMCOUNTER19H	0xc93
#define CSR_HPMCOUNTER20H	0xc94
#define CSR_HPMCOUNTER21H	0xc95
#define CSR_HPMCOUNTER22H	0xc96
#define CSR_HPMCOUNTER23H	0xc97
#define CSR_HPMCOUNTER24H	0xc98
#define CSR_HPMCOUNTER25H	0xc99
#define CSR_HPMCOUNTER26H	0xc9a
#define CSR_HPMCOUNTER27H	0xc9b
#define CSR_HPMCOUNTER28H	0xc9c
#define CSR_HPMCOUNTER29H	0xc9d
#define CSR_HPMCOUNTER30H	0xc9e
#define CSR_HPMCOUNTER31H	0xc9f

#define CSR_SCOUNTOVF		0xda0

#define CSR_SSTATUS		0x100
#define CSR_SIE			0x104
#define CSR_STVEC		0x105
#define CSR_SCOUNTEREN		0x106
#define CSR_SENVCFG		0x10a
#define CSR_SSTATEEN0		0x10c
#define CSR_SSCRATCH		0x140
#define CSR_SEPC		0x141
#define CSR_SCAUSE		0x142
#define CSR_STVAL		0x143
#define CSR_SIP			0x144
#define CSR_SATP		0x180

#define CSR_STIMECMP		0x14D
#define CSR_STIMECMPH		0x15D

#define CSR_VXSAT		0x9
#define CSR_VXRM		0xa

#define CSR_VXRM_MASK		3
#define CSR_VXRM_SHIFT		1
#define CSR_VXSAT_MASK		1

#define CSR_SISELECT		0x150
#define CSR_SIREG		0x151

#define CSR_STOPEI		0x15c
#define CSR_STOPI		0xdb0

#define CSR_SIEH		0x114
#define CSR_SIPH		0x154

#define CSR_VSSTATUS		0x200
#define CSR_VSIE		0x204
#define CSR_VSTVEC		0x205
#define CSR_VSSCRATCH		0x240
#define CSR_VSEPC		0x241
#define CSR_VSCAUSE		0x242
#define CSR_VSTVAL		0x243
#define CSR_VSIP		0x244
#define CSR_VSATP		0x280
#define CSR_VSTIMECMP		0x24D
#define CSR_VSTIMECMPH		0x25D

#define CSR_HSTATUS		0x600
#define CSR_HEDELEG		0x602
#define CSR_HIDELEG		0x603
#define CSR_HIE			0x604
#define CSR_HTIMEDELTA		0x605
#define CSR_HCOUNTEREN		0x606
#define CSR_HGEIE		0x607
#define CSR_HENVCFG		0x60a
#define CSR_HTIMEDELTAH		0x615
#define CSR_HENVCFGH		0x61a
#define CSR_HTVAL		0x643
#define CSR_HIP			0x644
#define CSR_HVIP		0x645
#define CSR_HTINST		0x64a
#define CSR_HGATP		0x680
#define CSR_HGEIP		0xe12

#define CSR_HVIEN		0x608
#define CSR_HVICTL		0x609
#define CSR_HVIPRIO1		0x646
#define CSR_HVIPRIO2		0x647

#define CSR_VSISELECT		0x250
#define CSR_VSIREG		0x251

#define CSR_VSTOPEI		0x25c
#define CSR_VSTOPI		0xeb0

#define CSR_HIDELEGH		0x613
#define CSR_HVIENH		0x618
#define CSR_HVIPH		0x655
#define CSR_HVIPRIO1H		0x656
#define CSR_HVIPRIO2H		0x657
#define CSR_VSIEH		0x214
#define CSR_VSIPH		0x254

#define CSR_HSTATEEN0		0x60c
#define CSR_HSTATEEN0H		0x61c

#define CSR_MSTATUS		0x300
#define CSR_MISA		0x301
#define CSR_MIDELEG		0x303
#define CSR_MIE			0x304
#define CSR_MTVEC		0x305
#define CSR_MENVCFG		0x30a
#define CSR_MENVCFGH		0x31a
#define CSR_MSCRATCH		0x340
#define CSR_MEPC		0x341
#define CSR_MCAUSE		0x342
#define CSR_MTVAL		0x343
#define CSR_MIP			0x344
#define CSR_PMPCFG0		0x3a0
#define CSR_PMPADDR0		0x3b0
#define CSR_MSECCFG		0x747
#define CSR_MSECCFGH		0x757
#define CSR_MVENDORID		0xf11
#define CSR_MARCHID		0xf12
#define CSR_MIMPID		0xf13
#define CSR_MHARTID		0xf14

#define CSR_MISELECT		0x350
#define CSR_MIREG		0x351

#define CSR_MTOPEI		0x35c
#define CSR_MTOPI		0xfb0

#define CSR_MVIEN		0x308
#define CSR_MVIP		0x309

#define CSR_MIDELEGH		0x313
#define CSR_MIEH		0x314
#define CSR_MVIENH		0x318
#define CSR_MVIPH		0x319
#define CSR_MIPH		0x354

#define CSR_VSTART		0x8
#define CSR_VCSR		0xf
#define CSR_VL			0xc20
#define CSR_VTYPE		0xc21
#define CSR_VLENB		0xc22

#define csr_read(csr)                                    \
	({                                               \
	    unsigned long __v;                           \
	    __asm__ __volatile__ ("csrr %0, %1"          \
				  : "=r" (__v)           \
				  : "i"(csr)             \
				  : "memory");           \
	    __v;                                         \
	})

#define csr_write(csr, val)                              \
	({                                               \
	    unsigned long __v = (unsigned long)(val);    \
	    __asm__ __volatile__ ("csrw %0, %1"          \
				  :                      \
				  : "i"(csr), "rK"(__v)  \
				  : "memory");           \
	})

#endif /* !_LEN_FPGA_CSR_H_ */
