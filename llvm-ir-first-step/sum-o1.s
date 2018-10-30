	.text
	.def	 @feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 1
	.intel_syntax noprefix
	.def	 _sum;
	.scl	2;
	.type	32;
	.endef
	.globl	_sum                    # -- Begin function sum
	.p2align	4, 0x90
_sum:                                   # @sum
# %bb.0:                                # %entry
	mov	eax, dword ptr [esp + 8]
	add	eax, dword ptr [esp + 4]
	ret
                                        # -- End function
	.def	 _min;
	.scl	2;
	.type	32;
	.endef
	.globl	_min                    # -- Begin function min
	.p2align	4, 0x90
_min:                                   # @min
# %bb.0:                                # %entry
	mov	eax, dword ptr [esp + 8]
	mov	ecx, dword ptr [esp + 4]
	cmp	ecx, eax
	cmovle	eax, ecx
	ret
                                        # -- End function

