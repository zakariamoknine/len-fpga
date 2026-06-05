#include "len.h"
#include "fs.h"
#include "file.h"
#include "proc.h"

#include <stdarg.h>

#define BACKSPACE 0x100
#define C(x)  ((x)-'@')

void consputc(int c)
{
	if(c == BACKSPACE){
		uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
	} else {
		uartputc_sync(c);
	}
}

#define INPUT_BUF_SIZE 128
struct {
	struct spinlock lock;
	char buf[INPUT_BUF_SIZE];
	uint32_t r;
	uint32_t w;
	uint32_t e;
} cons;

int consolewrite(int user_src, uint64_t src, uint64_t off, int n)
{
	char buf[32];
	int i = 0;

	while(i < n){
		int nn = sizeof(buf);
		if(nn > n - i)
			nn = n - i;
		if(either_copyin(buf, user_src, src+i, nn) == -1)
			break;
		uartwrite(buf, nn);
		i += nn;
	}

	return i;
}

int consoleread(int user_dst, uint64_t dst, uint64_t off, int n, int nonblock)
{
    uint32_t target;
    int c;
    char cbuf;

    target = n;
    acquire(&cons.lock);
    while(n > 0){
        if(nonblock){
            if(cons.r == (nonblock ? cons.e : cons.w)){
                release(&cons.lock);
                return target - n;
            }
        } else {
            while(cons.r == cons.w){
                if(killed(myproc())){
                    release(&cons.lock);
                    return -1;
                }
                sleep(&cons.r, &cons.lock);
            }
        }

        c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

		if(cons.r > cons.w)
			cons.w = cons.r;

        if(!nonblock){
            if(c == C('D')){
                if(n < target) {
                    cons.r--;
					if(cons.w > cons.r)
						cons.w--;
				}
                break;
            }
        }

        cbuf = c;
        if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
            break;

        dst++;
        --n;

        if(!nonblock && c == '\n')
            break;
    }
    release(&cons.lock);
    return target - n;
}

void consoleintr(int c)
{
	acquire(&cons.lock);

	switch(c){
	case C('P'):
		procdump();
		break;
	case C('U'):
		while(cons.e != cons.w &&
				cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
			cons.e--;
			consputc(BACKSPACE);
		}
		break;
	case C('H'):
	case '\x7f':
		if(cons.e != cons.w){
			cons.e--;
			consputc(BACKSPACE);
		}
		break;
	default:
		if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
			c = (c == '\r') ? '\n' : c;

			consputc(c);

			cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;

			if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
				cons.w = cons.e;
				wakeup(&cons.r);
			}
		}
		break;
	}

	release(&cons.lock);
}

void consoleinit(void)
{
	initlock(&cons.lock, "cons");

	uartinit();

	devsw[CONS_DEV].read = consoleread;
	devsw[CONS_DEV].write = consolewrite;
	devsw[CONS_DEV].mmap = NULL;
}
