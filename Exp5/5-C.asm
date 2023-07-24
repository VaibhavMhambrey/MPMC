section .data
msg1 db 'Enter a number: '
msg1Len equ $-msg1
msg2 db 'Entered number: '
msg2Len equ $-msg2

%macro writesystem 2
	mov eax,4
	mov ebx,1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

%macro readsystem 2
	mov eax,3
	mov ebx,2
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .bss
num RESB 5

section .text
global _start

_start:
	writesystem msg1, msg1Len
	readsystem num, 5
	writesystem msg2, msg2Len
	writesystem num,5
int 80h
	mov eax,1
	mov ebx,0
int 80h
