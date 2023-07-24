section .data
msg1 db 'Enter a name: '
msg1Len equ $-msg1
msg2 db 'Entered name is: '
msg2Len equ $-msg2

section .bss
name RESW 10
len equ $-name

section .text
global _start

_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,msg1Len
int 80h
	mov eax,3
	mov ebx,2
	mov ecx,name
	mov edx,len
int 80h
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,msg2Len
int 80h
	mov eax,4
	mov ebx,1
	mov ecx,name
	mov edx,len
int 80h
	mov eax,1
	mov ebx,0
int 80h
