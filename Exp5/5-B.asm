section .data
hello db 'hello world', 10
helloLen equ $-hello
bye db 'bye world',10
byeLen equ $-bye

%macro writesystem 2
	mov eax,4
	mov ebx,1
	mov ecx, %1
	mov edx, %2
int 80h
%endmacro

section .text
global _start

_start:
	writesystem hello, helloLen
	writesystem bye, byeLen
int 80h
	mov eax,1
	mov ebx,0
int 80h
