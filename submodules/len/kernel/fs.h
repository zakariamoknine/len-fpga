#ifndef _LEN_FS_H_
#define _LEN_FS_H_

#define ROOTINO  1
#define BSIZE    1024

// Disk layout:
// [ boot block | super block | log | inode blocks | free bit map | data blocks]
//
// mkfs computes the super block and builds an initial file system. The
// super block describes the disk layout:
struct superblock {
	uint32_t magic;
	uint32_t size;
	uint32_t nblocks;
	uint32_t ninodes;
	uint32_t nlog;
	uint32_t logstart;
	uint32_t inodestart;
	uint32_t bmapstart;
};

#define FSMAGIC 0x10203040

#define NDIRECT 11
#define NINDIRECT  (BSIZE / sizeof(uint32_t))
#define NDINDIRECT (NINDIRECT * NINDIRECT)
#define MAXFILE    (NDIRECT + NINDIRECT + NDINDIRECT)

// On-disk inode structure
struct dinode {
	short type;
	short major;
	short minor;
	short nlink;
	uint32_t size;
	uint32_t addrs[NDIRECT+2];
};

#define IPB           (BSIZE / sizeof(struct dinode))

#define IBLOCK(i, sb) ((i) / IPB + sb.inodestart)

#define BPB           (BSIZE*8)

#define BBLOCK(b, sb) ((b)/BPB + sb.bmapstart)

#define DIRSIZ 14

struct dirent {
	uint16_t inum;
	char name[DIRSIZ] __attribute__((nonstring));
};

#endif /* _LEN_FS_H_ */
