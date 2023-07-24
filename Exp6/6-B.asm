section .data
msg db "Enter number: "
msgLen equ $- msg
nl db '', 10
n1 equ $- nl
msg1 db 'Factorial of the number: '
msg1Len equ $- msg1

%macro write 2
	mov eax, 4	
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
        int 80h
%endmacro

%macro read 2
	mov eax, 3
	mov ebx, 2
	mov ecx, %1
	mov edx, %2
        int 80h
%endmacro

factorial:
	mov eax, 1
	mov ecx, [num]
	mov ebx,1
	L1:	
		mul ebx
		inc ebx
		loop L1
		add eax, '0'
		mov [fact],eax
ret

section .bss
num RESB 5
fact RESB 5
count RESB 5
i RESB 5

section .text
global _start
_start:
	write msg, msgLen
	read num, 1
	mov eax,[num]
	sub eax,'0'
	mov [num],eax
	write msg1, msg1Len
	call factorial   
	write fact, 1
	write nl,n1
	mov eax, 1
	mov ebx, 0
	int 80h
