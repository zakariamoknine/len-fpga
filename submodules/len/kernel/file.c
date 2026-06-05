#include "len.h"

#include "fs.h"
#include "file.h"
#include "stat.h"
#include "proc.h"

struct devsw devsw[NDEV];

struct {
	struct spinlock lock;
	struct file file[NFILE];
} ftable;

void fileinit(void)
{
	initlock(&ftable.lock, "ftable");
}

struct file* filealloc(void)
{
	struct file *f;

	acquire(&ftable.lock);
	for(f = ftable.file; f < ftable.file + NFILE; f++){
		if(f->ref == 0){
			f->ref = 1;
			release(&ftable.lock);
			return f;
		}
	}
	release(&ftable.lock);
	return 0;
}

struct file* filedup(struct file *f)
{
	acquire(&ftable.lock);
	if(f->ref < 1)
		panic("filedup");
	f->ref++;
	release(&ftable.lock);
	return f;
}

void fileclose(struct file *f)
{
	struct file ff;

	acquire(&ftable.lock);
	if(f->ref < 1)
		panic("fileclose");
	if(--f->ref > 0){
		release(&ftable.lock);
		return;
	}
	ff = *f;
	f->ref = 0;
	f->type = FD_NONE;
	release(&ftable.lock);

	if(ff.type == FD_PIPE){
		pipeclose(ff.pipe, ff.writable);
	} else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
		begin_op();
		iput(ff.ip);
		end_op();
	}
}

int filestat(struct file *f, uint64_t addr)
{
	struct proc *p = myproc();
	struct stat st;

	if(f->type == FD_INODE || f->type == FD_DEVICE){
		ilock(f->ip);
		stati(f->ip, &st);
		iunlock(f->ip);
		if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
			return -1;
		return 0;
	}
	return -1;
}

int fileread(struct file *f, uint64_t addr, int n)
{
	int r = 0;

	if(f->readable == 0)
		return -1;

	if(f->type == FD_PIPE){
		r = piperead(f->pipe, addr, n);
	} else if(f->type == FD_DEVICE){
		if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
			return -1;
		r = devsw[f->major].read(1, addr, f->off, n, f->nonblock);
		if(r > 0)
			f->off += r;
	} else if(f->type == FD_INODE){
		ilock(f->ip);
		if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
			f->off += r;
		iunlock(f->ip);
	} else {
		panic("fileread");
	}

	return r;
}

int filewrite(struct file *f, uint64_t addr, int n)
{
	int r, ret = 0;

	if(f->writable == 0)
		return -1;

	if(f->type == FD_PIPE){
		ret = pipewrite(f->pipe, addr, n);
	} else if(f->type == FD_DEVICE){
		if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
			return -1;
		ret = devsw[f->major].write(1, addr, f->off, n);
		if (ret > 0)
			f->off += ret;
	} else if(f->type == FD_INODE){
		int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
		int i = 0;
		while(i < n){
			int n1 = n - i;
			if(n1 > max)
				n1 = max;

			begin_op();
			ilock(f->ip);
			if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
				f->off += r;
			iunlock(f->ip);
			end_op();

			if(r != n1){
				break;
			}
			i += r;
		}
		ret = (i == n ? n : -1);
	} else {
		panic("filewrite");
	}

	return ret;
}

