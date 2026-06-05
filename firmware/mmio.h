#ifndef _LEN_FPGA_MMIO_H_
#define _LEN_FPGA_MMIO_H_

#include "types.h"

#define readl(addr) (*(volatile uint32_t*)(uintptr_t)(addr))
#define writel(addr, v) ((*(volatile uint32_t*)(uintptr_t)(addr)) = (v))

#define readb(addr) (*(volatile uint8_t*)(uintptr_t)(addr))
#define writeb(addr, v) ((*(volatile uint8_t*)(uintptr_t)(addr)) = (v))

/*
 * UART 16550
 */
#define UART_BASE_ADDR        0x4A000000

#define UART_BAUDRATE         460800

#define UART_RBR              (UART_BASE_ADDR + 0x00)
#define UART_THR              (UART_BASE_ADDR + 0x00)
#define UART_DLL              (UART_BASE_ADDR + 0x00)
#define UART_IER              (UART_BASE_ADDR + 0x04)
#define UART_DLM              (UART_BASE_ADDR + 0x04)
#define UART_FCR              (UART_BASE_ADDR + 0x08)
#define UART_LCR              (UART_BASE_ADDR + 0x0C)
#define UART_MCR              (UART_BASE_ADDR + 0x10)
#define UART_LSR              (UART_BASE_ADDR + 0x14)
#define UART_MSR              (UART_BASE_ADDR + 0x18)
#define UART_SCR              (UART_BASE_ADDR + 0x1C)

#define UART_LCR_DLAB         (1 << 7)
#define UART_LCR_8N1          0x03
#define UART_FCR_ENABLE_FIFO  (1 << 0)
#define UART_FCR_CLEAR_RX     (1 << 1)
#define UART_FCR_CLEAR_TX     (1 << 2)
#define UART_MCR_DTR          (1 << 0)
#define UART_MCR_RTS          (1 << 1)

/*
 * CLINT
 */
#define CLINT_BASE_ADDR  0x5A000000
#define CLINT_MSIP       (CLINT_BASE_ADDR)
#define CLINT_MTIMECMP   (CLINT_BASE_ADDR + 0x4000)
#define CLINT_MTIME      (CLINT_BASE_ADDR + 0xBFF8)

/*
 * PLIC
 */
#define PLIC_BASE_ADDR   0x50000000

#define PLIC_PENDING     (PLIC_BASE_ADDR + 0x1000)
#define PLIC_M_PRIORITY  (PLIC_BASE_ADDR + 0x04)
#define PLIC_M_ENABLE    (PLIC_BASE_ADDR + 0x2000)
#define PLIC_M_THRESHOLD (PLIC_BASE_ADDR + 0x200000)
#define PLIC_M_CLAIM     (PLIC_BASE_ADDR + 0x200004)

#define PLIC_MAX_SOURCES 32

/*
 * DDR2 SDRAM
 */
#define DDR2_BASE_ADDR   0x80000000
#define DDR2_SIZE        (128UL * 1024 * 1024) /* 128MiB */

/*
 * RAMFS
 */
#define RAMFS_BASE_ADDR  0x86000000

/*
 * AXI TFT CONTROLLER
 */
#define TFT_BASE_ADDR    0x40000000
#define TFT_AR           (TFT_BASE_ADDR + 0x00)
#define TFT_CR           (TFT_BASE_ADDR + 0x04)
#define TFT_IESR         (TFT_BASE_ADDR + 0x08)
#define TFT_CCR          (TFT_BASE_ADDR + 0x0C)
#define TFT_AR1          (TFT_BASE_ADDR + 0x10)
#define TFT_AR2          (TFT_BASE_ADDR + 0x14)

/*
 * FRAMEBUFFER
 */
#define FB_BASE_ADDR     0x87E00000
#define FB_SIZE          (1024 * 480 * 4)

/*
 * PMC
 */
#define PMC_BASE_ADDR    0x20000000
#define PMC_CONTROL      (PMC_BASE_ADDR + 0x00)
#define PMC_POWEROFF     0xB2
#define PMC_REBOOT       0xF7

/*
 * SYS
 */
#define SYS_CLK_FREQ           100000000
#define SYS_TIMEBASE_CLK_FREQ  100000000

#endif /* !_LEN_FPGA_MMIO_H_ */
