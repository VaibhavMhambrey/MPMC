section .data
msg1 db 'Enter number: '
msg1Len equ $-msg1
msg2 db 'The number is even ',10
msg2Len equ $-msg2
msg3 db 'The number is odd ',10
msg3Len equ $-msg3

section .bss
num1 RESB 1

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
	mov ecx,num1
	mov edx,1
int 80h
	mov al, [num1]
	sub al, '0'
	mov bl,2
	div bl
	
	cmp ah,0
	je EQUAL	
	jmp N_EQUAL	
int 80h
EQUAL:
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,msg2Len
int 80h
	jmp end
N_EQUAL:
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,msg3Len
int 80h
end:
	mov eax,1
	mov ebx,0
int 80h	
