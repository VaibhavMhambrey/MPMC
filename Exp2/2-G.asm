section .data
msg1 db 'Enter a number: '
msg1Len equ $-msg1
msg2 db 'Entered numbers are: '
msg2Len equ $-msg2
sysw equ 4
sysr equ 3
syse equ 1
stdout equ 1
stde equ 0
stdin equ 2

section .bss
num1 RESB 10
num2 RESB 10

section .text
global _start

_start:
	mov eax,sysw
	mov ebx,stdout
	mov ecx,msg1
	mov edx,msg1Len
int 80h
	mov eax,sysr
	mov ebx,stdin
	mov ecx,num1
	mov edx,10
int 80h
	mov eax,sysw
	mov ebx,stdout
	mov ecx,msg1
	mov edx,msg1Len
int 80h
	mov eax,sysr
	mov ebx,stdin
	mov ecx,num2
	mov edx,10
int 80h
	mov eax,sysw
	mov ebx,stdout
	mov ecx,msg2
	mov edx,msg2Len
int 80h
	mov eax,sysw
	mov ebx,stdout
	mov ecx,num1
	mov edx,10
int 80h
	mov eax,sysw
	mov ebx,stdout
	mov ecx,num2
	mov edx,10
int 80h
	mov eax,syse
	mov ebx,stde
int 80h
