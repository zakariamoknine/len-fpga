#ifndef _LEN_VMA_H_
#define _LEN_VMA_H_

#define VMA_ANON 1
#define VMA_DEV  2

#define PROT_NONE  0x0
#define PROT_READ  0x1
#define PROT_WRITE 0x2
#define PROT_EXEC  0x4

#define MAP_SHARED  0x01
#define MAP_PRIVATE 0x02
#define MAP_ANON    0x20

#define MAP_FAILED ((void *)-1)

struct vma {
	int          used;
	uint64_t       addr;
	uint64_t       len;
	int          prot;
	int          flags;
	int          type;
	uint64_t       offset;
	struct file *f;
	short        major;
};

#endif /* _LEN_VMA_H_ */
