# csv example

*Last edited: 2023-12-11*


```python
%%writefile data.txt
1, "Mediterranean Avenue"
2, "Baltic Avenue"
3, "Oriental Avenue"
4, "Vermont Avenue"
5, "Connecticut Avenue"
6, "St. Charles Place"
```

    Writing data.txt



```python
%%writefile csv.f90
program main
    use, intrinsic :: iso_fortran_env               ! error_unit
    implicit none

    character(len=*), parameter :: F = 'data.txt'   ! File name.
    integer,          parameter :: U = 20           ! Output unit.
    character(len=100)          :: street
    integer                     :: i, rc

    open (unit=U, action='read', file=F, iostat=rc)
    if (rc /= 0) then
        write (error_unit, '(3a, i0)') 'Reading file "', F,  &
            '" failed: error ', rc
        stop
    end if

    do
        read (U, *, iostat=rc) i, street            ! Read from file.
        if (rc /= 0) exit                           ! Exit on error.
        print '(i1, a, a)', i, ': ', trim(street)   ! Output line.
    end do

    close (U)
end program main
```

    Writing csv.f90



```bash
%%bash
gfortran -O3 -s -no-pie \
-fomit-frame-pointer -fno-exceptions -fno-unwind-tables \
-fno-asynchronous-unwind-tables \
-Wl,-z,norelro \
-Wl,--build-id=none \
csv.f90
objcopy -R .comment -R .gnu.version -R .gnu.hash -R .note* a.out
./a.out ; echo $? ; wc -c a.out
```

    1: Mediterranean Avenue
    2: Baltic Avenue
    3: Oriental Avenue
    4: Vermont Avenue
    5: Connecticut Avenue
    6: St. Charles Place
    0
    10760 a.out



```python
! objdump -x a.out
```

    
    a.out:     file format elf64-x86-64
    a.out
    architecture: i386:x86-64, flags 0x00000112:
    EXEC_P, HAS_SYMS, D_PAGED
    start address 0x0000000000401140
    
    Program Header:
        PHDR off    0x0000000000000040 vaddr 0x0000000000400040 paddr 0x0000000000400040 align 2**3
             filesz 0x00000000000002a0 memsz 0x00000000000002a0 flags r--
      INTERP off    0x00000000000002e0 vaddr 0x00000000004002e0 paddr 0x00000000004002e0 align 2**0
             filesz 0x000000000000001c memsz 0x000000000000001c flags r--
        LOAD off    0x0000000000000000 vaddr 0x0000000000400000 paddr 0x0000000000400000 align 2**12
             filesz 0x0000000000000880 memsz 0x0000000000000880 flags r--
        LOAD off    0x0000000000001000 vaddr 0x0000000000401000 paddr 0x0000000000401000 align 2**12
             filesz 0x00000000000004d5 memsz 0x00000000000004d5 flags r-x
        LOAD off    0x0000000000002000 vaddr 0x0000000000402000 paddr 0x0000000000402000 align 2**12
             filesz 0x00000000000000cc memsz 0x00000000000000cc flags r--
        LOAD off    0x0000000000002138 vaddr 0x0000000000403138 paddr 0x0000000000403138 align 2**12
             filesz 0x0000000000000298 memsz 0x00000000000002a0 flags rw-
     DYNAMIC off    0x0000000000002148 vaddr 0x0000000000403148 paddr 0x0000000000403148 align 2**3
             filesz 0x00000000000001e0 memsz 0x00000000000001e0 flags rw-
        NOTE off    0x0000000000000000 vaddr 0x0000000000400300 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
        NOTE off    0x0000000000000000 vaddr 0x0000000000400320 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
    0x6474e553 off    0x0000000000000000 vaddr 0x0000000000400300 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags r--
    EH_FRAME off    0x00000000000020a8 vaddr 0x00000000004020a8 paddr 0x00000000004020a8 align 2**2
             filesz 0x0000000000000024 memsz 0x0000000000000024 flags r--
       STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**3
             filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
    
    Dynamic Section:
      NEEDED               libgfortran.so.5
      NEEDED               libc.so.6
      INIT                 0x0000000000401000
      FINI                 0x00000000004014c8
      INIT_ARRAY           0x0000000000403138
      INIT_ARRAYSZ         0x0000000000000008
      FINI_ARRAY           0x0000000000403140
      FINI_ARRAYSZ         0x0000000000000008
      GNU_HASH             0x0000000000400340
      STRTAB               0x00000000004004f8
      SYMTAB               0x0000000000400360
      STRSZ                0x00000000000001a1
      SYMENT               0x0000000000000018
      DEBUG                0x0000000000000000
      PLTGOT               0x0000000000403338
      PLTRELSZ             0x0000000000000150
      PLTREL               0x0000000000000007
      JMPREL               0x0000000000400730
      RELA                 0x0000000000400700
      RELASZ               0x0000000000000030
      RELAENT              0x0000000000000018
      VERNEED              0x00000000004006c0
      VERNEEDNUM           0x0000000000000002
      VERSYM               0x000000000040069a
    
    Version References:
      required from libc.so.6:
        0x069691b4 0x00 03 GLIBC_2.34
      required from libgfortran.so.5:
        0x0792f968 0x00 02 GFORTRAN_8
    
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .interp       0000001c  00000000004002e0  00000000004002e0  000002e0  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      1 .dynsym       00000198  0000000000400360  0000000000400360  00000360  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      2 .dynstr       000001a1  00000000004004f8  00000000004004f8  000004f8  2**0
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      3 .gnu.version_r 00000040  00000000004006c0  00000000004006c0  000006c0  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 .rela.dyn     00000030  0000000000400700  0000000000400700  00000700  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      5 .rela.plt     00000150  0000000000400730  0000000000400730  00000730  2**3
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      6 .init         0000001b  0000000000401000  0000000000401000  00001000  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      7 .plt          000000f0  0000000000401020  0000000000401020  00001020  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      8 .text         000003b8  0000000000401110  0000000000401110  00001110  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      9 .fini         0000000d  00000000004014c8  00000000004014c8  000014c8  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
     10 .rodata       000000a8  0000000000402000  0000000000402000  00002000  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
     11 .eh_frame_hdr 00000024  00000000004020a8  00000000004020a8  000020a8  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
     12 .init_array   00000008  0000000000403138  0000000000403138  00002138  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     13 .fini_array   00000008  0000000000403140  0000000000403140  00002140  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     14 .dynamic      000001e0  0000000000403148  0000000000403148  00002148  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     15 .got          00000010  0000000000403328  0000000000403328  00002328  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     16 .got.plt      00000088  0000000000403338  0000000000403338  00002338  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     17 .data         00000010  00000000004033c0  00000000004033c0  000023c0  2**3
                      CONTENTS, ALLOC, LOAD, DATA
     18 .bss          00000008  00000000004033d0  00000000004033d0  000023d0  2**0
                      ALLOC
    SYMBOL TABLE:
    no symbols
    
    



```python

```
