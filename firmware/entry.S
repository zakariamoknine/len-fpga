.section .text.boot

.global _entry
_entry:
	la      sp, stack_top
	
	call    start

.section .data

.p2align 4
.space 4096
stack_top:
