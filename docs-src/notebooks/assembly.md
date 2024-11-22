# Bare metal x86_64 Assembly Language on *nix 64

Using the NASM assembler (https://nasm.us/)

To install on Fedora: # dnf -y install nasm

* SYSCALL instruction jumps to operating system services. To use, first put the system call number in RAX, then the arguments, if any, in RDI, RSI, RDX, R10, R8, and R9, respectively. 
* call number 60 exit a process.

## Hello world example

### Write the source file


```python
%%writefile hello.asm
; hello.asm
; source: https://cs.lmu.edu/~ray/notes/x86assembly/
            global      _start
            section     .text
_start:     mov         rax, 1          ; system call for write
            mov         rdi, 1          ; file handle 1 is stdout
            mov         rsi, message    ; address of string to output
            mov         rdx, 14         ; number of bytes
            syscall                     ; invoke operating system to do the write
            mov         rax, 60         ; system call for exit
            xor         rdi, rdi        ; exit code 0
            syscall                     ; invoke operating system to exit

            section     .data
message:    db          "Hello, world!", 10   ; note the newline (10) at the end
```

    Overwriting hello.asm


### Assemble and show the listing file


```python
! nasm -f elf64 hello.asm -l hello.lst
```


```python
! cat hello.lst
```

         1                                  ; hello.asm
         2                                  ; source: https://cs.lmu.edu/~ray/notes/x86assembly/
         3                                              global      _start
         4                                              section     .text
         5 00000000 B801000000              _start:     mov         rax, 1          ; system call for write
         6 00000005 BF01000000                          mov         rdi, 1          ; file handle 1 is stdout
         7 0000000A 48BE-                               mov         rsi, message    ; address of string to output
         7 0000000C [0000000000000000] 
         8 00000014 BA0E000000                          mov         rdx, 14         ; number of bytes
         9 00000019 0F05                                syscall                     ; invoke operating system to do the write
        10 0000001B B83C000000                          mov         rax, 60         ; system call for exit
        11 00000020 4831FF                              xor         rdi, rdi        ; exit code 0
        12 00000023 0F05                                syscall                     ; invoke operating system to exit
        13                                  
        14                                              section     .data
        15 00000000 48656C6C6F2C20776F-     message:    db          "Hello, world!", 10   ; note the newline (10) at the end
        15 00000009 726C64210A         


Columns, in sequence:
* sequential line number, only for reference
* address in memory
* bytes (data or instruction)
* label
* opcode
* operand, register, data, other information
* comments

### Link


```python
! ld --verbose -o hello.out hello.o
```

    GNU ld version 2.35-18.fc33
      Supported emulations:
       elf_x86_64
       elf32_x86_64
       elf_i386
       elf_iamcu
       elf_l1om
       elf_k1om
       i386pep
       i386pe
       elf64bpf
    using internal linker script:
    ==================================================
    /* Script for -z combreloc -z separate-code */
    /* Copyright (C) 2014-2020 Free Software Foundation, Inc.
       Copying and distribution of this script, with or without modification,
       are permitted in any medium without royalty provided the copyright
       notice and this notice are preserved.  */
    OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64",
    	      "elf64-x86-64")
    OUTPUT_ARCH(i386:x86-64)
    ENTRY(_start)
    SEARCH_DIR("=/usr/x86_64-redhat-linux/lib64"); SEARCH_DIR("=/usr/lib64"); SEARCH_DIR("=/usr/local/lib64"); SEARCH_DIR("=/lib64"); SEARCH_DIR("=/usr/x86_64-redhat-linux/lib"); SEARCH_DIR("=/usr/local/lib"); SEARCH_DIR("=/lib"); SEARCH_DIR("=/usr/lib");
    SECTIONS
    {
      PROVIDE (__executable_start = SEGMENT_START("text-segment", 0x400000)); . = SEGMENT_START("text-segment", 0x400000) + SIZEOF_HEADERS;
      .interp         : { *(.interp) }
      .note.gnu.build-id  : { *(.note.gnu.build-id) }
      .hash           : { *(.hash) }
      .gnu.hash       : { *(.gnu.hash) }
      .dynsym         : { *(.dynsym) }
      .dynstr         : { *(.dynstr) }
      .gnu.version    : { *(.gnu.version) }
      .gnu.version_d  : { *(.gnu.version_d) }
      .gnu.version_r  : { *(.gnu.version_r) }
      .rela.dyn       :
        {
          *(.rela.init)
          *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*)
          *(.rela.fini)
          *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*)
          *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*)
          *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*)
          *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*)
          *(.rela.ctors)
          *(.rela.dtors)
          *(.rela.got)
          *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*)
          *(.rela.ldata .rela.ldata.* .rela.gnu.linkonce.l.*)
          *(.rela.lbss .rela.lbss.* .rela.gnu.linkonce.lb.*)
          *(.rela.lrodata .rela.lrodata.* .rela.gnu.linkonce.lr.*)
          *(.rela.ifunc)
        }
      .rela.plt       :
        {
          *(.rela.plt)
          PROVIDE_HIDDEN (__rela_iplt_start = .);
          *(.rela.iplt)
          PROVIDE_HIDDEN (__rela_iplt_end = .);
        }
      . = ALIGN(CONSTANT (MAXPAGESIZE));
      .init           :
      {
        KEEP (*(SORT_NONE(.init)))
      }
      .plt            : { *(.plt) *(.iplt) }
    .plt.got        : { *(.plt.got) }
    .plt.sec        : { *(.plt.sec) }
      .text           :
      {
        *(.text.unlikely .text.*_unlikely .text.unlikely.*)
        *(.text.exit .text.exit.*)
        *(.text.startup .text.startup.*)
        *(.text.hot .text.hot.*)
        *(SORT(.text.sorted.*))
        *(.text .stub .text.* .gnu.linkonce.t.*)
        /* .gnu.warning sections are handled specially by elf.em.  */
        *(.gnu.warning)
      }
      .fini           :
      {
        KEEP (*(SORT_NONE(.fini)))
      }
      PROVIDE (__etext = .);
      PROVIDE (_etext = .);
      PROVIDE (etext = .);
      . = ALIGN(CONSTANT (MAXPAGESIZE));
      /* Adjust the address for the rodata segment.  We want to adjust up to
         the same address within the page on the next page up.  */
      . = SEGMENT_START("rodata-segment", ALIGN(CONSTANT (MAXPAGESIZE)) + (. & (CONSTANT (MAXPAGESIZE) - 1)));
      .rodata         : { *(.rodata .rodata.* .gnu.linkonce.r.*) }
      .rodata1        : { *(.rodata1) }
      .eh_frame_hdr   : { *(.eh_frame_hdr) *(.eh_frame_entry .eh_frame_entry.*) }
      .eh_frame       : ONLY_IF_RO { KEEP (*(.eh_frame)) *(.eh_frame.*) }
      .gcc_except_table   : ONLY_IF_RO { *(.gcc_except_table .gcc_except_table.*) }
      .gnu_extab   : ONLY_IF_RO { *(.gnu_extab*) }
      /* These sections are generated by the Sun/Oracle C++ compiler.  */
      .exception_ranges   : ONLY_IF_RO { *(.exception_ranges*) }
      /* Adjust the address for the data segment.  We want to adjust up to
         the same address within the page on the next page up.  */
      . = DATA_SEGMENT_ALIGN (CONSTANT (MAXPAGESIZE), CONSTANT (COMMONPAGESIZE));
      /* Exception handling  */
      .eh_frame       : ONLY_IF_RW { KEEP (*(.eh_frame)) *(.eh_frame.*) }
      .gnu_extab      : ONLY_IF_RW { *(.gnu_extab) }
      .gcc_except_table   : ONLY_IF_RW { *(.gcc_except_table .gcc_except_table.*) }
      .exception_ranges   : ONLY_IF_RW { *(.exception_ranges*) }
      /* Thread Local Storage sections  */
      .tdata	  :
       {
         PROVIDE_HIDDEN (__tdata_start = .);
         *(.tdata .tdata.* .gnu.linkonce.td.*)
       }
      .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
      .preinit_array    :
      {
        PROVIDE_HIDDEN (__preinit_array_start = .);
        KEEP (*(.preinit_array))
        PROVIDE_HIDDEN (__preinit_array_end = .);
      }
      .init_array    :
      {
        PROVIDE_HIDDEN (__init_array_start = .);
        KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
        KEEP (*(.init_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .ctors))
        PROVIDE_HIDDEN (__init_array_end = .);
      }
      .fini_array    :
      {
        PROVIDE_HIDDEN (__fini_array_start = .);
        KEEP (*(SORT_BY_INIT_PRIORITY(.fini_array.*) SORT_BY_INIT_PRIORITY(.dtors.*)))
        KEEP (*(.fini_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .dtors))
        PROVIDE_HIDDEN (__fini_array_end = .);
      }
      .ctors          :
      {
        /* gcc uses crtbegin.o to find the start of
           the constructors, so we make sure it is
           first.  Because this is a wildcard, it
           doesn't matter if the user does not
           actually link against crtbegin.o; the
           linker won't look for a file to match a
           wildcard.  The wildcard also means that it
           doesn't matter which directory crtbegin.o
           is in.  */
        KEEP (*crtbegin.o(.ctors))
        KEEP (*crtbegin?.o(.ctors))
        /* We don't want to include the .ctor section from
           the crtend.o file until after the sorted ctors.
           The .ctor section from the crtend file contains the
           end of ctors marker and it must be last */
        KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .ctors))
        KEEP (*(SORT(.ctors.*)))
        KEEP (*(.ctors))
      }
      .dtors          :
      {
        KEEP (*crtbegin.o(.dtors))
        KEEP (*crtbegin?.o(.dtors))
        KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .dtors))
        KEEP (*(SORT(.dtors.*)))
        KEEP (*(.dtors))
      }
      .jcr            : { KEEP (*(.jcr)) }
      .data.rel.ro : { *(.data.rel.ro.local* .gnu.linkonce.d.rel.ro.local.*) *(.data.rel.ro .data.rel.ro.* .gnu.linkonce.d.rel.ro.*) }
      .dynamic        : { *(.dynamic) }
      .got            : { *(.got) *(.igot) }
      . = DATA_SEGMENT_RELRO_END (SIZEOF (.got.plt) >= 24 ? 24 : 0, .);
      .got.plt        : { *(.got.plt) *(.igot.plt) }
      .data           :
      {
        *(.data .data.* .gnu.linkonce.d.*)
        SORT(CONSTRUCTORS)
      }
      .data1          : { *(.data1) }
      _edata = .; PROVIDE (edata = .);
      . = .;
      __bss_start = .;
      .bss            :
      {
       *(.dynbss)
       *(.bss .bss.* .gnu.linkonce.b.*)
       *(COMMON)
       /* Align here to ensure that the .bss section occupies space up to
          _end.  Align after .bss to ensure correct alignment even if the
          .bss section disappears because there are no input sections.
          FIXME: Why do we need it? When there is no .bss section, we do not
          pad the .data section.  */
       . = ALIGN(. != 0 ? 64 / 8 : 1);
      }
      .lbss   :
      {
        *(.dynlbss)
        *(.lbss .lbss.* .gnu.linkonce.lb.*)
        *(LARGE_COMMON)
      }
      . = ALIGN(64 / 8);
      . = SEGMENT_START("ldata-segment", .);
      .lrodata   ALIGN(CONSTANT (MAXPAGESIZE)) + (. & (CONSTANT (MAXPAGESIZE) - 1)) :
      {
        *(.lrodata .lrodata.* .gnu.linkonce.lr.*)
      }
      .ldata   ALIGN(CONSTANT (MAXPAGESIZE)) + (. & (CONSTANT (MAXPAGESIZE) - 1)) :
      {
        *(.ldata .ldata.* .gnu.linkonce.l.*)
        . = ALIGN(. != 0 ? 64 / 8 : 1);
      }
      . = ALIGN(64 / 8);
      _end = .; PROVIDE (end = .);
      . = DATA_SEGMENT_END (.);
      /* Stabs debugging sections.  */
      .stab          0 : { *(.stab) }
      .stabstr       0 : { *(.stabstr) }
      .stab.excl     0 : { *(.stab.excl) }
      .stab.exclstr  0 : { *(.stab.exclstr) }
      .stab.index    0 : { *(.stab.index) }
      .stab.indexstr 0 : { *(.stab.indexstr) }
      .comment       0 : { *(.comment) }
      .gnu.build.attributes : { *(.gnu.build.attributes .gnu.build.attributes.*) }
      /* DWARF debug sections.
         Symbols in the DWARF debugging sections are relative to the beginning
         of the section so we begin them at 0.  */
      /* DWARF 1 */
      .debug          0 : { *(.debug) }
      .line           0 : { *(.line) }
      /* GNU DWARF 1 extensions */
      .debug_srcinfo  0 : { *(.debug_srcinfo) }
      .debug_sfnames  0 : { *(.debug_sfnames) }
      /* DWARF 1.1 and DWARF 2 */
      .debug_aranges  0 : { *(.debug_aranges) }
      .debug_pubnames 0 : { *(.debug_pubnames) }
      /* DWARF 2 */
      .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
      .debug_abbrev   0 : { *(.debug_abbrev) }
      .debug_line     0 : { *(.debug_line .debug_line.* .debug_line_end) }
      .debug_frame    0 : { *(.debug_frame) }
      .debug_str      0 : { *(.debug_str) }
      .debug_loc      0 : { *(.debug_loc) }
      .debug_macinfo  0 : { *(.debug_macinfo) }
      /* SGI/MIPS DWARF 2 extensions */
      .debug_weaknames 0 : { *(.debug_weaknames) }
      .debug_funcnames 0 : { *(.debug_funcnames) }
      .debug_typenames 0 : { *(.debug_typenames) }
      .debug_varnames  0 : { *(.debug_varnames) }
      /* DWARF 3 */
      .debug_pubtypes 0 : { *(.debug_pubtypes) }
      .debug_ranges   0 : { *(.debug_ranges) }
      /* DWARF Extension.  */
      .debug_macro    0 : { *(.debug_macro) }
      .debug_addr     0 : { *(.debug_addr) }
      .gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
      /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) *(.gnu.lto_*) }
    }
    
    
    ==================================================
    ld: mode elf_x86_64
    attempt to open hello.o succeeded
    hello.o


### Show generated files


```python
! ls
```

    assembly.ipynb		hello.f90		  hello.lst  hello.s
    fortran-assembly.ipynb	hello.f90.004t.original   hello.o    README.md
    hello.asm		hello.f90.235t.optimized  hello.out


### Run


```python
! ./hello.out
```

    Hello, world!


### readelf


```python
! readelf -all hello.o
```

    ELF Header:
      Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
      Class:                             ELF64
      Data:                              2's complement, little endian
      Version:                           1 (current)
      OS/ABI:                            UNIX - System V
      ABI Version:                       0
      Type:                              REL (Relocatable file)
      Machine:                           Advanced Micro Devices X86-64
      Version:                           0x1
      Entry point address:               0x0
      Start of program headers:          0 (bytes into file)
      Start of section headers:          64 (bytes into file)
      Flags:                             0x0
      Size of this header:               64 (bytes)
      Size of program headers:           0 (bytes)
      Number of program headers:         0
      Size of section headers:           64 (bytes)
      Number of section headers:         7
      Section header string table index: 3
    
    Section Headers:
      [Nr] Name              Type             Address           Offset
           Size              EntSize          Flags  Link  Info  Align
      [ 0]                   NULL             0000000000000000  00000000
           0000000000000000  0000000000000000           0     0     0
      [ 1] .text             PROGBITS         0000000000000000  00000200
           0000000000000025  0000000000000000  AX       0     0     16
      [ 2] .data             PROGBITS         0000000000000000  00000230
           000000000000000e  0000000000000000  WA       0     0     4
      [ 3] .shstrtab         STRTAB           0000000000000000  00000240
           0000000000000032  0000000000000000           0     0     1
      [ 4] .symtab           SYMTAB           0000000000000000  00000280
           0000000000000090  0000000000000018           5     5     8
      [ 5] .strtab           STRTAB           0000000000000000  00000310
           000000000000001a  0000000000000000           0     0     1
      [ 6] .rela.text        RELA             0000000000000000  00000330
           0000000000000018  0000000000000018           4     1     8
    Key to Flags:
      W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
      L (link order), O (extra OS processing required), G (group), T (TLS),
      C (compressed), x (unknown), o (OS specific), E (exclude),
      l (large), p (processor specific)
    
    There are no section groups in this file.
    
    There are no program headers in this file.
    
    There is no dynamic section in this file.
    
    Relocation section '.rela.text' at offset 0x330 contains 1 entry:
      Offset          Info           Type           Sym. Value    Sym. Name + Addend
    00000000000c  000300000001 R_X86_64_64       0000000000000000 .data + 0
    
    The decoding of unwind sections for machine type Advanced Micro Devices X86-64 is not currently supported.
    
    Symbol table '.symtab' contains 6 entries:
       Num:    Value          Size Type    Bind   Vis      Ndx Name
         0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND 
         1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS hello.asm
         2: 0000000000000000     0 SECTION LOCAL  DEFAULT    1 
         3: 0000000000000000     0 SECTION LOCAL  DEFAULT    2 
         4: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT    2 message
         5: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    1 _start
    
    No version information found in this file.


### read the .data section in hex


```python
! readelf -x '.data'  hello.o
```

    
    Hex dump of section '.data':
      0x00000000 48656c6c 6f2c2077 6f726c64 210a     Hello, world!.
    


### objdump


```python
! objdump -d hello.o
```

    
    hello.o:     file format elf64-x86-64
    
    
    Disassembly of section .text:
    
    0000000000000000 <_start>:
       0:	b8 01 00 00 00       	mov    $0x1,%eax
       5:	bf 01 00 00 00       	mov    $0x1,%edi
       a:	48 be 00 00 00 00 00 	movabs $0x0,%rsi
      11:	00 00 00 
      14:	ba 0e 00 00 00       	mov    $0xe,%edx
      19:	0f 05                	syscall 
      1b:	b8 3c 00 00 00       	mov    $0x3c,%eax
      20:	48 31 ff             	xor    %rdi,%rdi
      23:	0f 05                	syscall 


## asm + C library


```python
%%writefile hc.asm
    global  main
    extern  puts

    section .text
main:                     ; This is called by the C library startup code
    mov     rdi, message  ; First integer|pointer argument in rdi
    call    puts          ; puts(message)
    ret                   ; Return from main back into C library wrapper
message:
    db      "Hello, world!", 0    ; strings must be terminated with 0
```

    Overwriting hc.asm


### Assemble using NASM


```python
! nasm -f elf64 hc.asm -l hc.lst
```


```python
! cat hc.lst
```

         1                                      global  main
         2                                      extern  puts
         3                                  
         4                                      section .text
         5                                  main:                     ; This is called by the C library startup code
         6 00000000 48BF-                       mov     rdi, message  ; First integer|pointer argument in rdi
         6 00000002 [1000000000000000] 
         7 0000000A E8(00000000)                call    puts          ; puts(message)
         8 0000000F C3                          ret                   ; Return from main back into C library wrapper
         9                                  message:
        10 00000010 48656C6C6F2C20776F-         db      "Hello, world!", 0    ; strings must be terminated with 0
        10 00000019 726C642100         


### Link using gcc


```python
! gcc -o hc.out hc.o
```

### Run


```python
! ./hc.out
```

    Hello, world!


# asm & f90

Reference: https://forum.nasm.us/index.php?topic=2448.15


```python
%%writefile hcfg.asm
            global      hello_
            section     .text
hello_:     mov         rax, 1          ; system call for write
            mov         rdi, 1          ; file handle 1 is stdout
            mov         rsi, message    ; address of string to output
            mov         rdx, 20         ; number of bytes
            syscall                     ; invoke operating system to do the write
            mov         rax, 60         ; system call for exit
            xor         rdi, rdi        ; exit code 0
            syscall                     ; invoke operating system to exit

            section     .data
message:    db          " asm: Hello, world!", 10   ; note the newline (10) at the end
```

    Overwriting hcfg.asm



```python
! nasm -f elf64 hcfg.asm
```


```python
%%writefile hcfg.f90
external hello
print*, "f90: Hello, world!"
i = hello()
end
```

    Overwriting hcfg.f90



```python
! gfortran -o hcfg.out hcfg.f90 hcfg.o
```


```python
! ./hcfg.out
```

     f90: Hello, world!
     asm: Hello, world!



```python

```
