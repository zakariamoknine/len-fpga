#include "riscv.h"
#include "memlayout.h"

	.section trampsec
	.globl trampoline
	.globl usertrap
trampoline:

	.align 4
	.globl uservec
uservec:    
        csrw sscratch, a0

        li a0, TRAPFRAME
        
        sd ra, 40(a0)
        sd sp, 48(a0)
        sd gp, 56(a0)
        sd tp, 64(a0)
        sd t0, 72(a0)
        sd t1, 80(a0)
        sd t2, 88(a0)
        sd s0, 96(a0)
        sd s1, 104(a0)
        sd a1, 120(a0)
        sd a2, 128(a0)
        sd a3, 136(a0)
        sd a4, 144(a0)
        sd a5, 152(a0)
        sd a6, 160(a0)
        sd a7, 168(a0)
        sd s2, 176(a0)
        sd s3, 184(a0)
        sd s4, 192(a0)
        sd s5, 200(a0)
        sd s6, 208(a0)
        sd s7, 216(a0)
        sd s8, 224(a0)
        sd s9, 232(a0)
        sd s10, 240(a0)
        sd s11, 248(a0)
        sd t3, 256(a0)
        sd t4, 264(a0)
        sd t5, 272(a0)
        sd t6, 280(a0)

        csrr t0, sscratch
        sd t0, 112(a0)

        frcsr  t0
        sd     t0,  288(a0)
        fsd    f0,  296(a0)
        fsd    f1,  304(a0)
        fsd    f2,  312(a0)
        fsd    f3,  320(a0)
        fsd    f4,  328(a0)
        fsd    f5,  336(a0)
        fsd    f6,  344(a0)
        fsd    f7,  352(a0)
        fsd    f8,  360(a0)
        fsd    f9,  368(a0)
        fsd    f10, 376(a0)
        fsd    f11, 384(a0)
        fsd    f12, 392(a0)
        fsd    f13, 400(a0)
        fsd    f14, 408(a0)
        fsd    f15, 416(a0)
        fsd    f16, 424(a0)
        fsd    f17, 432(a0)
        fsd    f18, 440(a0)
        fsd    f19, 448(a0)
        fsd    f20, 456(a0)
        fsd    f21, 464(a0)
        fsd    f22, 472(a0)
        fsd    f23, 480(a0)
        fsd    f24, 488(a0)
        fsd    f25, 496(a0)
        fsd    f26, 504(a0)
        fsd    f27, 512(a0)
        fsd    f28, 520(a0)
        fsd    f29, 528(a0)
        fsd    f30, 536(a0)
        fsd    f31, 544(a0)

        ld sp, 8(a0)

        ld tp, 32(a0)

        ld t0, 16(a0)

        ld t1, 0(a0)

        sfence.vma zero, zero

        csrw satp, t1

        sfence.vma zero, zero

        jalr t0

.globl userret
userret:
        sfence.vma zero, zero
        csrw satp, a0
        sfence.vma zero, zero

        li a0, TRAPFRAME

        ld     t0,  288(a0)
        fscsr  t0
        fld    f0,  296(a0)
        fld    f1,  304(a0)
        fld    f2,  312(a0)
        fld    f3,  320(a0)
        fld    f4,  328(a0)
        fld    f5,  336(a0)
        fld    f6,  344(a0)
        fld    f7,  352(a0)
        fld    f8,  360(a0)
        fld    f9,  368(a0)
        fld    f10, 376(a0)
        fld    f11, 384(a0)
        fld    f12, 392(a0)
        fld    f13, 400(a0)
        fld    f14, 408(a0)
        fld    f15, 416(a0)
        fld    f16, 424(a0)
        fld    f17, 432(a0)
        fld    f18, 440(a0)
        fld    f19, 448(a0)
        fld    f20, 456(a0)
        fld    f21, 464(a0)
        fld    f22, 472(a0)
        fld    f23, 480(a0)
        fld    f24, 488(a0)
        fld    f25, 496(a0)
        fld    f26, 504(a0)
        fld    f27, 512(a0)
        fld    f28, 520(a0)
        fld    f29, 528(a0)
        fld    f30, 536(a0)
        fld    f31, 544(a0)

        ld ra, 40(a0)
        ld sp, 48(a0)
        ld gp, 56(a0)
        ld tp, 64(a0)
        ld t0, 72(a0)
        ld t1, 80(a0)
        ld t2, 88(a0)
        ld s0, 96(a0)
        ld s1, 104(a0)
        ld a1, 120(a0)
        ld a2, 128(a0)
        ld a3, 136(a0)
        ld a4, 144(a0)
        ld a5, 152(a0)
        ld a6, 160(a0)
        ld a7, 168(a0)
        ld s2, 176(a0)
        ld s3, 184(a0)
        ld s4, 192(a0)
        ld s5, 200(a0)
        ld s6, 208(a0)
        ld s7, 216(a0)
        ld s8, 224(a0)
        ld s9, 232(a0)
        ld s10, 240(a0)
        ld s11, 248(a0)
        ld t3, 256(a0)
        ld t4, 264(a0)
        ld t5, 272(a0)
        ld t6, 280(a0)

        ld a0, 112(a0)
        
        sret
