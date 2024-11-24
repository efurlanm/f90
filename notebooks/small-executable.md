# Fortran small executable

*Last edited: 2023-12-10*

Some exercises to try to better understand the creation of executables by a compiler. There is also a [Notebook that uses the assembly language](https://efurlanm.github.io/ldi/assembly/small-assembly/).


```python
! gfortran --version
```

    GNU Fortran (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
    Copyright (C) 2021 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    



```python
%%writefile tiny.f95
program tiny01
    call exit(42)
end
```

    Overwriting tiny.f95



```python
! wc -c tiny.f95
```

    52 tiny01.f95



```python
! gfortran tiny.f95 ; ./a.out ; echo $?
```

echo $? will return the exit status of last command


```python
! wc -c a.out
```

    16080 a.out



```python
%%writefile tiny.c
int main(void) {
    return 42;
}
```

    Overwriting tiny.c



```python
! gcc tiny.c ; ./a.out ; echo $?
```

    42



```python
! wc -c a.out
```

    15776 a.out


-s = strip


```python
! gfortran -s tiny.f95 ; wc -c a.out
```

    14400 a.out



```python
! gcc -s tiny.c ; wc -c a.out
```

    14328 a.out


-Os = optimize for size


```python
! gfortran -s -Os tiny.f95 ; wc -c a.out
```

    14400 a.out



```python
! gcc -s -Os tiny.c ; wc -c a.out
```

    14328 a.out


The linker option -nostdlib is used to link a program intended to run standalone. -nostdlib implies the individual options -nodefaultlibs and -nostartfiles


```python
! gfortran -s -nostdlib tiny.f95
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001040
    /usr/bin/ld: /tmp/ccGEs0Cl.o: in function `MAIN__':
    tiny01.f95:(.text+0x14): undefined reference to `_gfortran_exit_i4'
    /usr/bin/ld: /tmp/ccGEs0Cl.o: in function `main':
    tiny01.f95:(.text+0x34): undefined reference to `_gfortran_set_args'
    /usr/bin/ld: tiny01.f95:(.text+0x48): undefined reference to `_gfortran_set_options'
    collect2: error: ld returned 1 exit status
    wc: a.out: No such file or directory



```python
! gcc -s -nostdlib tiny.c ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001000
    13296 a.out



```python
! gcc -s -nostdlib tiny.c ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001000
    13296 a.out



```python
! gcc -s -nostdlib -lgcc tiny.c ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001000
    13296 a.out


The option -nostartfiles instructs the linker to not use the standard system startup functions nor link the code containing those functions.


```python
! gcc -s -nostartfiles tiny.c ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001000
    13296 a.out



```python
! gcc -s -nostartfiles -nostdlib -nodefaultlibs tiny.c ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001000
    13296 a.out



```python
! strip --strip-all a.out ; wc -c a.out
```

    13296 a.out



```python
! strip --strip-all --remove-section=.comment --remove-section=.note* a.out ; wc -c a.out
```

    13016 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000150:
    HAS_SYMS, DYNAMIC, D_PAGED
    start address 0x0000000000001000
    
    Program Header:
        PHDR off    0x0000000000000040 vaddr 0x0000000000000040 paddr 0x0000000000000040 align 2**3
             filesz 0x00000000000002a0 memsz 0x00000000000002a0 flags r--
      INTERP off    0x0000000000000318 vaddr 0x0000000000000318 paddr 0x0000000000000318 align 2**0
             filesz 0x000000000000001c memsz 0x000000000000001c flags r--
        LOAD off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**12
             filesz 0x00000000000003b9 memsz 0x00000000000003b9 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000001000 paddr 0x0000000000001000 align 2**12
             filesz 0x000000000000000f memsz 0x000000000000000f flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**12
             filesz 0x0000000000000050 memsz 0x0000000000000050 flags r--
        LOAD off    0x0000000000002f20 vaddr 0x0000000000003f20 paddr 0x0000000000003f20 align 2**12
             filesz 0x00000000000000e0 memsz 0x00000000000000e0 flags rw-
     DYNAMIC off    0x0000000000002f20 vaddr 0x0000000000003f20 paddr 0x0000000000003f20 align 2**3
             filesz 0x00000000000000e0 memsz 0x00000000000000e0 flags rw-
        NOTE off    0x0000000000000000 vaddr 0x0000000000000338 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
        NOTE off    0x0000000000000000 vaddr 0x0000000000000358 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
    0x6474e553 off    0x0000000000000000 vaddr 0x0000000000000338 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
    EH_FRAME off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**2
             filesz 0x0000000000000014 memsz 0x0000000000000014 flags r--
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    
    Dynamic Section:
      GNU_HASH             0x0000000000000380
      STRTAB               0x00000000000003b8
      SYMTAB               0x00000000000003a0
      STRSZ                0x0000000000000001
      SYMENT               0x0000000000000018
      DEBUG                0x0000000000000000
      FLAGS                0x0000000000000008
      FLAGS_1              0x0000000008000001
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .interp       0000001c  0000000000000318  0000000000000318  00000318  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      1 .gnu.hash     0000001c  0000000000000380  0000000000000380  00000380  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .dynsym       00000018  00000000000003a0  00000000000003a0  000003a0  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      3 .dynstr       00000001  00000000000003b8  00000000000003b8  000003b8  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 .text         0000000f  0000000000001000  0000000000001000  00001000  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      5 .eh_frame_hdr 00000014  0000000000002000  0000000000002000  00002000  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      6 .eh_frame     00000038  0000000000002018  0000000000002018  00002018  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      7 .dynamic      000000e0  0000000000003f20  0000000000003f20  00002f20  2**3
                      CONTENTS, ALLOC, LOAD, DATA
    SYMBOL TABLE:
    no symbols
    
    


The -Wl,xxx option for gcc passes a comma-separated list of tokens as a space-separated list of arguments to the linker.
To tell the compiler to put functions and data definitions in own sections, we use the little-known -ffunction-sections and -fdata-sections flags to GCC. Then we tell the linker to garbage collect unused sections with --gc-sections.


```python
! gcc -s -Wl,--gc-sections -ffunction-sections -fdata-sections tiny.c ; wc -c a.out
```

    14248 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000150:
    HAS_SYMS, DYNAMIC, D_PAGED
    start address 0x0000000000001040
    
    Program Header:
        PHDR off    0x0000000000000040 vaddr 0x0000000000000040 paddr 0x0000000000000040 align 2**3
             filesz 0x00000000000002d8 memsz 0x00000000000002d8 flags r--
      INTERP off    0x0000000000000318 vaddr 0x0000000000000318 paddr 0x0000000000000318 align 2**0
             filesz 0x000000000000001c memsz 0x000000000000001c flags r--
        LOAD off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**12
             filesz 0x00000000000005f0 memsz 0x00000000000005f0 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000001000 paddr 0x0000000000001000 align 2**12
             filesz 0x0000000000000145 memsz 0x0000000000000145 flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**12
             filesz 0x00000000000000c4 memsz 0x00000000000000c4 flags r--
        LOAD off    0x0000000000002df0 vaddr 0x0000000000003df0 paddr 0x0000000000003df0 align 2**12
             filesz 0x0000000000000218 memsz 0x0000000000000220 flags rw-
     DYNAMIC off    0x0000000000002e00 vaddr 0x0000000000003e00 paddr 0x0000000000003e00 align 2**3
             filesz 0x00000000000001c0 memsz 0x00000000000001c0 flags rw-
        NOTE off    0x0000000000000338 vaddr 0x0000000000000338 paddr 0x0000000000000338 align 2**3
             filesz 0x0000000000000030 memsz 0x0000000000000030 flags r--
        NOTE off    0x0000000000000368 vaddr 0x0000000000000368 paddr 0x0000000000000368 align 2**2
             filesz 0x0000000000000044 memsz 0x0000000000000044 flags r--
    0x6474e553 off    0x0000000000000338 vaddr 0x0000000000000338 paddr 0x0000000000000338 align 2**3
             filesz 0x0000000000000030 memsz 0x0000000000000030 flags r--
    EH_FRAME off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**2
             filesz 0x000000000000002c memsz 0x000000000000002c flags r--
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**4
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
       RELRO off    0x0000000000002df0 vaddr 0x0000000000003df0 paddr 0x0000000000003df0 align 2**0
             filesz 0x0000000000000210 memsz 0x0000000000000210 flags r--
    
    Dynamic Section:
      NEEDED               libc.so.6
      INIT                 0x0000000000001000
      FINI                 0x0000000000001138
      INIT_ARRAY           0x0000000000003df0
      INIT_ARRAYSZ         0x0000000000000008
      FINI_ARRAY           0x0000000000003df8
      FINI_ARRAYSZ         0x0000000000000008
      GNU_HASH             0x00000000000003b0
      STRTAB               0x0000000000000468
      SYMTAB               0x00000000000003d8
      STRSZ                0x0000000000000088
      SYMENT               0x0000000000000018
      DEBUG                0x0000000000000000
      PLTGOT               0x0000000000003fc0
      RELA                 0x0000000000000530
      RELASZ               0x00000000000000c0
      RELAENT              0x0000000000000018
      FLAGS                0x0000000000000008
      FLAGS_1              0x0000000008000001
      VERNEED              0x0000000000000500
      VERNEEDNUM           0x0000000000000001
      VERSYM               0x00000000000004f0
      RELACOUNT            0x0000000000000003
    
    Version References:
      required from libc.so.6:
        0x09691a75 0x00 03 GLIBC_2.2.5
        0x069691b4 0x00 02 GLIBC_2.34
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .interp       0000001c  0000000000000318  0000000000000318  00000318  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      1 .note.gnu.property 00000030  0000000000000338  0000000000000338  00000338  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .note.gnu.build-id 00000024  0000000000000368  0000000000000368  00000368  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      3 .note.ABI-tag 00000020  000000000000038c  000000000000038c  0000038c  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 .gnu.hash     00000024  00000000000003b0  00000000000003b0  000003b0  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      5 .dynsym       00000090  00000000000003d8  00000000000003d8  000003d8  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      6 .dynstr       00000088  0000000000000468  0000000000000468  00000468  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      7 .gnu.version  0000000c  00000000000004f0  00000000000004f0  000004f0  2**1
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      8 .gnu.version_r 00000030  0000000000000500  0000000000000500  00000500  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      9 .rela.dyn     000000c0  0000000000000530  0000000000000530  00000530  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
     10 .init         0000001b  0000000000001000  0000000000001000  00001000  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
     11 .plt          00000010  0000000000001020  0000000000001020  00001020  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
     12 .plt.got      00000010  0000000000001030  0000000000001030  00001030  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
     13 .text         000000f8  0000000000001040  0000000000001040  00001040  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
     14 .fini         0000000d  0000000000001138  0000000000001138  00001138  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
     15 .eh_frame_hdr 0000002c  0000000000002000  0000000000002000  00002000  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
     16 .eh_frame     00000094  0000000000002030  0000000000002030  00002030  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
     17 .init_array   00000008  0000000000003df0  0000000000003df0  00002df0  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     18 .fini_array   00000008  0000000000003df8  0000000000003df8  00002df8  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     19 .dynamic      000001c0  0000000000003e00  0000000000003e00  00002e00  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     20 .got          00000040  0000000000003fc0  0000000000003fc0  00002fc0  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     21 .data         00000008  0000000000004000  0000000000004000  00003000  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     22 .bss          00000008  0000000000004008  0000000000004008  00003008  2**0
                      ALLOC
     23 .comment      0000002b  0000000000000000  0000000000000000  00003008  2**0
                      CONTENTS, READONLY
    SYMBOL TABLE:
    no symbols
    
    



```python
! strip --strip-all --remove-section=.comment --remove-section=.note* --remove-section=.gnu* a.out ; wc -c a.out
```

    13664 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000150:
    HAS_SYMS, DYNAMIC, D_PAGED
    start address 0x0000000000001040
    
    Program Header:
        PHDR off    0x0000000000000040 vaddr 0x0000000000000040 paddr 0x0000000000000040 align 2**3
             filesz 0x00000000000002a0 memsz 0x00000000000002a0 flags r--
      INTERP off    0x0000000000000318 vaddr 0x0000000000000318 paddr 0x0000000000000318 align 2**0
             filesz 0x000000000000001c memsz 0x000000000000001c flags r--
        LOAD off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**12
             filesz 0x00000000000005f0 memsz 0x00000000000005f0 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000001000 paddr 0x0000000000001000 align 2**12
             filesz 0x0000000000000145 memsz 0x0000000000000145 flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**12
             filesz 0x00000000000000c4 memsz 0x00000000000000c4 flags r--
        LOAD off    0x0000000000002df0 vaddr 0x0000000000003df0 paddr 0x0000000000003df0 align 2**12
             filesz 0x0000000000000218 memsz 0x0000000000000220 flags rw-
     DYNAMIC off    0x0000000000002e00 vaddr 0x0000000000003e00 paddr 0x0000000000003e00 align 2**3
             filesz 0x00000000000001c0 memsz 0x00000000000001c0 flags rw-
        NOTE off    0x0000000000000000 vaddr 0x0000000000000338 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
        NOTE off    0x0000000000000000 vaddr 0x0000000000000368 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
    0x6474e553 off    0x0000000000000000 vaddr 0x0000000000000338 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
    EH_FRAME off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**2
             filesz 0x000000000000002c memsz 0x000000000000002c flags r--
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    
    Dynamic Section:
      NEEDED               libc.so.6
      INIT                 0x0000000000001000
      FINI                 0x0000000000001138
      INIT_ARRAY           0x0000000000003df0
      INIT_ARRAYSZ         0x0000000000000008
      FINI_ARRAY           0x0000000000003df8
      FINI_ARRAYSZ         0x0000000000000008
      GNU_HASH             0x00000000000003b0
      STRTAB               0x0000000000000468
      SYMTAB               0x00000000000003d8
      STRSZ                0x0000000000000088
      SYMENT               0x0000000000000018
      DEBUG                0x0000000000000000
      PLTGOT               0x0000000000003fc0
      RELA                 0x0000000000000530
      RELASZ               0x00000000000000c0
      RELAENT              0x0000000000000018
      FLAGS                0x0000000000000008
      FLAGS_1              0x0000000008000001
      VERNEED              0x0000000000000500
      VERNEEDNUM           0x0000000000000001
      VERSYM               0x00000000000004f0
      RELACOUNT            0x0000000000000003
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .interp       0000001c  0000000000000318  0000000000000318  00000318  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      1 .dynsym       00000090  00000000000003d8  00000000000003d8  000003d8  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .dynstr       00000088  0000000000000468  0000000000000468  00000468  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      3 .rela.dyn     000000c0  0000000000000530  0000000000000530  00000530  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 .init         0000001b  0000000000001000  0000000000001000  00001000  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      5 .plt          00000010  0000000000001020  0000000000001020  00001020  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      6 .plt.got      00000010  0000000000001030  0000000000001030  00001030  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      7 .text         000000f8  0000000000001040  0000000000001040  00001040  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      8 .fini         0000000d  0000000000001138  0000000000001138  00001138  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      9 .eh_frame_hdr 0000002c  0000000000002000  0000000000002000  00002000  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
     10 .eh_frame     00000094  0000000000002030  0000000000002030  00002030  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
     11 .init_array   00000008  0000000000003df0  0000000000003df0  00002df0  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     12 .fini_array   00000008  0000000000003df8  0000000000003df8  00002df8  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     13 .dynamic      000001c0  0000000000003e00  0000000000003e00  00002e00  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     14 .got          00000040  0000000000003fc0  0000000000003fc0  00002fc0  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     15 .data         00000008  0000000000004000  0000000000004000  00003000  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     16 .bss          00000008  0000000000004008  0000000000004008  00003008  2**0
                      ALLOC
    SYMBOL TABLE:
    no symbols
    
    



```python
! gcc -s tiny.c ; wc -c a.out
```

    14328 a.out



```python
! gcc -s -Wl,--gc-sections tiny.c ; wc -c a.out
```

    14248 a.out



```python
! gcc -s -Wl,--gc-sections -fno-ident -fno-asynchronous-unwind-tables tiny.c ; wc -c a.out
```

    14248 a.out



```python
! gcc -s -nostdlib tiny.c ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001000
    13296 a.out



```python
! gcc -s -nostdlib -nostartfiles tiny.c ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001000
    13296 a.out



```python
! gcc -Os -fdata-sections -ffunction-sections -fipa-pta -Wl,--gc-sections,-O1,--as-needed,--strip-all tiny.c ; wc -c a.out
```

    14248 a.out



```python
! gcc -s -static -nostartfiles tiny.c ;./a.out ; echo $? ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000401000
    /bin/bash: line 1: 11653 Segmentation fault      (core dumped) ./a.out
    139
    8816 a.out



```python
! gcc -s tiny.c ;./a.out ; echo $? ; wc -c a.out
```

    42
    14328 a.out



```python
! gcc -s -Os -fdata-sections -ffunction-sections -fipa-pta -Wl,--gc-sections,-O1,--as-needed,--strip-all tiny.c ; ./a.out ; echo $? ; wc -c a.out
```

    42
    14248 a.out



```python
! strip --strip-all --remove-section=.comment --remove-section=.note* a.out ; ./a.out ; echo $? ; wc -c a.out
```

    42
    13888 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000150:
    HAS_SYMS, DYNAMIC, D_PAGED
    start address 0x0000000000001050
    
    Program Header:
        PHDR off    0x0000000000000040 vaddr 0x0000000000000040 paddr 0x0000000000000040 align 2**3
             filesz 0x00000000000002a0 memsz 0x00000000000002a0 flags r--
      INTERP off    0x0000000000000318 vaddr 0x0000000000000318 paddr 0x0000000000000318 align 2**0
             filesz 0x000000000000001c memsz 0x000000000000001c flags r--
        LOAD off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**12
             filesz 0x00000000000005f0 memsz 0x00000000000005f0 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000001000 paddr 0x0000000000001000 align 2**12
             filesz 0x0000000000000149 memsz 0x0000000000000149 flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**12
             filesz 0x00000000000000b8 memsz 0x00000000000000b8 flags r--
        LOAD off    0x0000000000002df0 vaddr 0x0000000000003df0 paddr 0x0000000000003df0 align 2**12
             filesz 0x0000000000000218 memsz 0x0000000000000220 flags rw-
     DYNAMIC off    0x0000000000002e00 vaddr 0x0000000000003e00 paddr 0x0000000000003e00 align 2**3
             filesz 0x00000000000001c0 memsz 0x00000000000001c0 flags rw-
        NOTE off    0x0000000000000000 vaddr 0x0000000000000338 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
        NOTE off    0x0000000000000000 vaddr 0x0000000000000368 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
    0x6474e553 off    0x0000000000000000 vaddr 0x0000000000000338 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
    EH_FRAME off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**2
             filesz 0x000000000000002c memsz 0x000000000000002c flags r--
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    
    Dynamic Section:
      NEEDED               libc.so.6
      INIT                 0x0000000000001000
      FINI                 0x000000000000113c
      INIT_ARRAY           0x0000000000003df0
      INIT_ARRAYSZ         0x0000000000000008
      FINI_ARRAY           0x0000000000003df8
      FINI_ARRAYSZ         0x0000000000000008
      GNU_HASH             0x00000000000003b0
      STRTAB               0x0000000000000468
      SYMTAB               0x00000000000003d8
      STRSZ                0x0000000000000088
      SYMENT               0x0000000000000018
      DEBUG                0x0000000000000000
      PLTGOT               0x0000000000003fc0
      RELA                 0x0000000000000530
      RELASZ               0x00000000000000c0
      RELAENT              0x0000000000000018
      FLAGS                0x0000000000000008
      FLAGS_1              0x0000000008000001
      VERNEED              0x0000000000000500
      VERNEEDNUM           0x0000000000000001
      VERSYM               0x00000000000004f0
      RELACOUNT            0x0000000000000003
    
    Version References:
      required from libc.so.6:
        0x09691a75 0x00 03 GLIBC_2.2.5
        0x069691b4 0x00 02 GLIBC_2.34
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .interp       0000001c  0000000000000318  0000000000000318  00000318  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      1 .gnu.hash     00000024  00000000000003b0  00000000000003b0  000003b0  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .dynsym       00000090  00000000000003d8  00000000000003d8  000003d8  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      3 .dynstr       00000088  0000000000000468  0000000000000468  00000468  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 .gnu.version  0000000c  00000000000004f0  00000000000004f0  000004f0  2**1
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      5 .gnu.version_r 00000030  0000000000000500  0000000000000500  00000500  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      6 .rela.dyn     000000c0  0000000000000530  0000000000000530  00000530  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      7 .init         0000001b  0000000000001000  0000000000001000  00001000  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      8 .plt          00000010  0000000000001020  0000000000001020  00001020  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      9 .plt.got      00000010  0000000000001030  0000000000001030  00001030  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
     10 .text         000000f9  0000000000001040  0000000000001040  00001040  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
     11 .fini         0000000d  000000000000113c  000000000000113c  0000113c  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
     12 .eh_frame_hdr 0000002c  0000000000002000  0000000000002000  00002000  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
     13 .eh_frame     00000088  0000000000002030  0000000000002030  00002030  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
     14 .init_array   00000008  0000000000003df0  0000000000003df0  00002df0  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     15 .fini_array   00000008  0000000000003df8  0000000000003df8  00002df8  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     16 .dynamic      000001c0  0000000000003e00  0000000000003e00  00002e00  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     17 .got          00000040  0000000000003fc0  0000000000003fc0  00002fc0  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     18 .data         00000008  0000000000004000  0000000000004000  00003000  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     19 .bss          00000008  0000000000004008  0000000000004008  00003008  2**0
                      ALLOC
    SYMBOL TABLE:
    no symbols
    
    



```python
! ./a.out ; echo $?
```

    /bin/bash: line 1: 11638 Segmentation fault      (core dumped) ./a.out
    139


---


```python
%%writefile tiny.c
#include <unistd.h>
void _start (void) {
  _exit(42);
}
```

    Overwriting tiny.c



```python
! gcc -s -static -nostartfiles tiny.c ; ./a.out ; echo $? ; wc -c a.out
```

    42
    8904 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000102:
    EXEC_P, D_PAGED
    start address 0x0000000000401000
    
    Program Header:
        LOAD off    0x0000000000000000 vaddr 0x0000000000400000 paddr 0x0000000000400000 align 2**12
             filesz 0x0000000000000244 memsz 0x0000000000000244 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000401000 paddr 0x0000000000401000 align 2**12
             filesz 0x0000000000000070 memsz 0x0000000000000070 flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000402000 paddr 0x0000000000402000 align 2**12
             filesz 0x000000000000004c memsz 0x000000000000004c flags r--
        NOTE off    0x0000000000000200 vaddr 0x0000000000400200 paddr 0x0000000000400200 align 2**3
             filesz 0x0000000000000020 memsz 0x0000000000000020 flags r--
        NOTE off    0x0000000000000220 vaddr 0x0000000000400220 paddr 0x0000000000400220 align 2**2
             filesz 0x0000000000000024 memsz 0x0000000000000024 flags r--
         TLS off    0x000000000000204c vaddr 0x0000000000404000 paddr 0x0000000000404000 align 2**2
             filesz 0x0000000000000000 memsz 0x0000000000000004 flags r--
    0x6474e553 off    0x0000000000000200 vaddr 0x0000000000400200 paddr 0x0000000000400200 align 2**3
             filesz 0x0000000000000020 memsz 0x0000000000000020 flags r--
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**4
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .note.gnu.property 00000020  0000000000400200  0000000000400200  00000200  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      1 .note.gnu.build-id 00000024  0000000000400220  0000000000400220  00000220  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .text         00000070  0000000000401000  0000000000401000  00001000  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      3 .eh_frame     0000004c  0000000000402000  0000000000402000  00002000  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 .tbss         00000004  0000000000404000  0000000000404000  0000204c  2**2
                      ALLOC, THREAD_LOCAL
      5 .comment      0000002b  0000000000000000  0000000000000000  0000204c  2**0
                      CONTENTS, READONLY
    SYMBOL TABLE:
    no symbols
    
    



```python
! strip --strip-all --remove-section=.comment --remove-section=.note* a.out ; ./a.out ; echo $? ; wc -c a.out
```

    strip: a.out: warning: empty loadable segment detected at vaddr=0x400000, is this intentional?
    42
    8624 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000102:
    EXEC_P, D_PAGED
    start address 0x0000000000401000
    
    Program Header:
        LOAD off    0x0000000000000000 vaddr 0x0000000000400000 paddr 0x0000000000000000 align 2**12
             filesz 0x0000000000000200 memsz 0x0000000000000200 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000401000 paddr 0x0000000000401000 align 2**12
             filesz 0x0000000000000070 memsz 0x0000000000000070 flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000402000 paddr 0x0000000000402000 align 2**12
             filesz 0x000000000000004c memsz 0x000000000000004c flags r--
        NOTE off    0x0000000000000000 vaddr 0x0000000000400200 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
        NOTE off    0x0000000000000000 vaddr 0x0000000000400220 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
         TLS off    0x000000000000204c vaddr 0x0000000000404000 paddr 0x0000000000404000 align 2**2
             filesz 0x0000000000000000 memsz 0x0000000000000004 flags r--
    0x6474e553 off    0x0000000000000000 vaddr 0x0000000000400200 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .text         00000070  0000000000401000  0000000000401000  00001000  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      1 .eh_frame     0000004c  0000000000402000  0000000000402000  00002000  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .tbss         00000004  0000000000404000  0000000000404000  0000204c  2**2
                      ALLOC, THREAD_LOCAL
    SYMBOL TABLE:
    no symbols
    
    



```python
! gcc -nostartfiles -Wl,-z,max-page-size=0x1000,-z,norelro tiny.c ; ./a.out ; echo $? ; wc -c a.out
```

    42
    10696 a.out


---


```python
%%writefile tiny.c
#include <unistd.h>
#include <sys/syscall.h>
static const char str[] = "Hello world!";
void _start(){
    syscall(SYS_write, 1, str, 12);
    syscall(SYS_exit, 42);
}
```

    Overwriting tiny.c



```python
! gcc -Os -s -static -nostartfiles -Wl,-z,max-page-size=0x1000,-z,norelro tiny.c ; ./a.out ; echo $? ; wc -c a.out
```

    Hello world!42
    8984 a.out



```python
! gcc -Os -s -static -nostartfiles -fomit-frame-pointer -fno-exceptions -fno-asynchronous-unwind-tables -Wl,-z,max-page-size=0x1000,-z,norelro tiny.c ; ./a.out ; echo $? ; wc -c a.out
```

    Hello world!42
    8960 a.out



```python
! strip --strip-all --remove-section=.comment --remove-section=.note*  --remove-section=.eh_frame* a.out ; ./a.out ; echo $? ; wc -c a.out
```

    strip: a.out: warning: empty loadable segment detected at vaddr=0x400000, is this intentional?
    Hello world!42
    8560 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000102:
    EXEC_P, D_PAGED
    start address 0x0000000000401000
    
    Program Header:
        LOAD off    0x0000000000000000 vaddr 0x0000000000400000 paddr 0x0000000000000000 align 2**12
             filesz 0x0000000000000200 memsz 0x0000000000000200 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000401000 paddr 0x0000000000401000 align 2**12
             filesz 0x0000000000000087 memsz 0x0000000000000087 flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000402000 paddr 0x0000000000402000 align 2**12
             filesz 0x000000000000000d memsz 0x000000000000000d flags r--
        NOTE off    0x0000000000000000 vaddr 0x0000000000400200 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
        NOTE off    0x0000000000000000 vaddr 0x0000000000400220 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
         TLS off    0x0000000000002010 vaddr 0x0000000000404000 paddr 0x0000000000404000 align 2**2
             filesz 0x0000000000000000 memsz 0x0000000000000004 flags r--
    0x6474e553 off    0x0000000000000000 vaddr 0x0000000000400200 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .text         00000087  0000000000401000  0000000000401000  00001000  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      1 .rodata       0000000d  0000000000402000  0000000000402000  00002000  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .tbss         00000004  0000000000404000  0000000000404000  00002010  2**2
                      ALLOC, THREAD_LOCAL
    SYMBOL TABLE:
    no symbols
    
    



```bash
%%bash
gcc -Os -s -static -nostartfiles \
-fomit-frame-pointer -fno-exceptions \
-fno-asynchronous-unwind-tables -fno-unwind-tables \
-Wl,-z,norelro \
-Wl,--gc-sections \
tiny.c ; ./a.out ; echo $? ; wc -c a.out
```

    Hello world!42
    8960 a.out



```python
! strip --strip-unneeded --strip-all \
--remove-section=.comment --remove-section=.note* --remove-section=.eh_frame* \
a.out ; ./a.out ; echo $? ; wc -c a.out
```

    strip: a.out: warning: empty loadable segment detected at vaddr=0x400000, is this intentional?
    Hello world!42
    8560 a.out



```python
! objdump -s a.out
```

    
    a.out:     file format elf64-x86-64
    
    Contents of section .text:
     401000 f30f1efa 50488d15 f40f0000 be010000  ....PH..........
     401010 0031c0bf 01000000 b90c0000 00e81e00  .1..............
     401020 0000be2a 000000bf 3c000000 5a31c0e9  ...*....<...Z1..
     401030 0c000000 662e0f1f 84000000 00006690  ....f.........f.
     401040 f30f1efa 4889f848 89f74889 d64889ca  ....H..H..H..H..
     401050 4d89c24d 89c84c8b 4c24080f 05483d01  M..M..L.L$...H=.
     401060 f0ffff73 01c348c7 c1fcffff fff7d864  ...s..H........d
     401070 89014883 c8ffc3                      ..H....         
    Contents of section .rodata:
     402000 48656c6c 6f20776f 726c6421 00        Hello world!.   



```python
! objdump -d a.out
```

    
    a.out:     file format elf64-x86-64
    
    
    Disassembly of section .text:
    
    0000000000401000 <.text>:
      401000:	f3 0f 1e fa          	endbr64 
      401004:	50                   	push   %rax
      401005:	48 8d 15 f4 0f 00 00 	lea    0xff4(%rip),%rdx        # 0x402000
      40100c:	be 01 00 00 00       	mov    $0x1,%esi
      401011:	31 c0                	xor    %eax,%eax
      401013:	bf 01 00 00 00       	mov    $0x1,%edi
      401018:	b9 0c 00 00 00       	mov    $0xc,%ecx
      40101d:	e8 1e 00 00 00       	call   0x401040
      401022:	be 2a 00 00 00       	mov    $0x2a,%esi
      401027:	bf 3c 00 00 00       	mov    $0x3c,%edi
      40102c:	5a                   	pop    %rdx
      40102d:	31 c0                	xor    %eax,%eax
      40102f:	e9 0c 00 00 00       	jmp    0x401040
      401034:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
      40103b:	00 00 00 
      40103e:	66 90                	xchg   %ax,%ax
      401040:	f3 0f 1e fa          	endbr64 
      401044:	48 89 f8             	mov    %rdi,%rax
      401047:	48 89 f7             	mov    %rsi,%rdi
      40104a:	48 89 d6             	mov    %rdx,%rsi
      40104d:	48 89 ca             	mov    %rcx,%rdx
      401050:	4d 89 c2             	mov    %r8,%r10
      401053:	4d 89 c8             	mov    %r9,%r8
      401056:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
      40105b:	0f 05                	syscall 
      40105d:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
      401063:	73 01                	jae    0x401066
      401065:	c3                   	ret    
      401066:	48 c7 c1 fc ff ff ff 	mov    $0xfffffffffffffffc,%rcx
      40106d:	f7 d8                	neg    %eax
      40106f:	64 89 01             	mov    %eax,%fs:(%rcx)
      401072:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
      401076:	c3                   	ret    


---


```python
%%writefile hello.f95
program hello
  print*, 'Hello, World!'
  call exit(42)
end
```

    Overwriting hello.f95



```python
! gfortran hello.f95 ; ./a.out ; echo $? ; wc -c a.out
```

     Hello, World!
    42
    16264 a.out



```bash
%%bash
gfortran -Os -s -nostartfiles -fomit-frame-pointer -fno-exceptions \
-fno-asynchronous-unwind-tables -fno-unwind-tables \
-Wl,-z,max-page-size=0x1000,-z,norelro hello.f95
./a.out ; echo $? ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001070


     Hello, World!
    42
    9976 a.out



```bash
%%bash
strip --strip-all \
--remove-section=.comment \
--remove-section=.note* \
--remove-section=.eh_frame* \
--remove-section=.gnu.version \
--remove-section=.gnu.version_r \
--remove-section=.gnu.hash \
a.out
./a.out ; echo $? ; wc -c a.out
```

    ./a.out: error while loading shared libraries: ./a.out: unsupported version 0 of Verneed record


    127
    9480 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000150:
    HAS_SYMS, DYNAMIC, D_PAGED
    start address 0x0000000000001070
    
    Program Header:
        PHDR off    0x0000000000000040 vaddr 0x0000000000000040 paddr 0x0000000000000040 align 2**3
             filesz 0x00000000000001f8 memsz 0x00000000000001f8 flags r--
      INTERP off    0x0000000000000238 vaddr 0x0000000000000238 paddr 0x0000000000000238 align 2**0
             filesz 0x000000000000001c memsz 0x000000000000001c flags r--
        LOAD off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**12
             filesz 0x00000000000004a8 memsz 0x00000000000004a8 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000001000 paddr 0x0000000000001000 align 2**12
             filesz 0x00000000000000ea memsz 0x00000000000000ea flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000002000 paddr 0x0000000000002000 align 2**12
             filesz 0x000000000000004c memsz 0x000000000000004c flags r--
        LOAD off    0x0000000000002050 vaddr 0x0000000000003050 paddr 0x0000000000003050 align 2**12
             filesz 0x00000000000001a8 memsz 0x00000000000001a8 flags rw-
     DYNAMIC off    0x0000000000002050 vaddr 0x0000000000003050 paddr 0x0000000000003050 align 2**3
             filesz 0x0000000000000160 memsz 0x0000000000000160 flags rw-
        NOTE off    0x0000000000000000 vaddr 0x0000000000000254 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    
    Dynamic Section:
      NEEDED               libgfortran.so.5
      GNU_HASH             0x0000000000000278
      STRTAB               0x0000000000000340
      SYMTAB               0x0000000000000298
      STRSZ                0x00000000000000a6
      SYMENT               0x0000000000000018
      DEBUG                0x0000000000000000
      PLTGOT               0x00000000000031b0
      PLTRELSZ             0x0000000000000090
      PLTREL               0x0000000000000007
      JMPREL               0x0000000000000418
      FLAGS                0x0000000000000008
      FLAGS_1              0x0000000008000001
      VERNEED              0x00000000000003f8
      VERNEEDNUM           0x0000000000000001
      VERSYM               0x00000000000003e6
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .interp       0000001c  0000000000000238  0000000000000238  00000238  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      1 .dynsym       000000a8  0000000000000298  0000000000000298  00000298  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .dynstr       000000a6  0000000000000340  0000000000000340  00000340  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      3 .rela.plt     00000090  0000000000000418  0000000000000418  00000418  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 .plt          00000070  0000000000001000  0000000000001000  00001000  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      5 .text         0000007a  0000000000001070  0000000000001070  00001070  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      6 .rodata       0000004c  0000000000002000  0000000000002000  00002000  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      7 .dynamic      00000160  0000000000003050  0000000000003050  00002050  2**3
                      CONTENTS, ALLOC, LOAD, DATA
      8 .got          00000048  00000000000031b0  00000000000031b0  000021b0  2**3
                      CONTENTS, ALLOC, LOAD, DATA
    SYMBOL TABLE:
    no symbols
    
    



```python
! readelf -S a.out
```

    There are 12 section headers, starting at offset 0x2250:
    
    Section Headers:
      [Nr] Name              Type             Address           Offset
           Size              EntSize          Flags  Link  Info  Align
      [ 0]                   NULL             0000000000000000  00000000
           0000000000000000  0000000000000000           0     0     0
      [ 1] .interp           PROGBITS         0000000000000238  00000238
           000000000000001c  0000000000000000   A       0     0     1
      [ 2] .gnu.hash         GNU_HASH         0000000000000278  00000278
           000000000000001c  0000000000000000   A       3     0     8
      [ 3] .dynsym           DYNSYM           0000000000000298  00000298
           00000000000000a8  0000000000000018   A       4     1     8
      [ 4] .dynstr           STRTAB           0000000000000340  00000340
           00000000000000a6  0000000000000000   A       0     0     1
      [ 5] .rela.plt         RELA             0000000000000418  00000418
           0000000000000090  0000000000000018  AI       3    10     8
      [ 6] .plt              PROGBITS         0000000000001000  00001000
           0000000000000070  0000000000000010  AX       0     0     16
      [ 7] .text             PROGBITS         0000000000001070  00001070
           000000000000007a  0000000000000000  AX       0     0     1
      [ 8] .rodata           PROGBITS         0000000000002000  00002000
           000000000000004c  0000000000000000   A       0     0     16
      [ 9] .dynamic          DYNAMIC          0000000000003050  00002050
           0000000000000160  0000000000000010  WA       4     0     8
      [10] .got              PROGBITS         00000000000031b0  000021b0
           0000000000000048  0000000000000008  WA       0     0     8
      [11] .shstrtab         STRTAB           0000000000000000  000021f8
           0000000000000053  0000000000000000           0     0     1
    Key to Flags:
      W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
      L (link order), O (extra OS processing required), G (group), T (TLS),
      C (compressed), x (unknown), o (OS specific), E (exclude),
      D (mbind), l (large), p (processor specific)



```bash
%%bash
gfortran -Os -s \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
-Wl,--gc-sections \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

     Hello, World!
    42
    11160 a.out



```bash
%%bash
strip --strip-unneeded --strip-all \
--remove-section=.comment \
--remove-section=.note* \
--remove-section=.eh_frame* \
--remove-section=.gnu.version \
a.out
./a.out ; echo $? ; wc -c a.out
```

     Hello, World!
    42
    10568 a.out



```python
! objdump -s a.out
```

    
    a.out:     file format elf64-x86-64
    
    Contents of section .interp:
     02e0 2f6c6962 36342f6c 642d6c69 6e75782d  /lib64/ld-linux-
     02f0 7838362d 36342e73 6f2e3200           x86-64.so.2.    
    Contents of section .gnu.hash:
     0368 02000000 0b000000 01000000 06000000  ................
     0378 00008100 00000000 0b000000 00000000  ................
     0388 d165ce6d                             .e.m            
    Contents of section .dynsym:
     0390 00000000 00000000 00000000 00000000  ................
     03a0 00000000 00000000 01000000 20000000  ............ ...
     03b0 00000000 00000000 00000000 00000000  ................
     03c0 10000000 20000000 00000000 00000000  .... ...........
     03d0 00000000 00000000 2c000000 20000000  ........,... ...
     03e0 00000000 00000000 00000000 00000000  ................
     03f0 70000000 12000000 00000000 00000000  p...............
     0400 00000000 00000000 58000000 12000000  ........X.......
     0410 00000000 00000000 00000000 00000000  ................
     0420 93000000 12000000 00000000 00000000  ................
     0430 00000000 00000000 46000000 12000000  ........F.......
     0440 00000000 00000000 00000000 00000000  ................
     0450 bc000000 12000000 00000000 00000000  ................
     0460 00000000 00000000 a9000000 12000000  ................
     0470 00000000 00000000 00000000 00000000  ................
     0480 de000000 12000000 00000000 00000000  ................
     0490 00000000 00000000 cf000000 22000000  ............"...
     04a0 00000000 00000000 00000000 00000000  ................
    Contents of section .dynstr:
     04b0 005f5f67 6d6f6e5f 73746172 745f5f00  .__gmon_start__.
     04c0 5f49544d 5f646572 65676973 74657254  _ITM_deregisterT
     04d0 4d436c6f 6e655461 626c6500 5f49544d  MCloneTable._ITM
     04e0 5f726567 69737465 72544d43 6c6f6e65  _registerTMClone
     04f0 5461626c 65005f67 666f7274 72616e5f  Table._gfortran_
     0500 65786974 5f693400 5f67666f 72747261  exit_i4._gfortra
     0510 6e5f7374 5f777269 74655f64 6f6e6500  n_st_write_done.
     0520 5f67666f 72747261 6e5f7472 616e7366  _gfortran_transf
     0530 65725f63 68617261 63746572 5f777269  er_character_wri
     0540 7465005f 67666f72 7472616e 5f736574  te._gfortran_set
     0550 5f6f7074 696f6e73 005f6766 6f727472  _options._gfortr
     0560 616e5f73 745f7772 69746500 5f67666f  an_st_write._gfo
     0570 72747261 6e5f7365 745f6172 6773005f  rtran_set_args._
     0580 5f637861 5f66696e 616c697a 65005f5f  _cxa_finalize.__
     0590 6c696263 5f737461 72745f6d 61696e00  libc_start_main.
     05a0 6c696267 666f7274 72616e2e 736f2e35  libgfortran.so.5
     05b0 006c6962 632e736f 2e360047 4c494243  .libc.so.6.GLIBC
     05c0 5f322e33 3400474c 4942435f 322e322e  _2.34.GLIBC_2.2.
     05d0 35004746 4f525452 414e5f38 00        5.GFORTRAN_8.   
    Contents of section .gnu.version_r:
     05f8 01000200 01010000 10000000 30000000  ............0...
     0608 b4919606 00000400 0b010000 10000000  ................
     0618 751a6909 00000300 16010000 00000000  u.i.............
     0628 01000100 f0000000 10000000 00000000  ................
     0638 68f99207 00000200 22010000 00000000  h.......".......
    Contents of section .rela.dyn:
     0648 e0300000 00000000 08000000 00000000  .0..............
     0658 a0110000 00000000 e8300000 00000000  .........0......
     0668 08000000 00000000 60110000 00000000  ........`.......
     0678 60330000 00000000 08000000 00000000  `3..............
     0688 60330000 00000000 38330000 00000000  `3......83......
     0698 06000000 01000000 00000000 00000000  ................
     06a8 40330000 00000000 06000000 02000000  @3..............
     06b8 00000000 00000000 48330000 00000000  ........H3......
     06c8 06000000 03000000 00000000 00000000  ................
     06d8 50330000 00000000 06000000 0b000000  P3..............
     06e8 00000000 00000000 58330000 00000000  ........X3......
     06f8 06000000 0a000000 00000000 00000000  ................
    Contents of section .rela.plt:
     0708 08330000 00000000 07000000 04000000  .3..............
     0718 00000000 00000000 10330000 00000000  .........3......
     0728 07000000 05000000 00000000 00000000  ................
     0738 18330000 00000000 07000000 06000000  .3..............
     0748 00000000 00000000 20330000 00000000  ........ 3......
     0758 07000000 07000000 00000000 00000000  ................
     0768 28330000 00000000 07000000 08000000  (3..............
     0778 00000000 00000000 30330000 00000000  ........03......
     0788 07000000 09000000 00000000 00000000  ................
    Contents of section .init:
     1000 f30f1efa 4883ec08 488b0529 23000048  ....H...H..)#..H
     1010 85c07402 ffd04883 c408c3             ..t...H....     
    Contents of section .plt:
     1020 ff35d222 0000ff25 d4220000 0f1f4000  .5."...%."....@.
     1030 ff25d222 00006800 000000e9 e0ffffff  .%."..h.........
     1040 ff25ca22 00006801 000000e9 d0ffffff  .%."..h.........
     1050 ff25c222 00006802 000000e9 c0ffffff  .%."..h.........
     1060 ff25ba22 00006803 000000e9 b0ffffff  .%."..h.........
     1070 ff25b222 00006804 000000e9 a0ffffff  .%."..h.........
     1080 ff25aa22 00006805 000000e9 90ffffff  .%."..h.........
    Contents of section .plt.got:
     1090 ff25ba22 00006690                    .%."..f.        
    Contents of section .text:
     10a0 50e8caff ffff488d 35830f00 00bf0700  P.....H.5.......
     10b0 0000e899 ffffffe8 ed000000 0f1f4000  ..............@.
     10c0 f30f1efa 31ed4989 d15e4889 e24883e4  ....1.I..^H..H..
     10d0 f0505445 31c031c9 488d3dc1 ffffffff  .PTE1.1.H.=.....
     10e0 15732200 00f4662e 0f1f8400 00000000  .s"...f.........
     10f0 488d3d71 22000048 8d056a22 00004839  H.=q"..H..j"..H9
     1100 f8741548 8b053622 00004885 c07409ff  .t.H..6"..H..t..
     1110 e00f1f80 00000000 c30f1f80 00000000  ................
     1120 488d3d41 22000048 8d353a22 00004829  H.=A"..H.5:"..H)
     1130 fe4889f0 48c1ee3f 48c1f803 4801c648  .H..H..?H...H..H
     1140 d1fe7414 488b05fd 21000048 85c07408  ..t.H...!..H..t.
     1150 ffe0660f 1f440000 c30f1f80 00000000  ..f..D..........
     1160 f30f1efa 803dfd21 00000075 2b554883  .....=.!...u+UH.
     1170 3dda2100 00004889 e5740c48 8b3dde21  =.!...H..t.H.=.!
     1180 0000e809 ffffffe8 64ffffff c605d521  ........d......!
     1190 0000015d c30f1f00 c30f1f80 00000000  ...]............
     11a0 f30f1efa e977ffff ff55488d 054f0e00  .....w...UH..O..
     11b0 004881ec 10020000 4889e548 89442408  .H......H..H.D$.
     11c0 b8010000 0c48c1e0 074889ef c7442410  .....H...H...D$.
     11d0 02000000 48890424 e8a3feff ffba0d00  ....H..$........
     11e0 0000488d 35210e00 004889ef e83ffeff  ..H.5!...H...?..
     11f0 ff4889ef e847feff ff488d3d 200e0000  .H...G...H.= ...
     1200 31c0e859 feffff                      1..Y...         
    Contents of section .fini:
     1208 f30f1efa 4883ec08 4883c408 c3        ....H...H....   
    Contents of section .rodata:
     2000 68656c6c 6f2e6639 35004865 6c6c6f2c  hello.f95.Hello,
     2010 20576f72 6c642100 00000000 00000000   World!.........
     2020 2a000000 00000000 00000000 00000000  *...............
     2030 44080000 ff0f0000 00000000 01000000  D...............
     2040 01000000 00000000 1f000000           ............    
    Contents of section .init_array:
     30e0 a0110000 00000000                    ........        
    Contents of section .fini_array:
     30e8 60110000 00000000                    `.......        
    Contents of section .dynamic:
     30f0 01000000 00000000 f0000000 00000000  ................
     3100 01000000 00000000 01010000 00000000  ................
     3110 0c000000 00000000 00100000 00000000  ................
     3120 0d000000 00000000 08120000 00000000  ................
     3130 19000000 00000000 e0300000 00000000  .........0......
     3140 1b000000 00000000 08000000 00000000  ................
     3150 1a000000 00000000 e8300000 00000000  .........0......
     3160 1c000000 00000000 08000000 00000000  ................
     3170 f5feff6f 00000000 68030000 00000000  ...o....h.......
     3180 05000000 00000000 b0040000 00000000  ................
     3190 06000000 00000000 90030000 00000000  ................
     31a0 0a000000 00000000 2d010000 00000000  ........-.......
     31b0 0b000000 00000000 18000000 00000000  ................
     31c0 15000000 00000000 00000000 00000000  ................
     31d0 03000000 00000000 f0320000 00000000  .........2......
     31e0 02000000 00000000 90000000 00000000  ................
     31f0 14000000 00000000 07000000 00000000  ................
     3200 17000000 00000000 08070000 00000000  ................
     3210 07000000 00000000 48060000 00000000  ........H.......
     3220 08000000 00000000 c0000000 00000000  ................
     3230 09000000 00000000 18000000 00000000  ................
     3240 1e000000 00000000 08000000 00000000  ................
     3250 fbffff6f 00000000 01000008 00000000  ...o............
     3260 feffff6f 00000000 f8050000 00000000  ...o............
     3270 ffffff6f 00000000 02000000 00000000  ...o............
     3280 f0ffff6f 00000000 de050000 00000000  ...o............
     3290 f9ffff6f 00000000 03000000 00000000  ...o............
     32a0 00000000 00000000 00000000 00000000  ................
     32b0 00000000 00000000 00000000 00000000  ................
     32c0 00000000 00000000 00000000 00000000  ................
     32d0 00000000 00000000 00000000 00000000  ................
     32e0 00000000 00000000 00000000 00000000  ................
    Contents of section .got:
     32f0 f0300000 00000000 00000000 00000000  .0..............
     3300 00000000 00000000 36100000 00000000  ........6.......
     3310 46100000 00000000 56100000 00000000  F.......V.......
     3320 66100000 00000000 76100000 00000000  f.......v.......
     3330 86100000 00000000 00000000 00000000  ................
     3340 00000000 00000000 00000000 00000000  ................
     3350 00000000 00000000 00000000 00000000  ................
    Contents of section .data:
     3360 60330000 00000000                    `3......        



```python
! readelf -p .dynstr a.out
```

    
    String dump of section '.dynstr':
      [     1]  __gmon_start__
      [    10]  _ITM_deregisterTMCloneTable
      [    2c]  _ITM_registerTMCloneTable
      [    46]  _gfortran_exit_i4
      [    58]  _gfortran_st_write_done
      [    70]  _gfortran_transfer_character_write
      [    93]  _gfortran_set_options
      [    a9]  _gfortran_st_write
      [    bc]  _gfortran_set_args
      [    cf]  __cxa_finalize
      [    de]  __libc_start_main
      [    f0]  libgfortran.so.5
      [   101]  libc.so.6
      [   10b]  GLIBC_2.34
      [   116]  GLIBC_2.2.5
      [   122]  GFORTRAN_8
    


---


```python
%%writefile tiny.c
#include <stdio.h>
int main(void) {
    printf("Hello, world!");
    return 42;
}
```

    Overwriting tiny.c



```bash
%%bash
gcc -Os -s \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
-Wl,--gc-sections \
tiny.c
./a.out ; echo $? ; wc -c a.out
```

    Hello, world!42
    11152 a.out



```bash
%%bash
strip --strip-unneeded --strip-all \
--remove-section=.comment \
--remove-section=.note* \
--remove-section=.eh_frame* \
--remove-section=.gnu.version \
a.out
./a.out ; echo $? ; wc -c a.out
```

    Hello, world!42
    10560 a.out


---


```bash
%%bash
gcc -s \
-Wl,-z,norelro \
tiny.c
./a.out ; echo $? ; wc -c a.out
```

    Hello, world!42
    11208 a.out



```bash
%%bash
gfortran -s \
-Wl,-z,norelro \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

     Hello, World!
    42
    11248 a.out



```bash
%%bash
gfortran -Os -s \
-Wl,-z,norelro \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

     Hello, World!
    42
    11240 a.out



```bash
%%bash
gfortran -Os -s \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

     Hello, World!
    42
    11168 a.out



```bash
%%bash
gfortran -Os -s \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
-Wl,--gc-sections \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

     Hello, World!
    42
    11160 a.out



```bash
%%bash
gfortran -Os -s -nostartfiles \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001070


     Hello, World!
    42
    9976 a.out



```bash
%%bash
gfortran -s -nostartfiles \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001070


     Hello, World!
    42
    9960 a.out



```bash
%%bash
gfortran -s -nostartfiles \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001070


     Hello, World!
    42
    9960 a.out



```bash
%%bash
gfortran -s -nostartfiles \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
-Wl,--build-id=none \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000001070


     Hello, World!
    42
    9880 a.out



```bash
%%bash
gfortran -s -nostartfiles -no-pie \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
-Wl,--build-id=none \
hello.f95
./a.out ; echo $? ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000401070


     Hello, World!
    42
    9856 a.out



```bash
%%bash
gfortran -s -nostartfiles -no-pie \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
-Wl,--build-id=none \
hello.f95
objcopy -R .comment -R .gnu.version -R .eh_frame -R .gnu.hash a.out
./a.out ; echo $? ; wc -c a.out
```

    /usr/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000401070


     Hello, World!
    42
    9512 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000112:
    EXEC_P, HAS_SYMS, D_PAGED
    start address 0x0000000000401070
    
    Program Header:
        PHDR off    0x0000000000000040 vaddr 0x0000000000400040 paddr 0x0000000000400040 align 2**3
             filesz 0x00000000000001c0 memsz 0x00000000000001c0 flags r--
      INTERP off    0x0000000000000200 vaddr 0x0000000000400200 paddr 0x0000000000400200 align 2**0
             filesz 0x000000000000001c memsz 0x000000000000001c flags r--
        LOAD off    0x0000000000000000 vaddr 0x0000000000400000 paddr 0x0000000000400000 align 2**12
             filesz 0x0000000000000450 memsz 0x0000000000000450 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000401000 paddr 0x0000000000401000 align 2**12
             filesz 0x0000000000000137 memsz 0x0000000000000137 flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000402000 paddr 0x0000000000402000 align 2**12
             filesz 0x000000000000003c memsz 0x000000000000003c flags r--
        LOAD off    0x0000000000002040 vaddr 0x0000000000403040 paddr 0x0000000000403040 align 2**12
             filesz 0x0000000000000188 memsz 0x0000000000000188 flags rw-
     DYNAMIC off    0x0000000000002040 vaddr 0x0000000000403040 paddr 0x0000000000403040 align 2**3
             filesz 0x0000000000000140 memsz 0x0000000000000140 flags rw-
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    
    Dynamic Section:
      NEEDED               libgfortran.so.5
      GNU_HASH             0x0000000000400220
      STRTAB               0x00000000004002e8
      SYMTAB               0x0000000000400240
      STRSZ                0x00000000000000a6
      SYMENT               0x0000000000000018
      DEBUG                0x0000000000000000
      PLTGOT               0x0000000000403180
      PLTRELSZ             0x0000000000000090
      PLTREL               0x0000000000000007
      JMPREL               0x00000000004003c0
      VERNEED              0x00000000004003a0
      VERNEEDNUM           0x0000000000000001
      VERSYM               0x000000000040038e
    
    Version References:
      required from libgfortran.so.5:
        0x0792f968 0x00 02 GFORTRAN_8
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .interp       0000001c  0000000000400200  0000000000400200  00000200  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      1 .dynsym       000000a8  0000000000400240  0000000000400240  00000240  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .dynstr       000000a6  00000000004002e8  00000000004002e8  000002e8  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      3 .gnu.version_r 00000020  00000000004003a0  00000000004003a0  000003a0  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 .rela.plt     00000090  00000000004003c0  00000000004003c0  000003c0  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      5 .plt          00000070  0000000000401000  0000000000401000  00001000  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      6 .text         000000c7  0000000000401070  0000000000401070  00001070  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      7 .rodata       0000003c  0000000000402000  0000000000402000  00002000  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      8 .dynamic      00000140  0000000000403040  0000000000403040  00002040  2**3
                      CONTENTS, ALLOC, LOAD, DATA
      9 .got.plt      00000048  0000000000403180  0000000000403180  00002180  2**3
                      CONTENTS, ALLOC, LOAD, DATA
    SYMBOL TABLE:
    no symbols
    
    


## References

- <https://fortran-lang.org/en/learn/quickstart/hello_world/>
- <https://wiki.wxwidgets.org/Reducing_Executable_Size>
- <http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html>
- <http://cs107e.github.io/guides/gcc/>
- <http://timelessname.com/elfbin/>
- <https://web.archive.org/web/20100924220817/http://utilitybase.com/article/show/2007/04/09/225/Size+does+matter:+Optimizing+with+size+in+mind+with+GCC>
- <https://stackoverflow.com/questions/33597523/why-is-smallest-compiled-exe-i-can-make-with-gcc-is-67kb>
- <https://stackoverflow.com/questions/67516597/gcc-passing-nostartfiles-to-ld-via-gcc-for-minimal-binary-size>
- <https://stackoverflow.com/questions/65037919/minimal-executable-size-now-10x-larger-after-linking-than-2-years-ago-for-tiny>
- <https://stackoverflow.com/questions/60570279/what-is-a-reasonable-minimum-number-of-assembly-instructions-for-a-small-c-progr>
