section .data
hello db 'hello world', 10
helloLen equ $-hello

%macro writesystem 2
	mov eax,4
	mov ebx,1
	mov ecx, %1
	mov edx, %2
%endmacro

section .text
global _start

_start:
	writesystem hello, helloLen
int 80h
	mov eax,1
	mov ebx,0
int 80h
