#ifndef _LEN_ELF_H_
#define _LEN_ELF_H_

#define ELF_MAGIC 0x464C457FU 

struct elfhdr {
	uint32_t magic;
	uint8_t elf[12];
	uint16_t type;
	uint16_t machine;
	uint32_t version;
	uint64_t entry;
	uint64_t phoff;
	uint64_t shoff;
	uint32_t flags;
	uint16_t ehsize;
	uint16_t phentsize;
	uint16_t phnum;
	uint16_t shentsize;
	uint16_t shnum;
	uint16_t shstrndx;
};

struct proghdr {
	uint32_t type;
	uint32_t flags;
	uint64_t off;
	uint64_t vaddr;
	uint64_t paddr;
	uint64_t filesz;
	uint64_t memsz;
	uint64_t align;
};

#define ELF_PROG_LOAD        1

#define ELF_PROG_FLAG_EXEC   1
#define ELF_PROG_FLAG_WRITE  2
#define ELF_PROG_FLAG_READ   4

#endif /* _LEN_ELF_H_ */
