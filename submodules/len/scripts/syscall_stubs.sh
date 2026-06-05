#!/bin/sh

echo "# AUTO GENERATED. DO NOT EDIT"
echo "#include \"kernel/syscall.h\""

entry() {
    name=$1

    echo "	.global $name"
    echo "$name:"
    echo "	li a7, SYS_$name"
    echo "	ecall"
    echo "	ret"
}

entry "fork"
entry "exit"
entry "wait"
entry "pipe"
entry "read"
entry "write"
entry "close"
entry "kill"
entry "exec"
entry "open"
entry "mknod"
entry "unlink"
entry "fstat"
entry "link"
entry "mkdir"
entry "chdir"
entry "dup"
entry "getpid"
entry "sbrk"
entry "pause"
entry "uptime"
entry "mmap"
entry "munmap"
entry "lseek"
entry "getcwd"
