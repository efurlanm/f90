# Fortran and assembly

Reference: https://gcc.gnu.org/wiki/GFortranHacking


```python
%%writefile hello.f90
program hello
          print *, "Hello World!"
end program
```

    Writing hello.f90



```python
! gfortran hello.f90
```


```python
! ./a.out
```

     Hello World!



```python
! gfortran -S hello.f90
```


```python
! cat hello.s
```

    	.file	"hello.f90"
    	.text
    	.section	.rodata
    .LC0:
    	.string	"hello.f90"
    .LC1:
    	.ascii	"Hello World!"
    	.text
    	.type	MAIN__, @function
    MAIN__:
    .LFB0:
    	.cfi_startproc
    	pushq	%rbp
    	.cfi_def_cfa_offset 16
    	.cfi_offset 6, -16
    	movq	%rsp, %rbp
    	.cfi_def_cfa_register 6
    	subq	$528, %rsp
    	movq	$.LC0, -520(%rbp)
    	movl	$2, -512(%rbp)
    	movl	$128, -528(%rbp)
    	movl	$6, -524(%rbp)
    	leaq	-528(%rbp), %rax
    	movq	%rax, %rdi
    	call	_gfortran_st_write
    	leaq	-528(%rbp), %rax
    	movl	$12, %edx
    	movl	$.LC1, %esi
    	movq	%rax, %rdi
    	call	_gfortran_transfer_character_write
    	leaq	-528(%rbp), %rax
    	movq	%rax, %rdi
    	call	_gfortran_st_write_done
    	nop
    	leave
    	.cfi_def_cfa 7, 8
    	ret
    	.cfi_endproc
    .LFE0:
    	.size	MAIN__, .-MAIN__
    	.globl	main
    	.type	main, @function
    main:
    .LFB1:
    	.cfi_startproc
    	pushq	%rbp
    	.cfi_def_cfa_offset 16
    	.cfi_offset 6, -16
    	movq	%rsp, %rbp
    	.cfi_def_cfa_register 6
    	subq	$16, %rsp
    	movl	%edi, -4(%rbp)
    	movq	%rsi, -16(%rbp)
    	movq	-16(%rbp), %rdx
    	movl	-4(%rbp), %eax
    	movq	%rdx, %rsi
    	movl	%eax, %edi
    	call	_gfortran_set_args
    	movl	$options.1.0, %esi
    	movl	$7, %edi
    	call	_gfortran_set_options
    	call	MAIN__
    	movl	$0, %eax
    	leave
    	.cfi_def_cfa 7, 8
    	ret
    	.cfi_endproc
    .LFE1:
    	.size	main, .-main
    	.section	.rodata
    	.align 16
    	.type	options.1.0, @object
    	.size	options.1.0, 28
    options.1.0:
    	.long	2116
    	.long	4095
    	.long	0
    	.long	1
    	.long	1
    	.long	0
    	.long	31
    	.ident	"GCC: (GNU) 10.2.1 20201125 (Red Hat 10.2.1-9)"
    	.section	.note.GNU-stack,"",@progbits



```python
! gfortran -S -fverbose-asm -fdump-tree-original-uid -fdump-tree-optimized-uid hello.f90
```


```python
! cat hello.s
```

    	.file	"hello.f90"
    # GNU Fortran2008 (GCC) version 10.2.1 20201125 (Red Hat 10.2.1-9) (x86_64-redhat-linux)
    #	compiled by GNU C version 10.2.1 20201125 (Red Hat 10.2.1-9), GMP version 6.2.0, MPFR version 4.1.0, MPC version 1.1.0, isl version none
    # warning: MPFR header version 4.1.0 differs from library version 4.1.0-p9.
    # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
    # options passed:  hello.f90 -mtune=generic -march=x86-64 -fverbose-asm
    # -fdump-tree-original-uid -fdump-tree-optimized-uid
    # -fintrinsic-modules-path /usr/lib/gcc/x86_64-redhat-linux/10/finclude
    # -fpre-include=/usr/include/finclude/math-vector-fortran.h
    # options enabled:  -faggressive-loop-optimizations -fallocation-dce
    # -fasynchronous-unwind-tables -fauto-inc-dec -fdelete-null-pointer-checks
    # -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-symbols
    # -feliminate-unused-debug-types -ffp-int-builtin-inexact -ffunction-cse
    # -fgcse-lm -fgnu-unique -fident -finline-atomics -fipa-stack-alignment
    # -fira-hoist-pressure -fira-share-save-slots -fira-share-spill-slots
    # -fivopts -fkeep-static-consts -fleading-underscore -flifetime-dse
    # -fmerge-debug-strings -fpeephole -fplt -fprefetch-loop-arrays
    # -freg-struct-return -fsched-critical-path-heuristic
    # -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
    # -fsched-last-insn-heuristic -fsched-rank-heuristic -fsched-spec
    # -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-fusion
    # -fsemantic-interposition -fshow-column -fshrink-wrap-separate
    # -fsigned-zeros -fsplit-ivs-in-unroller -fssa-backprop -fstdarg-opt
    # -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math -ftree-cselim
    # -ftree-forwprop -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
    # -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop
    # -ftree-reassoc -ftree-scev-cprop -funit-at-a-time -funwind-tables
    # -fverbose-asm -fzero-initialized-in-bss -m128bit-long-double -m64 -m80387
    # -malign-stringops -mavx256-split-unaligned-load
    # -mavx256-split-unaligned-store -mfancy-math-387 -mfp-ret-in-387 -mfxsr
    # -mglibc -mieee-fp -mlong-double-80 -mmmx -mno-sse4 -mpush-args -mred-zone
    # -msse -msse2 -mstv -mtls-direct-seg-refs -mvzeroupper
    
    	.text
    	.section	.rodata
    .LC0:
    	.string	"hello.f90"
    .LC1:
    	.ascii	"Hello World!"
    	.text
    	.type	MAIN__, @function
    MAIN__:
    .LFB0:
    	.cfi_startproc
    	pushq	%rbp	#
    	.cfi_def_cfa_offset 16
    	.cfi_offset 6, -16
    	movq	%rsp, %rbp	#,
    	.cfi_def_cfa_register 6
    	subq	$528, %rsp	#,
    # hello.f90:2:           print *, "Hello World!"
    	movq	$.LC0, -520(%rbp)	#, dt_parm.0.common.filename
    	movl	$2, -512(%rbp)	#, dt_parm.0.common.line
    	movl	$128, -528(%rbp)	#, dt_parm.0.common.flags
    	movl	$6, -524(%rbp)	#, dt_parm.0.common.unit
    	leaq	-528(%rbp), %rax	#, tmp82
    	movq	%rax, %rdi	# tmp82,
    	call	_gfortran_st_write	#
    	leaq	-528(%rbp), %rax	#, tmp83
    	movl	$12, %edx	#,
    	movl	$.LC1, %esi	#,
    	movq	%rax, %rdi	# tmp83,
    	call	_gfortran_transfer_character_write	#
    	leaq	-528(%rbp), %rax	#, tmp84
    	movq	%rax, %rdi	# tmp84,
    	call	_gfortran_st_write_done	#
    # hello.f90:3: end program
    	nop	
    	leave	
    	.cfi_def_cfa 7, 8
    	ret	
    	.cfi_endproc
    .LFE0:
    	.size	MAIN__, .-MAIN__
    	.globl	main
    	.type	main, @function
    main:
    .LFB1:
    	.cfi_startproc
    	pushq	%rbp	#
    	.cfi_def_cfa_offset 16
    	.cfi_offset 6, -16
    	movq	%rsp, %rbp	#,
    	.cfi_def_cfa_register 6
    	subq	$16, %rsp	#,
    	movl	%edi, -4(%rbp)	# argc, argc
    	movq	%rsi, -16(%rbp)	# argv, argv
    # hello.f90:3: end program
    	movq	-16(%rbp), %rdx	# argv, tmp84
    	movl	-4(%rbp), %eax	# argc, tmp85
    	movq	%rdx, %rsi	# tmp84,
    	movl	%eax, %edi	# tmp85,
    	call	_gfortran_set_args	#
    	movl	$options.1.0, %esi	#,
    	movl	$7, %edi	#,
    	call	_gfortran_set_options	#
    	call	MAIN__	#
    	movl	$0, %eax	#, _7
    	leave	
    	.cfi_def_cfa 7, 8
    	ret	
    	.cfi_endproc
    .LFE1:
    	.size	main, .-main
    	.section	.rodata
    	.align 16
    	.type	options.1.0, @object
    	.size	options.1.0, 28
    options.1.0:
    	.long	2116
    	.long	4095
    	.long	0
    	.long	1
    	.long	1
    	.long	0
    	.long	31
    	.ident	"GCC: (GNU) 10.2.1 20201125 (Red Hat 10.2.1-9)"
    	.section	.note.GNU-stack,"",@progbits



```python

```
