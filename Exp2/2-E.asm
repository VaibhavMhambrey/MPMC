section .data
msg1 db 'Enter a number: '
msg1Len equ $-msg1
msg2 db 'Entered number is: '
msg2Len equ $-msg2

section .bss
num RESB 10		

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
	mov ecx,num
	mov edx,10
int 80h
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,msg2Len
int 80h
	mov eax,4
	mov ebx,1
	mov ecx,num
	mov edx,10
int 80h
	mov eax,1
	mov ebx,0
int 80h
