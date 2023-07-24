section .data
msg1 db 'Enter number 1: '
msg1Len equ $-msg1
msg2 db 'Enter number 2: '
msg2Len equ $-msg2
msg3 db 'Entered numbers: '
msg3Len equ $-msg3

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
num1 RESB 5
num2 RESB 5

section .text
global _start

_start:
	writesystem msg1, msg1Len
	readsystem num1, 5
	writesystem msg2, msg2Len
	readsystem num2, 5
	writesystem msg3, msg3Len
	writesystem num1,5
	writesystem ' ',1
	writesystem num2,5
int 80h
	mov eax,1
	mov ebx,0
int 80h
