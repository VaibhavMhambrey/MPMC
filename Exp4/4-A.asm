section .data
msg1 db 'Number 1: '
msg1Len equ $-msg1
msg2 db 'Number 2: '
msg2Len equ $-msg2
msg3 db 'The larger number is: '
msg3Len equ $-msg3

section .bss
num1 RESB 5
num2 RESB 5

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
	mov edx,5
int 80h
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,msg2Len
int 80h
	mov eax,3
	mov ebx,2
	mov ecx,num2
	mov edx,5
int 80h
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,msg3Len
int 80h
	mov eax, [num1]
	sub eax, '0'
	mov ebx, [num2]
	sub ebx, '0'
	cmp eax,ebx
	jg GREAT		; if eax>ebx
int 80h
	mov eax,4
	mov ebx,1
	mov ecx,num2
	mov edx,5
int 80h
	jmp end
GREAT:
	mov eax,4
	mov ebx,1
	mov ecx,num1
	mov edx,5
int 80h
end:
	mov eax,1
	mov ebx,0
int 80h	


