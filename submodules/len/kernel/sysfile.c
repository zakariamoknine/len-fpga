#include "len.h"

#include "stat.h"
#include "proc.h"
#include "fs.h"
#include "file.h"
#include "fcntl.h"

static int argfd(int n, int *pfd, struct file **pf)
{
	int fd;
	struct file *f;

	argint(n, &fd);
	if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
		return -1;
	if(pfd)
		*pfd = fd;
	if(pf)
		*pf = f;
	return 0;
}

static int fdalloc(struct file *f)
{
	int fd;
	struct proc *p = myproc();

	for(fd = 0; fd < NOFILE; fd++){
		if(p->ofile[fd] == 0){
			p->ofile[fd] = f;
			return fd;
		}
	}
	return -1;
}

uint64_t sys_dup(void)
{
	struct file *f;
	int fd;

	if(argfd(0, 0, &f) < 0)
		return -1;
	if((fd=fdalloc(f)) < 0)
		return -1;
	filedup(f);
	return fd;
}

uint64_t sys_read(void)
{
	struct file *f;
	int n;
	uint64_t p;

	argaddr(1, &p);
	argint(2, &n);
	if(argfd(0, 0, &f) < 0)
		return -1;
	return fileread(f, p, n);
}

uint64_t sys_write(void)
{
	struct file *f;
	int n;
	uint64_t p;

	argaddr(1, &p);
	argint(2, &n);
	if(argfd(0, 0, &f) < 0)
		return -1;

	return filewrite(f, p, n);
}

uint64_t sys_close(void)
{
	int fd;
	struct file *f;

	if(argfd(0, &fd, &f) < 0)
		return -1;
	myproc()->ofile[fd] = 0;
	fileclose(f);
	return 0;
}

uint64_t sys_fstat(void)
{
	struct file *f;
	uint64_t st;

	argaddr(1, &st);
	if(argfd(0, 0, &f) < 0)
		return -1;
	return filestat(f, st);
}

uint64_t sys_link(void)
{
	char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
	struct inode *dp, *ip;

	if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
		return -1;

	begin_op();
	if((ip = namei(old)) == 0){
		end_op();
		return -1;
	}

	ilock(ip);
	if(ip->type == T_DIR){
		iunlockput(ip);
		end_op();
		return -1;
	}

	ip->nlink++;
	iupdate(ip);
	iunlock(ip);

	if((dp = nameiparent(new, name)) == 0)
		goto bad;
	ilock(dp);
	if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
		iunlockput(dp);
		goto bad;
	}
	iunlockput(dp);
	iput(ip);

	end_op();

	return 0;

bad:
	ilock(ip);
	ip->nlink--;
	iupdate(ip);
	iunlockput(ip);
	end_op();
	return -1;
}

static int isdirempty(struct inode *dp)
{
	int off;
	struct dirent de;

	for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
		if(readi(dp, 0, (uint64_t)&de, off, sizeof(de)) != sizeof(de))
			panic("isdirempty: readi");
		if(de.inum != 0)
			return 0;
	}
	return 1;
}

uint64_t sys_unlink(void)
{
	struct inode *ip, *dp;
	struct dirent de;
	char name[DIRSIZ], path[MAXPATH];
	uint32_t off;

	if(argstr(0, path, MAXPATH) < 0)
		return -1;

	begin_op();
	if((dp = nameiparent(path, name)) == 0){
		end_op();
		return -1;
	}

	ilock(dp);

	if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
		goto bad;

	if((ip = dirlookup(dp, name, &off)) == 0)
		goto bad;
	ilock(ip);

	if(ip->nlink < 1)
		panic("unlink: nlink < 1");
	if(ip->type == T_DIR && !isdirempty(ip)){
		iunlockput(ip);
		goto bad;
	}

	memset(&de, 0, sizeof(de));
	if(writei(dp, 0, (uint64_t)&de, off, sizeof(de)) != sizeof(de))
		panic("unlink: writei");
	if(ip->type == T_DIR){
		dp->nlink--;
		iupdate(dp);
	}
	iunlockput(dp);

	ip->nlink--;
	iupdate(ip);
	iunlockput(ip);

	end_op();

	return 0;

bad:
	iunlockput(dp);
	end_op();
	return -1;
}

static struct inode* create(char *path, short type, short major, short minor)
{
	struct inode *ip, *dp;
	char name[DIRSIZ];

	if((dp = nameiparent(path, name)) == 0)
		return 0;

	ilock(dp);

	if((ip = dirlookup(dp, name, 0)) != 0){
		iunlockput(dp);
		ilock(ip);
		if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
			return ip;
		iunlockput(ip);
		return 0;
	}

	if((ip = ialloc(dp->dev, type)) == 0){
		iunlockput(dp);
		return 0;
	}

	ilock(ip);
	ip->major = major;
	ip->minor = minor;
	ip->nlink = 1;
	iupdate(ip);

	if(type == T_DIR){
		if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
			goto fail;
	}

	if(dirlink(dp, name, ip->inum) < 0)
		goto fail;

	if(type == T_DIR){
		dp->nlink++;
		iupdate(dp);
	}

	iunlockput(dp);

	return ip;

fail:
	ip->nlink = 0;
	iupdate(ip);
	iunlockput(ip);
	iunlockput(dp);
	return 0;
}

uint64_t sys_open(void)
{
	char path[MAXPATH];
	int fd, omode;
	struct file *f;
	struct inode *ip;
	int n;

	argint(1, &omode);
	if((n = argstr(0, path, MAXPATH)) < 0)
		return -1;

	begin_op();

	if(omode & O_CREATE){
		ip = create(path, T_FILE, 0, 0);
		if(ip == 0){
			end_op();
			return -1;
		}
	} else {
		if((ip = namei(path)) == 0){
			end_op();
			return -1;
		}
		ilock(ip);
		if(ip->type == T_DIR && omode != O_RDONLY){
			iunlockput(ip);
			end_op();
			return -1;
		}
	}

	if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
		iunlockput(ip);
		end_op();
		return -1;
	}

	if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
		if(f)
			fileclose(f);
		iunlockput(ip);
		end_op();
		return -1;
	}

	if(ip->type == T_DEVICE){
		f->type = FD_DEVICE;
		f->major = ip->major;
		f->off = 0;
	} else {
		f->type = FD_INODE;
		f->off = 0;
	}
	f->ip = ip;
	f->readable = !(omode & O_WRONLY);
	f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
	f->nonblock  = (omode & O_NONBLOCK) ? 1 : 0;

	if((omode & O_TRUNC) && ip->type == T_FILE){
		itrunc(ip);
	}

	iunlock(ip);
	end_op();

	return fd;
}

uint64_t sys_mkdir(void)
{
	char path[MAXPATH];
	struct inode *ip;

	begin_op();
	if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
		end_op();
		return -1;
	}
	iunlockput(ip);
	end_op();
	return 0;
}

uint64_t sys_mknod(void)
{
	struct inode *ip;
	char path[MAXPATH];
	int major, minor;

	begin_op();
	argint(1, &major);
	argint(2, &minor);
	if((argstr(0, path, MAXPATH)) < 0 ||
			(ip = create(path, T_DEVICE, major, minor)) == 0){
		end_op();
		return -1;
	}
	iunlockput(ip);
	end_op();
	return 0;
}

uint64_t sys_chdir(void)
{
	char path[MAXPATH];
	struct inode *ip;
	struct proc *p = myproc();

	begin_op();
	if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
		end_op();
		return -1;
	}
	ilock(ip);
	if(ip->type != T_DIR){
		iunlockput(ip);
		end_op();
		return -1;
	}
	iunlock(ip);
	iput(p->cwd);
	end_op();
	p->cwd = ip;
	return 0;
}

uint64_t sys_exec(void)
{
	char path[MAXPATH], *argv[MAXARG];
	int i;
	uint64_t uargv, uarg;

	argaddr(1, &uargv);
	if(argstr(0, path, MAXPATH) < 0) {
		return -1;
	}
	memset(argv, 0, sizeof(argv));
	for(i=0;; i++){
		if(i >= NELEM(argv)){
			goto bad;
		}
		if(fetchaddr(uargv+sizeof(uint64_t)*i, (uint64_t*)&uarg) < 0){
			goto bad;
		}
		if(uarg == 0){
			argv[i] = 0;
			break;
		}
		argv[i] = kalloc();
		if(argv[i] == 0)
			goto bad;
		if(fetchstr(uarg, argv[i], PGSIZE) < 0)
			goto bad;
	}

	int ret = kexec(path, argv);

	for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
		kfree(argv[i]);

	return ret;

bad:
	for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
		kfree(argv[i]);
	return -1;
}

uint64_t sys_pipe(void)
{
	uint64_t fdarray;
	struct file *rf, *wf;
	int fd0, fd1;
	struct proc *p = myproc();

	argaddr(0, &fdarray);
	if(pipealloc(&rf, &wf) < 0)
		return -1;
	fd0 = -1;
	if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
		if(fd0 >= 0)
			p->ofile[fd0] = 0;
		fileclose(rf);
		fileclose(wf);
		return -1;
	}
	if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
			copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
		p->ofile[fd0] = 0;
		p->ofile[fd1] = 0;
		fileclose(rf);
		fileclose(wf);
		return -1;
	}
	return 0;
}

uint64_t sys_mmap(void)
{
	uint64_t addr, len, offset;
	int prot, flags, fd;
	struct proc *p = myproc();
	struct file *f = 0;

	argaddr(0, &addr);
	argaddr(1, &len);
	argint (2, &prot);
	argint (3, &flags);
	argint (4, &fd);
	argaddr(5, &offset);

	if(len == 0)
		return -1;

	len = PGROUNDUP(len);

	struct vma *v = 0;
	for(int i = 0; i < NVMA; i++){
		if(!p->vmas[i].used){ v = &p->vmas[i]; break; }
	}
	if(!v)
		return -1;

	if(addr == 0){
		addr = vma_find_addr(p, len);
		if(addr == 0)
			return -1;
	} else {
		addr = PGROUNDDOWN(addr);
		if(addr == 0)
			return -1;
		if(addr < MMAPBASE || addr + len > TRAPFRAME)
			return -1;

		for(int i = 0; i < NVMA; i++){
			if(!p->vmas[i].used) continue;
			uint64_t vs = p->vmas[i].addr, ve = vs + p->vmas[i].len;
			if(addr < ve && addr + len > vs)
				return -1;
		}
	}

	if(flags & MAP_ANON){
		v->used   = 1;
		v->addr   = addr;
		v->len    = len;
		v->prot   = prot;
		v->flags  = flags;
		v->type   = VMA_ANON;
		v->offset = 0;
		v->f      = 0;
		v->major  = 0;
		return addr;
	}

	if(fd < 0 || fd >= NOFILE || (f = p->ofile[fd]) == 0)
		return -1;
	if(f->type != FD_DEVICE)
		return -1;
	if(f->major < 0 || f->major >= NDEV || !devsw[f->major].mmap)
		return -1;

	offset = PGROUNDDOWN(offset);

	v->used   = 1;
	v->addr   = addr;
	v->len    = len;
	v->prot   = prot;
	v->flags  = flags;
	v->type   = VMA_DEV;
	v->offset = offset;
	v->f      = filedup(f);
	v->major  = f->major;
	return addr;
}

uint64_t sys_munmap(void)
{
	uint64_t addr, len;

	argaddr(0, &addr);
	argaddr(1, &len);

	addr = PGROUNDDOWN(addr);
	len  = PGROUNDUP(len);
	if(len == 0)
		return 0;

	vma_unmap_range(myproc(), addr, len);
	return 0;
}

uint64_t sys_lseek(void)
{
	struct file *f;
	int64_t offset;
	int whence;

	if(argfd(0, 0, &f) < 0)
		return -1;
	argaddr(1, (uint64_t*)&offset);
	argint(2, &whence);

	if(f->type != FD_INODE)
		return -1;

	ilock(f->ip);
	uint64_t size = f->ip->size;
	iunlock(f->ip);

	int64_t newoff;
	if(whence == SEEK_SET){
		newoff = offset;
	} else if(whence == SEEK_CUR){
		newoff = (int64_t)f->off + offset;
	} else if(whence == SEEK_END){
		newoff = (int64_t)size + offset;
	} else {
		return -1;
	}

	if(newoff < 0)
		return -1;

	f->off = (uint32_t)newoff;
	return (uint64_t)newoff;
}

uint64_t sys_getcwd(void)
{
    uint64_t ubuf;
    int size;

    argaddr(0, &ubuf);
    argint (1, &size);

    if(size <= 0)
        return 0;

    struct proc *p = myproc();

    char tmp[MAXPATH];
    int  pos = MAXPATH - 1;
    tmp[pos] = '\0';

    struct inode *cur = idup(p->cwd);

    for(;;){
        uint32_t cur_inum;

        ilock(cur);
        cur_inum = cur->inum;
        iunlock(cur);

        if(cur_inum == ROOTINO){
            iput(cur);
            break;
        }

        ilock(cur);
        struct inode *par = dirlookup(cur, "..", 0);
        iunlock(cur);

        if(par == 0){
            iput(cur);
            return 0;
        }

        struct dirent de;
        char name[DIRSIZ + 1];
        int  found = 0;

        ilock(par);
        for(uint32_t off = 0; off < par->size; off += sizeof(de)){
            if(readi(par, 0, (uint64_t)&de, off, sizeof(de)) != sizeof(de))
                break;
            if(de.inum == 0)
                continue;
            if(de.inum == (uint16_t)cur_inum){
                int nlen = 0;
                while(nlen < DIRSIZ && de.name[nlen])
                    nlen++;
                memmove(name, de.name, nlen);
                name[nlen] = '\0';
                found = 1;
                break;
            }
        }
        iunlock(par);

        if(!found){
            iput(par);
            iput(cur);
            return 0;
        }

        int nlen = strlen(name);
        if(pos < nlen + 1){
            iput(par);
            iput(cur);
            return 0;
        }
        pos -= nlen;
        memmove(tmp + pos, name, nlen);
        tmp[--pos] = '/';

        iput(cur);
        cur = par;
    }

    if(pos == MAXPATH - 1){
        if(pos < 1) return 0;
        tmp[--pos] = '/';
    }

    char *path = tmp + pos;
    int   plen = strlen(path) + 1;
    if(plen > size)
        return 0;
    if(copyout(p->pagetable, ubuf, path, plen) < 0)
        return 0;

    return ubuf;
}
