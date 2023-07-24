
section .data
hello db 'hello world', 10
helloLen equ $-hello
sysw equ 4
stdout equ 1

section .text
global _start

_start:
	mov eax,sysw
	mov ebx,stdout
	mov ecx, hello
	mov edx, helloLen
int 80h
	mov eax,1
	mov ebx,0
int 80h
