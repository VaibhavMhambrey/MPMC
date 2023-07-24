section .data
msg1 db 'Even numbers: ' 
msg1len equ $-msg1
msg2 db 'Odd numbers: ' 
msg2len equ $-msg2
newline db '',10
n1 equ $-newline
msg3 db 'Enter number of elements : '
msg3len equ $-msg3
msg4 db 'Enter elements in array : '
msg4len equ $-msg4

%macro write 2
	mov eax,4
	mov ebx,1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
 
%macro read 2
	mov eax,3
	mov ebx,2
	mov ecx,%1
	mov edx,%2
	int 80h
	mov eax,3
	mov ebx,2
	mov ecx,temp
	mov edx,1
	int 80h
%endmacro

input:	
	mov byte[k], 0
	mov esi, arr
	l_input:
		read element, 1
		mov ebx, [element]
		sub ebx, '0'
		mov [esi], ebx
		inc esi
		inc byte[k]
		mov al, [k]
		mov bl, [num]
		cmp al,bl
		jl l_input
ret

count:
	mov byte[odd],0
	mov byte[even],0
	mov esi,0
	mov ecx,4
	label:
	movzx edi, byte[arr+esi]
	mov [temp],edi 
	mov al,[temp]
	mov bl,2
	div bl
	cmp ah,0
	je l1
	inc byte[odd]
	jmp end
	l1:
	inc byte[even]
	end:
	inc esi
	loop label
	mov eax, [odd]
	add eax, '0'
	mov [odd], eax
	mov eax, [even]
	add eax, '0'
	mov [even], eax
ret

section .bss
odd resb 1
even resb 1
temp resb 5
element resb 1
num resb 1
arr resb 10
k resb 1

section .text
global _start
_start:
	write msg3, msg3len
	read num,1
	mov eax, [num]
	sub eax, '0'
	mov [num], eax
	write msg4, msg4len
	call input
	call count
	write msg1,msg1len
	write even, 1
	write newline,n1
	write msg2,msg2len
	write odd, 1
	write newline,n1
	mov eax ,1
	mov ebx ,0
	int 80h
