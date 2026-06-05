#ifndef _LEN_USER_H_
#define _LEN_USER_H_

#define NULL ((void*)0)

enum {
	false = 0,
	true = 1
};

#define stdin  0
#define stdout 1
#define stderr 2

#define SBRK_ERROR ((char *)-1)

struct stat;

// system calls
int fork(void);
int exit(int) __attribute__((noreturn));
int wait(int*);
int pipe(int*);
int write(int, const void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(const char*, char**);
int open(const char*, int);
int mknod(const char*, short, short);
int unlink(const char*);
int fstat(int fd, struct stat*);
int link(const char*, const char*);
int mkdir(const char*);
int chdir(const char*);
int dup(int);
int getpid(void);
void* sbrk(int, int);
int pause(int);
int uptime(void);
void* mmap(void*, uint64_t, int, int, int, uint64_t);
int munmap(void*, uint64_t);
int lseek(int fd, int64_t offset, int whence);
char* getcwd(char*, int);

// lib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
char *strcat(char *dst, const char *src);
int strcmp(const char*, const char*);
char* gets(char*, int max);
uint32_t strlen(const char*);
void* memset(void*, int, uint32_t);
int atoi(const char*);
int memcmp(const void *, const void *, uint32_t);
void *memcpy(void *, const void *, uint32_t);
void* usbrk(int);
void* usbrklazy(int);

void* malloc(uint32_t);
void free(void*);

void putc(int fd, char c);
void fprintf(int, const char*, ...) __attribute__ ((format (printf, 2, 3)));
void printf(const char*, ...) __attribute__ ((format (printf, 1, 2)));

#endif /* _LEN_USER_H_ */
