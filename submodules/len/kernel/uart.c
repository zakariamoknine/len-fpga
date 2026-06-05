#include "len.h"

#include "proc.h"

#define Reg(reg) ((volatile unsigned char *)(UART0 + (reg << 2)))

#define ReadReg(reg) (*(Reg(reg)))
#define WriteReg(reg, v) (*(Reg(reg)) = (v))

#define RHR 0
#define THR 0
#define IER 1
#define IER_RX_ENABLE (1<<0)
#define IER_TX_ENABLE (1<<1)
#define FCR 2
#define FCR_FIFO_ENABLE (1<<0)
#define FCR_FIFO_CLEAR (3<<1)
#define ISR 2
#define LCR 3
#define LCR_EIGHT_BITS (3<<0)
#define LCR_BAUD_LATCH (1<<7)
#define LSR 5
#define LSR_RX_READY (1<<0)
#define LSR_TX_IDLE (1<<5)

static struct spinlock tx_lock;
static int tx_busy;
static int tx_chan;

extern volatile int panicking;
extern volatile int panicked;

void uartinit(void)
{
	WriteReg(IER, 0x00);

	WriteReg(LCR, LCR_BAUD_LATCH);

	WriteReg(0, 0x0E); // 460800 baudrate @100MHz

	WriteReg(1, 0x00);

	WriteReg(LCR, LCR_EIGHT_BITS);

	WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);

	WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);

	initlock(&tx_lock, "uart");
}

void uartwrite(char buf[], int n)
{
	acquire(&tx_lock);

	int i = 0;
	while(i < n){ 
		while(tx_busy != 0){
			sleep(&tx_chan, &tx_lock);
		}   

		WriteReg(THR, buf[i]);
		i += 1;
		tx_busy = 1;
	}

	release(&tx_lock);
}

void uartputc_sync(int c)
{
	if(panicking == 0)
		push_off();

	if(panicked){
		for(;;)
			;
	}

	while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
		;
	WriteReg(THR, c);

	if(panicking == 0)
		pop_off();
}

int uartgetc(void)
{
	if(ReadReg(LSR) & LSR_RX_READY){
		return ReadReg(RHR);
	} else {
		return -1;
	}
}

void uartintr(void)
{
	ReadReg(ISR);

	acquire(&tx_lock);
	if(ReadReg(LSR) & LSR_TX_IDLE){
		tx_busy = 0;
		wakeup(&tx_chan);
	}
	release(&tx_lock);

	while(1){
		int c = uartgetc();
		if(c == -1)
			break;
		consoleintr(c);
	}
}

