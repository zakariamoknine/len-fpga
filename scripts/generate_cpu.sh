#!/bin/bash

cd "$(dirname "$0")/../external/VexiiRiscv" || exit 1

#
# CONFIG: 64-BIT LINUX
#
sbt "Test/runMain vexiiriscv.Generate
	--xlen 64 \
	--reset-vector 00000000 \
	--with-mul --with-div --with-rva --with-rvc \
	--with-supervisor --with-user \
	--allow-bypass-from=0 --performance-counters=0 \
	--lsu-l1 --lsu-axi4 --lsu-l1-axi4 --lsu-l1-ways=4 --lsu-l1-mem-data-width-min=64 --with-lsu-bypass \
	--fetch-l1 --fetch-axi4 --fetch-l1-ways=4 --fetch-l1-mem-data-width-min=64 \
	--with-btb --with-ras --with-gshare \
	--region base=00000000,size=1000000,main=1,exe=1 \
	--region base=40000000,size=1000000,main=0,exe=0 \
	--region base=44A00000,size=1000000,main=0,exe=0 \
	--region base=80000000,size=8000000,main=1,exe=1"

#
# CONFIG: 32-BIT LINUX
#
#sbt "Test/runMain vexiiriscv.Generate
#	--xlen 32 \
#	--reset-vector 00000000 \
#	--with-mul --with-div --with-rva \
#	--with-supervisor --with-user \
#	--allow-bypass-from=0 --performance-counters=0 \
#	--lsu-l1 --lsu-axi4 --lsu-l1-axi4 --lsu-l1-ways=4 --with-lsu-bypass \
#	--fetch-l1 --fetch-axi4 --fetch-l1-ways=4 \
#	--with-btb --with-ras --with-gshare \
#	--region base=00000000,size=1000000,main=1,exe=1 \
#	--region base=80000000,size=8000000,main=1,exe=1 \
#	--region base=40000000,size=1000000,main=0,exe=0 \
#	--region base=44A00000,size=1000000,main=0,exe=0"

#
# CONFIG: 64-BIT SIMPLE
#
#sbt "Test/runMain vexiiriscv.Generate
#	--xlen 64 \
#	--reset-vector 00000000 \
#	--with-mul --with-div --without-mmu \
#	--allow-bypass-from=0 --performance-counters=0 \
#	--lsu-l1 --lsu-axi4 --lsu-l1-axi4 --lsu-l1-ways=4 --lsu-l1-mem-data-width-min=64 --with-lsu-bypass \
#	--fetch-l1 --fetch-axi4 --fetch-l1-ways=4 --fetch-l1-mem-data-width-min=64 \
#	--region base=00000000,size=1000000,main=1,exe=1 \
#	--region base=80000000,size=8000000,main=1,exe=1 \
#	--region base=40000000,size=1000000,main=0,exe=0 \
#	--region base=44A00000,size=1000000,main=0,exe=0"

#
# CONFIG: 32-BIT SIMPLE
#
#sbt "Test/runMain vexiiriscv.Generate
#	--xlen 32 \
#	--reset-vector 00000000 \
#	--with-mul --with-div --without-mmu \
#	--allow-bypass-from=0 --performance-counters=0 \
#	--lsu-l1 --lsu-axi4 --lsu-l1-axi4 --lsu-l1-ways=4 --with-lsu-bypass \
#	--fetch-l1 --fetch-axi4 --fetch-l1-ways=4 \
#	--region base=00000000,size=1000000,main=1,exe=1 \
#	--region base=80000000,size=8000000,main=1,exe=1 \
#	--region base=40000000,size=1000000,main=0,exe=0 \
#	--region base=44A00000,size=1000000,main=0,exe=0"

