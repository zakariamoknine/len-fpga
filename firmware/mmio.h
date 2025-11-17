#ifndef _LEN_FPGA_MMIO_H_
#define _LEN_FPGA_MMIO_H_

/*
 * UART 16550
 */
#define UART_BASE        0x44A00000UL

#define UART_RBR         0x00
#define UART_THR         0x00
#define UART_DLL         0x00
#define UART_IER         0x04
#define UART_DLM         0x04
#define UART_FCR         0x08
#define UART_LCR         0x0C
#define UART_MCR         0x10
#define UART_LSR         0x14
#define UART_MSR         0x18
#define UART_SCR         0x1C

#define LCR_DLAB         (1 << 7)
#define LCR_8N1          0x03
#define FCR_ENABLE_FIFO  (1 << 0)
#define FCR_CLEAR_RX     (1 << 1)
#define FCR_CLEAR_TX     (1 << 2)
#define MCR_DTR          (1 << 0)
#define MCR_RTS          (1 << 1)

/*
 * DDR2 SDRAM
 */
#define DDR2_BASE        0x80000000UL
#define DDR2_SIZE        (128UL * 1024 * 1024) /* 128MiB */

#endif /* !_LEN_FPGA_MMIO_H_ */
