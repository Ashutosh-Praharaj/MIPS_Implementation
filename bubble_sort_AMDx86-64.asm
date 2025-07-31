	.text
	.file	"<string>"
	.globl	_ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE
	.p2align	4, 0x90
	.type	_ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE,@function
_ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rsi
	pushq	%rdi
	pushq	%rbp
	pushq	%rbx
	subq	$88, %rsp
	movq	224(%rsp), %r13
	movq	216(%rsp), %rsi
	movabsq	$NRT_incref, %rax
	movq	%rcx, %r12
	movq	%r8, %rcx
	movq	%r9, 72(%rsp)
	movq	%r8, 64(%rsp)
	callq	*%rax
	movq	%rsi, %r11
	xorl	%esi, %esi
	testq	%r11, %r11
	cmovgq	%r11, %rsi
	jle	.LBB0_156
	movl	%esi, %ecx
	andl	$3, %ecx
	leaq	-1(%r11), %r9
	leaq	-2(%r11), %r10
	leaq	-1(%rsi), %rax
	movq	%r12, 56(%rsp)
	movq	%rcx, 48(%rsp)
	cmpq	$3, %rax
	jae	.LBB0_180
	xorl	%r15d, %r15d
.LBB0_115:
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %r12
	movq	224(%rsp), %r13
	movq	216(%rsp), %r11
	je	.LBB0_156
	movq	208(%rsp), %rax
	movq	%r15, %r14
	notq	%r14
	xorl	%ebp, %ebp
	addq	%r11, %r14
	leaq	8(%rax), %r8
	leaq	64(%rax), %rdx
	jmp	.LBB0_117
	.p2align	4, 0x90
.LBB0_155:
	incq	%r15
	incq	%rbp
	decq	%r14
	cmpq	48(%rsp), %rbp
	je	.LBB0_156
.LBB0_117:
	movq	%r15, %rax
	notq	%rax
	addq	%r11, %rax
	testq	%rax, %rax
	jle	.LBB0_155
	movq	208(%rsp), %rcx
	movq	%r9, %r11
	movq	%r10, %rax
	subq	%r15, %r11
	subq	%r15, %rax
	movq	(%rcx), %rcx
	cmpq	$7, %rax
	jae	.LBB0_123
	xorl	%ebx, %ebx
	jmp	.LBB0_149
	.p2align	4, 0x90
.LBB0_123:
	movq	%r14, %rax
	andq	$-8, %rax
	xorl	%esi, %esi
	jmp	.LBB0_124
	.p2align	4, 0x90
.LBB0_147:
	movq	%rdi, -8(%rdx,%rsi,8)
	movq	%rcx, (%rdx,%rsi,8)
	movq	%rbx, %rsi
	cmpq	%rbx, %rax
	je	.LBB0_149
.LBB0_124:
	movq	-56(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jle	.LBB0_125
	movq	%rdi, -64(%rdx,%rsi,8)
	movq	%rcx, -56(%rdx,%rsi,8)
	movq	-48(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jg	.LBB0_129
.LBB0_128:
	movq	%rdi, %rcx
	movq	-40(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jg	.LBB0_132
.LBB0_131:
	movq	%rdi, %rcx
	movq	-32(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jg	.LBB0_135
.LBB0_134:
	movq	%rdi, %rcx
	movq	-24(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jg	.LBB0_138
.LBB0_137:
	movq	%rdi, %rcx
	movq	-16(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jg	.LBB0_141
.LBB0_140:
	movq	%rdi, %rcx
	movq	-8(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jg	.LBB0_144
.LBB0_143:
	movq	%rdi, %rcx
	movq	(%rdx,%rsi,8), %rdi
	leaq	8(%rsi), %rbx
	cmpq	%rdi, %rcx
	jg	.LBB0_147
	jmp	.LBB0_146
	.p2align	4, 0x90
.LBB0_125:
	movq	%rdi, %rcx
	movq	-48(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jle	.LBB0_128
.LBB0_129:
	movq	%rdi, -56(%rdx,%rsi,8)
	movq	%rcx, -48(%rdx,%rsi,8)
	movq	-40(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jle	.LBB0_131
.LBB0_132:
	movq	%rdi, -48(%rdx,%rsi,8)
	movq	%rcx, -40(%rdx,%rsi,8)
	movq	-32(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jle	.LBB0_134
.LBB0_135:
	movq	%rdi, -40(%rdx,%rsi,8)
	movq	%rcx, -32(%rdx,%rsi,8)
	movq	-24(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jle	.LBB0_137
.LBB0_138:
	movq	%rdi, -32(%rdx,%rsi,8)
	movq	%rcx, -24(%rdx,%rsi,8)
	movq	-16(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jle	.LBB0_140
.LBB0_141:
	movq	%rdi, -24(%rdx,%rsi,8)
	movq	%rcx, -16(%rdx,%rsi,8)
	movq	-8(%rdx,%rsi,8), %rdi
	cmpq	%rdi, %rcx
	jle	.LBB0_143
.LBB0_144:
	movq	%rdi, -16(%rdx,%rsi,8)
	movq	%rcx, -8(%rdx,%rsi,8)
	movq	(%rdx,%rsi,8), %rdi
	leaq	8(%rsi), %rbx
	cmpq	%rdi, %rcx
	jg	.LBB0_147
.LBB0_146:
	movq	%rdi, %rcx
	movq	%rbx, %rsi
	cmpq	%rbx, %rax
	jne	.LBB0_124
.LBB0_149:
	testb	$7, %r11b
	movq	216(%rsp), %r11
	je	.LBB0_155
	leaq	(%r8,%rbx,8), %rdi
	movl	%r14d, %eax
	andl	$7, %eax
	xorl	%esi, %esi
	jmp	.LBB0_151
	.p2align	4, 0x90
.LBB0_153:
	movq	%rbx, -8(%rdi,%rsi,8)
	movq	%rcx, (%rdi,%rsi,8)
	incq	%rsi
	cmpq	%rsi, %rax
	je	.LBB0_155
.LBB0_151:
	movq	(%rdi,%rsi,8), %rbx
	cmpq	%rbx, %rcx
	jg	.LBB0_153
	movq	%rbx, %rcx
	incq	%rsi
	cmpq	%rsi, %rax
	jne	.LBB0_151
	jmp	.LBB0_155
.LBB0_156:
	movq	64(%rsp), %rax
	movq	%rax, (%r12)
	movq	72(%rsp), %rax
	movq	%rax, 8(%r12)
	movq	192(%rsp), %rax
	movq	%rax, 16(%r12)
	movq	200(%rsp), %rax
	movq	%rax, 24(%r12)
	movq	208(%rsp), %rax
	movq	%rax, 32(%r12)
	movq	%r11, 40(%r12)
	movq	%r13, 48(%r12)
	xorl	%eax, %eax
	addq	$88, %rsp
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.LBB0_180:
	movq	208(%rsp), %rdx
	movabsq	$9223372036854775804, %rax
	leaq	-3(%r11), %r14
	leaq	-4(%r11), %r13
	xorl	%r15d, %r15d
	movq	%r10, %r8
	movq	%r9, %r11
	andq	%rax, %rsi
	movq	%rsi, 80(%rsp)
	leaq	8(%rdx), %rcx
	addq	$64, %rdx
	movq	%rcx, 40(%rsp)
	jmp	.LBB0_181
	.p2align	4, 0x90
.LBB0_114:
	movq	80(%rsp), %rsi
	addq	$-4, %r11
	addq	$-4, %r8
	addq	$-4, %r14
	addq	$-4, %r13
	cmpq	%rsi, %r15
	je	.LBB0_115
.LBB0_181:
	movq	216(%rsp), %rax
	movq	%r15, %rdi
	notq	%rdi
	movq	%r15, %r12
	addq	%rdi, %rax
	testq	%rax, %rax
	jle	.LBB0_9
	movq	208(%rsp), %rcx
	movq	%r9, %r15
	movq	%r10, %rax
	subq	%r12, %r15
	subq	%r12, %rax
	movq	(%rcx), %rbp
	cmpq	$7, %rax
	jae	.LBB0_120
	xorl	%ebx, %ebx
	jmp	.LBB0_3
	.p2align	4, 0x90
.LBB0_120:
	movq	%r11, %rax
	andq	$-8, %rax
	xorl	%ecx, %ecx
	jmp	.LBB0_121
	.p2align	4, 0x90
.LBB0_178:
	movq	%rsi, -8(%rdx,%rcx,8)
	movq	%rbp, (%rdx,%rcx,8)
	movq	%rbx, %rcx
	cmpq	%rbx, %rax
	je	.LBB0_3
.LBB0_121:
	movq	-56(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jle	.LBB0_122
	movq	%rbx, -64(%rdx,%rcx,8)
	movq	%rbp, -56(%rdx,%rcx,8)
	movq	-48(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jg	.LBB0_160
.LBB0_159:
	movq	%rbx, %rbp
	movq	-40(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jg	.LBB0_163
.LBB0_162:
	movq	%rbx, %rbp
	movq	-32(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jg	.LBB0_166
.LBB0_165:
	movq	%rbx, %rbp
	movq	-24(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jg	.LBB0_169
.LBB0_168:
	movq	%rbx, %rbp
	movq	-16(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jg	.LBB0_172
.LBB0_171:
	movq	%rbx, %rbp
	movq	-8(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jg	.LBB0_175
.LBB0_174:
	movq	%rbx, %rbp
	movq	(%rdx,%rcx,8), %rsi
	leaq	8(%rcx), %rbx
	cmpq	%rsi, %rbp
	jg	.LBB0_178
	jmp	.LBB0_177
	.p2align	4, 0x90
.LBB0_122:
	movq	%rbx, %rbp
	movq	-48(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jle	.LBB0_159
.LBB0_160:
	movq	%rbx, -56(%rdx,%rcx,8)
	movq	%rbp, -48(%rdx,%rcx,8)
	movq	-40(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jle	.LBB0_162
.LBB0_163:
	movq	%rbx, -48(%rdx,%rcx,8)
	movq	%rbp, -40(%rdx,%rcx,8)
	movq	-32(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jle	.LBB0_165
.LBB0_166:
	movq	%rbx, -40(%rdx,%rcx,8)
	movq	%rbp, -32(%rdx,%rcx,8)
	movq	-24(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jle	.LBB0_168
.LBB0_169:
	movq	%rbx, -32(%rdx,%rcx,8)
	movq	%rbp, -24(%rdx,%rcx,8)
	movq	-16(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jle	.LBB0_171
.LBB0_172:
	movq	%rbx, -24(%rdx,%rcx,8)
	movq	%rbp, -16(%rdx,%rcx,8)
	movq	-8(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rbp
	jle	.LBB0_174
.LBB0_175:
	movq	%rbx, -16(%rdx,%rcx,8)
	movq	%rbp, -8(%rdx,%rcx,8)
	movq	(%rdx,%rcx,8), %rsi
	leaq	8(%rcx), %rbx
	cmpq	%rsi, %rbp
	jg	.LBB0_178
.LBB0_177:
	movq	%rsi, %rbp
	movq	%rbx, %rcx
	cmpq	%rbx, %rax
	jne	.LBB0_121
.LBB0_3:
	testb	$7, %r15b
	je	.LBB0_9
	movq	40(%rsp), %rcx
	movl	%r11d, %eax
	andl	$7, %eax
	leaq	(%rcx,%rbx,8), %rcx
	xorl	%ebx, %ebx
	jmp	.LBB0_5
	.p2align	4, 0x90
.LBB0_7:
	movq	%rsi, -8(%rcx,%rbx,8)
	movq	%rbp, (%rcx,%rbx,8)
	incq	%rbx
	cmpq	%rbx, %rax
	je	.LBB0_9
.LBB0_5:
	movq	(%rcx,%rbx,8), %rsi
	cmpq	%rsi, %rbp
	jg	.LBB0_7
	movq	%rsi, %rbp
	incq	%rbx
	cmpq	%rbx, %rax
	jne	.LBB0_5
	.p2align	4, 0x90
.LBB0_9:
	movq	216(%rsp), %r15
	subq	%r12, %r15
	leaq	-2(%r15), %rax
	testq	%rax, %rax
	jle	.LBB0_44
	movq	208(%rsp), %rax
	leaq	(%r9,%rdi), %rbp
	addq	%r10, %rdi
	movq	(%rax), %rsi
	cmpq	$7, %rdi
	jae	.LBB0_12
	xorl	%edi, %edi
	jmp	.LBB0_38
	.p2align	4, 0x90
.LBB0_12:
	movq	%r8, %rax
	andq	$-8, %rax
	xorl	%ecx, %ecx
	jmp	.LBB0_13
	.p2align	4, 0x90
.LBB0_36:
	movq	%rbx, -8(%rdx,%rcx,8)
	movq	%rsi, (%rdx,%rcx,8)
	movq	%rdi, %rcx
	cmpq	%rdi, %rax
	je	.LBB0_38
.LBB0_13:
	movq	-56(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jle	.LBB0_14
	movq	%rdi, -64(%rdx,%rcx,8)
	movq	%rsi, -56(%rdx,%rcx,8)
	movq	-48(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jg	.LBB0_18
.LBB0_17:
	movq	%rdi, %rsi
	movq	-40(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jg	.LBB0_21
.LBB0_20:
	movq	%rdi, %rsi
	movq	-32(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jg	.LBB0_24
.LBB0_23:
	movq	%rdi, %rsi
	movq	-24(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jg	.LBB0_27
.LBB0_26:
	movq	%rdi, %rsi
	movq	-16(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jg	.LBB0_30
.LBB0_29:
	movq	%rdi, %rsi
	movq	-8(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jg	.LBB0_33
.LBB0_32:
	movq	%rdi, %rsi
	movq	(%rdx,%rcx,8), %rbx
	leaq	8(%rcx), %rdi
	cmpq	%rbx, %rsi
	jg	.LBB0_36
	jmp	.LBB0_35
	.p2align	4, 0x90
.LBB0_14:
	movq	%rdi, %rsi
	movq	-48(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jle	.LBB0_17
.LBB0_18:
	movq	%rdi, -56(%rdx,%rcx,8)
	movq	%rsi, -48(%rdx,%rcx,8)
	movq	-40(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jle	.LBB0_20
.LBB0_21:
	movq	%rdi, -48(%rdx,%rcx,8)
	movq	%rsi, -40(%rdx,%rcx,8)
	movq	-32(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jle	.LBB0_23
.LBB0_24:
	movq	%rdi, -40(%rdx,%rcx,8)
	movq	%rsi, -32(%rdx,%rcx,8)
	movq	-24(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jle	.LBB0_26
.LBB0_27:
	movq	%rdi, -32(%rdx,%rcx,8)
	movq	%rsi, -24(%rdx,%rcx,8)
	movq	-16(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jle	.LBB0_29
.LBB0_30:
	movq	%rdi, -24(%rdx,%rcx,8)
	movq	%rsi, -16(%rdx,%rcx,8)
	movq	-8(%rdx,%rcx,8), %rdi
	cmpq	%rdi, %rsi
	jle	.LBB0_32
.LBB0_33:
	movq	%rdi, -16(%rdx,%rcx,8)
	movq	%rsi, -8(%rdx,%rcx,8)
	movq	(%rdx,%rcx,8), %rbx
	leaq	8(%rcx), %rdi
	cmpq	%rbx, %rsi
	jg	.LBB0_36
.LBB0_35:
	movq	%rbx, %rsi
	movq	%rdi, %rcx
	cmpq	%rdi, %rax
	jne	.LBB0_13
.LBB0_38:
	testb	$7, %bpl
	je	.LBB0_44
	movq	40(%rsp), %rcx
	movl	%r8d, %eax
	andl	$7, %eax
	leaq	(%rcx,%rdi,8), %rcx
	xorl	%edi, %edi
	jmp	.LBB0_40
	.p2align	4, 0x90
.LBB0_42:
	movq	%rbx, -8(%rcx,%rdi,8)
	movq	%rsi, (%rcx,%rdi,8)
	incq	%rdi
	cmpq	%rdi, %rax
	je	.LBB0_44
.LBB0_40:
	movq	(%rcx,%rdi,8), %rbx
	cmpq	%rbx, %rsi
	jg	.LBB0_42
	movq	%rbx, %rsi
	incq	%rdi
	cmpq	%rdi, %rax
	jne	.LBB0_40
	.p2align	4, 0x90
.LBB0_44:
	addq	$-3, %r15
	testq	%r15, %r15
	jle	.LBB0_79
	movq	208(%rsp), %rcx
	movq	$-2, %rax
	subq	%r12, %rax
	leaq	(%r9,%rax), %rdi
	addq	%r10, %rax
	movq	(%rcx), %rsi
	cmpq	$7, %rax
	jae	.LBB0_47
	xorl	%ebx, %ebx
	jmp	.LBB0_73
	.p2align	4, 0x90
.LBB0_47:
	movq	%r14, %rax
	andq	$-8, %rax
	xorl	%ecx, %ecx
	jmp	.LBB0_48
	.p2align	4, 0x90
.LBB0_71:
	movq	%rbp, -8(%rdx,%rcx,8)
	movq	%rsi, (%rdx,%rcx,8)
	movq	%rbx, %rcx
	cmpq	%rbx, %rax
	je	.LBB0_73
.LBB0_48:
	movq	-56(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jle	.LBB0_49
	movq	%rbx, -64(%rdx,%rcx,8)
	movq	%rsi, -56(%rdx,%rcx,8)
	movq	-48(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jg	.LBB0_53
.LBB0_52:
	movq	%rbx, %rsi
	movq	-40(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jg	.LBB0_56
.LBB0_55:
	movq	%rbx, %rsi
	movq	-32(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jg	.LBB0_59
.LBB0_58:
	movq	%rbx, %rsi
	movq	-24(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jg	.LBB0_62
.LBB0_61:
	movq	%rbx, %rsi
	movq	-16(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jg	.LBB0_65
.LBB0_64:
	movq	%rbx, %rsi
	movq	-8(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jg	.LBB0_68
.LBB0_67:
	movq	%rbx, %rsi
	movq	(%rdx,%rcx,8), %rbp
	leaq	8(%rcx), %rbx
	cmpq	%rbp, %rsi
	jg	.LBB0_71
	jmp	.LBB0_70
	.p2align	4, 0x90
.LBB0_49:
	movq	%rbx, %rsi
	movq	-48(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jle	.LBB0_52
.LBB0_53:
	movq	%rbx, -56(%rdx,%rcx,8)
	movq	%rsi, -48(%rdx,%rcx,8)
	movq	-40(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jle	.LBB0_55
.LBB0_56:
	movq	%rbx, -48(%rdx,%rcx,8)
	movq	%rsi, -40(%rdx,%rcx,8)
	movq	-32(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jle	.LBB0_58
.LBB0_59:
	movq	%rbx, -40(%rdx,%rcx,8)
	movq	%rsi, -32(%rdx,%rcx,8)
	movq	-24(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jle	.LBB0_61
.LBB0_62:
	movq	%rbx, -32(%rdx,%rcx,8)
	movq	%rsi, -24(%rdx,%rcx,8)
	movq	-16(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jle	.LBB0_64
.LBB0_65:
	movq	%rbx, -24(%rdx,%rcx,8)
	movq	%rsi, -16(%rdx,%rcx,8)
	movq	-8(%rdx,%rcx,8), %rbx
	cmpq	%rbx, %rsi
	jle	.LBB0_67
.LBB0_68:
	movq	%rbx, -16(%rdx,%rcx,8)
	movq	%rsi, -8(%rdx,%rcx,8)
	movq	(%rdx,%rcx,8), %rbp
	leaq	8(%rcx), %rbx
	cmpq	%rbp, %rsi
	jg	.LBB0_71
.LBB0_70:
	movq	%rbp, %rsi
	movq	%rbx, %rcx
	cmpq	%rbx, %rax
	jne	.LBB0_48
.LBB0_73:
	testb	$7, %dil
	je	.LBB0_79
	movq	40(%rsp), %rcx
	movl	%r14d, %eax
	andl	$7, %eax
	xorl	%edi, %edi
	leaq	(%rcx,%rbx,8), %rcx
	jmp	.LBB0_75
	.p2align	4, 0x90
.LBB0_77:
	movq	%rbx, -8(%rcx,%rdi,8)
	movq	%rsi, (%rcx,%rdi,8)
	incq	%rdi
	cmpq	%rdi, %rax
	je	.LBB0_79
.LBB0_75:
	movq	(%rcx,%rdi,8), %rbx
	cmpq	%rbx, %rsi
	jg	.LBB0_77
	movq	%rbx, %rsi
	incq	%rdi
	cmpq	%rdi, %rax
	jne	.LBB0_75
	.p2align	4, 0x90
.LBB0_79:
	movq	%r12, %rax
	xorq	$-4, %rax
	addq	216(%rsp), %rax
	leaq	4(%r12), %r15
	testq	%rax, %rax
	jle	.LBB0_114
	movq	208(%rsp), %rcx
	movq	$-3, %rax
	subq	%r12, %rax
	leaq	(%r9,%rax), %rbp
	addq	%r10, %rax
	movq	(%rcx), %rsi
	cmpq	$7, %rax
	jae	.LBB0_82
	xorl	%ebx, %ebx
	jmp	.LBB0_108
	.p2align	4, 0x90
.LBB0_82:
	movq	%r13, %rax
	andq	$-8, %rax
	xorl	%edi, %edi
	jmp	.LBB0_83
	.p2align	4, 0x90
.LBB0_106:
	movq	%rcx, -8(%rdx,%rdi,8)
	movq	%rsi, (%rdx,%rdi,8)
	movq	%rbx, %rdi
	cmpq	%rbx, %rax
	je	.LBB0_108
.LBB0_83:
	movq	-56(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jle	.LBB0_84
	movq	%rcx, -64(%rdx,%rdi,8)
	movq	%rsi, -56(%rdx,%rdi,8)
	movq	-48(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jg	.LBB0_88
.LBB0_87:
	movq	%rcx, %rsi
	movq	-40(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jg	.LBB0_91
.LBB0_90:
	movq	%rcx, %rsi
	movq	-32(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jg	.LBB0_94
.LBB0_93:
	movq	%rcx, %rsi
	movq	-24(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jg	.LBB0_97
.LBB0_96:
	movq	%rcx, %rsi
	movq	-16(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jg	.LBB0_100
.LBB0_99:
	movq	%rcx, %rsi
	movq	-8(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jg	.LBB0_103
.LBB0_102:
	movq	%rcx, %rsi
	movq	(%rdx,%rdi,8), %rcx
	leaq	8(%rdi), %rbx
	cmpq	%rcx, %rsi
	jg	.LBB0_106
	jmp	.LBB0_105
	.p2align	4, 0x90
.LBB0_84:
	movq	%rcx, %rsi
	movq	-48(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jle	.LBB0_87
.LBB0_88:
	movq	%rcx, -56(%rdx,%rdi,8)
	movq	%rsi, -48(%rdx,%rdi,8)
	movq	-40(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jle	.LBB0_90
.LBB0_91:
	movq	%rcx, -48(%rdx,%rdi,8)
	movq	%rsi, -40(%rdx,%rdi,8)
	movq	-32(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jle	.LBB0_93
.LBB0_94:
	movq	%rcx, -40(%rdx,%rdi,8)
	movq	%rsi, -32(%rdx,%rdi,8)
	movq	-24(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jle	.LBB0_96
.LBB0_97:
	movq	%rcx, -32(%rdx,%rdi,8)
	movq	%rsi, -24(%rdx,%rdi,8)
	movq	-16(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jle	.LBB0_99
.LBB0_100:
	movq	%rcx, -24(%rdx,%rdi,8)
	movq	%rsi, -16(%rdx,%rdi,8)
	movq	-8(%rdx,%rdi,8), %rcx
	cmpq	%rcx, %rsi
	jle	.LBB0_102
.LBB0_103:
	movq	%rcx, -16(%rdx,%rdi,8)
	movq	%rsi, -8(%rdx,%rdi,8)
	movq	(%rdx,%rdi,8), %rcx
	leaq	8(%rdi), %rbx
	cmpq	%rcx, %rsi
	jg	.LBB0_106
.LBB0_105:
	movq	%rcx, %rsi
	movq	%rbx, %rdi
	cmpq	%rbx, %rax
	jne	.LBB0_83
.LBB0_108:
	testb	$7, %bpl
	je	.LBB0_114
	movq	40(%rsp), %rcx
	movl	%r13d, %eax
	andl	$7, %eax
	xorl	%edi, %edi
	leaq	(%rcx,%rbx,8), %rcx
	jmp	.LBB0_110
	.p2align	4, 0x90
.LBB0_112:
	movq	%rbx, -8(%rcx,%rdi,8)
	movq	%rsi, (%rcx,%rdi,8)
	incq	%rdi
	cmpq	%rdi, %rax
	je	.LBB0_114
.LBB0_110:
	movq	(%rcx,%rdi,8), %rbx
	cmpq	%rbx, %rsi
	jg	.LBB0_112
	movq	%rbx, %rsi
	incq	%rdi
	cmpq	%rdi, %rax
	jne	.LBB0_110
	jmp	.LBB0_114
.Lfunc_end0:
	.size	_ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE, .Lfunc_end0-_ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE

	.globl	_ZN7cpython8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE
	.p2align	4, 0x90
	.type	_ZN7cpython8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE,@function
_ZN7cpython8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rsi
	pushq	%rdi
	pushq	%rbx
	andq	$-32, %rsp
	subq	$288, %rsp
	.cfi_offset %rbx, -72
	.cfi_offset %rdi, -64
	.cfi_offset %rsi, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	leaq	88(%rsp), %rax
	movq	%rdx, %rcx
	movabsq	$.const.bubble_sort, %rdx
	movl	$1, %r8d
	movl	$1, %r9d
	movq	%rax, 32(%rsp)
	movabsq	$PyArg_UnpackTuple, %rax
	callq	*%rax
	testl	%eax, %eax
	je	.LBB1_1
	movabsq	$_ZN08NumbaEnv8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE, %rax
	movq	(%rax), %rbx
	testq	%rbx, %rbx
	je	.LBB1_4
	movq	88(%rsp), %rcx
	movabsq	$NRT_adapt_ndarray_from_python, %rax
	leaq	160(%rsp), %rdx
	vxorps	%xmm0, %xmm0, %xmm0
	vmovaps	%ymm0, 160(%rsp)
	vmovups	%ymm0, 184(%rsp)
	vzeroupper
	callq	*%rax
	testl	%eax, %eax
	jne	.LBB1_8
	cmpq	$8, 184(%rsp)
	jne	.LBB1_8
	vmovaps	192(%rsp), %xmm0
	movq	176(%rsp), %rax
	movq	208(%rsp), %rcx
	movq	160(%rsp), %rdi
	movq	168(%rsp), %r9
	vxorps	%xmm1, %xmm1, %xmm1
	vmovaps	%ymm1, 96(%rsp)
	vmovups	%ymm1, 120(%rsp)
	movq	$8, 40(%rsp)
	movq	%rcx, 64(%rsp)
	movq	%rax, 32(%rsp)
	movabsq	$_ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE, %rax
	leaq	96(%rsp), %rcx
	movq	%rdi, %r8
	vmovups	%xmm0, 48(%rsp)
	vzeroupper
	callq	*%rax
	movq	136(%rsp), %rax
	movq	144(%rsp), %rcx
	movq	96(%rsp), %rsi
	movq	104(%rsp), %r15
	movq	112(%rsp), %r12
	movq	120(%rsp), %r13
	movq	128(%rsp), %r14
	movq	%rax, 80(%rsp)
	movabsq	$NRT_decref, %rax
	movq	%rcx, 72(%rsp)
	movq	%rdi, %rcx
	callq	*%rax
	movq	24(%rbx), %rcx
	testq	%rcx, %rcx
	je	.LBB1_11
	movabsq	$PyList_GetItem, %rax
	xorl	%edx, %edx
	callq	*%rax
	movq	%rax, %rdi
	jmp	.LBB1_12
.LBB1_11:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.`env.consts` is NULL in `read_const`", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	xorl	%edi, %edi
.LBB1_12:
	movabsq	$.const.pickledata.140723367609584, %rcx
	movabsq	$.const.pickledata.140723367609584.sha1, %r8
	movabsq	$numba_unpickle, %rax
	movl	$32, %edx
	callq	*%rax
	movq	80(%rsp), %rcx
	movq	72(%rsp), %rdx
	movq	%rsi, 224(%rsp)
	movq	%r15, 232(%rsp)
	movq	%r12, 240(%rsp)
	movq	%r13, 248(%rsp)
	movq	%r14, 256(%rsp)
	movabsq	$NRT_adapt_ndarray_to_python_acqref, %rbx
	movl	$1, %r8d
	movl	$1, %r9d
	movq	%rdi, 32(%rsp)
	movq	%rcx, 264(%rsp)
	leaq	224(%rsp), %rcx
	movq	%rdx, 272(%rsp)
	movq	%rax, %rdx
	callq	*%rbx
	movq	%rsi, %rcx
	movabsq	$NRT_decref, %rsi
	movq	%rax, %rdi
	callq	*%rsi
.LBB1_2:
	movq	%rdi, %rax
	leaq	-56(%rbp), %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB1_4:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.missing Environment: _ZN08NumbaEnv8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE", %rdx
	jmp	.LBB1_5
.LBB1_8:
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox array from PyObject into native value.  The object maybe of a different type", %rdx
.LBB1_5:
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
.LBB1_1:
	xorl	%edi, %edi
	jmp	.LBB1_2
.Lfunc_end1:
	.size	_ZN7cpython8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE, .Lfunc_end1-_ZN7cpython8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE
	.cfi_endproc

	.globl	cfunc._ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE
	.p2align	4, 0x90
	.type	cfunc._ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE,@function
cfunc._ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rsi
	andq	$-32, %rsp
	subq	$192, %rsp
	vmovups	48(%rbp), %ymm0
	movq	%rcx, %rsi
	movabsq	$_ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE, %r10
	leaq	96(%rsp), %rcx
	movq	%r8, %rax
	vxorps	%xmm1, %xmm1, %xmm1
	vmovups	%ymm1, 120(%rsp)
	movq	%r9, 32(%rsp)
	vmovaps	%ymm1, 96(%rsp)
	movq	%rdx, %r8
	movq	%rax, %r9
	vmovups	%ymm0, 40(%rsp)
	vzeroupper
	callq	*%r10
	vmovups	104(%rsp), %xmm0
	vmovups	120(%rsp), %ymm1
	movq	96(%rsp), %rax
	movq	%rax, (%rsi)
	movq	%rsi, %rax
	vmovups	%xmm0, 8(%rsi)
	vmovups	%ymm1, 24(%rsi)
	leaq	-8(%rbp), %rsp
	popq	%rsi
	popq	%rbp
	vzeroupper
	retq
.Lfunc_end2:
	.size	cfunc._ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE, .Lfunc_end2-cfunc._ZN8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE

	.weak	NRT_incref
	.p2align	4, 0x90
	.type	NRT_incref,@function
NRT_incref:
	testq	%rcx, %rcx
	je	.LBB3_2
	lock		incq	(%rcx)
.LBB3_2:
	retq
.Lfunc_end3:
	.size	NRT_incref, .Lfunc_end3-NRT_incref

	.weak	NRT_decref
	.p2align	4, 0x90
	.type	NRT_decref,@function
NRT_decref:
	.cfi_startproc
	testq	%rcx, %rcx
	je	.LBB4_2
	#MEMBARRIER
	lock		decq	(%rcx)
	je	.LBB4_3
.LBB4_2:
	retq
.LBB4_3:
	movabsq	$NRT_MemInfo_call_dtor, %rax
	#MEMBARRIER
	rex64 jmpq	*%rax
.Lfunc_end4:
	.size	NRT_decref, .Lfunc_end4-NRT_decref
	.cfi_endproc

	.type	.const.bubble_sort,@object
	.section	.rodata,"a",@progbits
.const.bubble_sort:
	.asciz	"bubble_sort"
	.size	.const.bubble_sort, 12

	.type	_ZN08NumbaEnv8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE,@object
	.comm	_ZN08NumbaEnv8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE,8,8
	.type	".const.missing Environment: _ZN08NumbaEnv8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE",@object
	.p2align	4
".const.missing Environment: _ZN08NumbaEnv8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE":
	.asciz	"missing Environment: _ZN08NumbaEnv8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE"
	.size	".const.missing Environment: _ZN08NumbaEnv8__main__11bubble_sortB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dE5ArrayIxLi1E1C7mutable7alignedE", 134

	.type	".const.can't unbox array from PyObject into native value.  The object maybe of a different type",@object
	.p2align	4
".const.can't unbox array from PyObject into native value.  The object maybe of a different type":
	.asciz	"can't unbox array from PyObject into native value.  The object maybe of a different type"
	.size	".const.can't unbox array from PyObject into native value.  The object maybe of a different type", 89

	.type	".const.`env.consts` is NULL in `read_const`",@object
	.p2align	4
".const.`env.consts` is NULL in `read_const`":
	.asciz	"`env.consts` is NULL in `read_const`"
	.size	".const.`env.consts` is NULL in `read_const`", 37

	.type	.const.pickledata.140723367609584,@object
	.p2align	4
.const.pickledata.140723367609584:
	.ascii	"\200\004\225\025\000\000\000\000\000\000\000\214\005numpy\224\214\007ndarray\224\223\224."
	.size	.const.pickledata.140723367609584, 32

	.type	.const.pickledata.140723367609584.sha1,@object
	.p2align	4
.const.pickledata.140723367609584.sha1:
	.ascii	"\337\274\375\323\237\313&\364\320\306\200\225D\207\270\300\265;\270\243"
	.size	.const.pickledata.140723367609584.sha1, 20

	.section	".note.GNU-stack","",@progbits

