section .data
	msg1 db 'Enter the number: '
	len1 equ $-msg1	

	msg2 db 'The subtraction of the two numbers is '
	len2 equ $-msg2
	
	newline db ' ',10
	l equ $-newline
	
	%macro readsystem 2
	mov eax, 3
	mov ebx, 2
	mov ecx, %1
	mov edx, %2
	int 80h
	%endmacro

	%macro writesystem 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
	%endmacro

section .bss
	num1 resb 9
	num2 resb 9
	diff resb 9
	
section .text
	global _start:

	_start:

	writesystem msg1, len1
	readsystem num1, 9
	writesystem msg1, len1
	readsystem num2, 9

	mov esi,2
	mov ecx,3
	clc ;clear carry flag
	
	sub_loop:
		mov al,[num1+esi]
		sbb al,[num2+esi]
		aas ;adjust after subtraction
		pushf
		or al,30h ;30h ascii code of '0' ;or al, 0011 0000
		popf
		
		mov [diff+esi],al
		dec esi
		loop sub_loop
		
	writesystem msg2, len2
	writesystem diff, 9
	writesystem newline, l

	mov eax,1
	mov ebx,0
	int 80h
