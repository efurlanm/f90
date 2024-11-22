# Assembly small executable

*Last edited: 2023-12-11*

Some exercises to try to better understand the creation of executables by an assembler.

Reference(s):
- <https://www.devdungeon.com/content/hello-world-nasm-assembler>


```python
%%writefile hello.asm
GLOBAL  _start 

; Code goes in the text section
SECTION .text
_start: mov rax,1           ; 'write' system call = 1
        mov rdi,1           ; file descriptor 1 = STDOUT
        mov rsi,hello       ; string to write
        mov rdx,hLen        ; length of string to write
        syscall             ; call the kernel

        ; Terminate program
        mov rax,60          ; 'exit' system call
        mov rdi,42          ; exit with error code 42
        syscall             ; call the kernel

; Define variables in the data section
SECTION .rodata
hello:  db "Hello world!",10
hLen:   equ $-hello
```

    Overwriting hello.asm



```python
! wc -c hello.asm
```

    604 hello.asm



```python
! nasm -f elf64 hello.asm
```


```python
! wc -c hello.o
```

    880 hello.o



```python
! ld hello.o
```


```python
! wc -c a.out
```

    8872 a.out



```python
! ./a.out ; echo $?
```

    Hello world!
    42



```python
! objdump -s a.out
```

    
    a.out:     file format elf64-x86-64
    
    Contents of section .text:
     401000 b8010000 00bf0100 000048be 00204000  ..........H.. @.
     401010 00000000 ba0d0000 000f05b8 3c000000  ............<...
     401020 bf2a0000 000f05                      .*.....         
    Contents of section .rodata:
     402000 48656c6c 6f20776f 726c6421 0a        Hello world!.   



```python
! objdump -d a.out
```

    
    a.out:     file format elf64-x86-64
    
    
    Disassembly of section .text:
    
    0000000000401000 <_start>:
      401000:	b8 01 00 00 00       	mov    $0x1,%eax
      401005:	bf 01 00 00 00       	mov    $0x1,%edi
      40100a:	48 be 00 20 40 00 00 	movabs $0x402000,%rsi
      401011:	00 00 00 
      401014:	ba 0d 00 00 00       	mov    $0xd,%edx
      401019:	0f 05                	syscall 
      40101b:	b8 3c 00 00 00       	mov    $0x3c,%eax
      401020:	bf 2a 00 00 00       	mov    $0x2a,%edi
      401025:	0f 05                	syscall 



```python

```
