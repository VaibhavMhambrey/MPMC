section .data
msg db 'Enter number of elements: '
msglen equ $-msg
msg1 db 'Enter elements:' 
msg1len equ $-msg1
msg2 db 'Array elements: ' 
msg2len equ $-msg2
newline db '',10
space db ' '

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
	mov ecx,trash
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

display:
	mov byte[k], 0
	mov esi, arr
	d_input:
		mov eax,[esi]
		add eax,'0'
		mov [element],eax
		write element, 1
		write space, 1
		inc esi
		inc byte[k]
		mov al, [k]
		mov bl, [num]
		cmp al,bl
		jl d_input
	write newline,1
ret

section .bss
num RESB 1
arr resb 10
k resb 1
element resb 1
trash resb 1

section .text
global _start
_start:

	write msg, msglen
	read num, 1
	mov eax, [num]
	sub eax, '0'
	mov [num],eax
	call input
	call display
mov eax ,1
mov ebx ,0
int 80h
