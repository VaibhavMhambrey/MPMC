section .data
msg1 db 'More than 5: ' 
msg1len equ $-msg1
msg2 db 'Less than 5: ' 
msg2len equ $-msg2
newline db '',10
n1 equ $-newline
msg3 db 'Enter number of elements : '
msg3len equ $-msg3
msg4 db 'Enter elements in array : '
msg4len equ $-msg4
arr db 0,0,0,0,0,0,0,0,0,0
len equ 10

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
%endmacro

count:
	mov eax, 0
	mov [more],eax
	mov [less], eax
	mov ecx, [num]
	sub ecx, '0'
	mov esi, 0
	label:
	movzx edi, byte[arr+esi]
	mov [temp],edi 
	mov al,[temp]
	mov bl,5
	cmp al, bl
	jg l1
	inc byte[less]
	jmp end
	l1:
	inc byte[more]
	end:
	inc esi
	loop label
	mov eax, [less]
	add eax, '0'
	mov [less], eax
	mov eax, [more]
	add eax, '0'
	mov [more], eax
ret

section .bss
more resb 1
less resb 1
temp resb 5
i resb 1
element resb 2
num resb 2

section .text
global _start
_start:
	write msg3, msg3len
	read num,2
	write msg4, msg4len
	mov byte[i], 0
	mov esi, arr
	input:
		read element, 2
		mov ebx, [element]
		sub ebx, '0'
		mov [esi], ebx
		inc esi
		inc byte[i]
		mov al, [i]
		mov bl, [num]
		sub bl,'0'
		CMP al,bl
		JL input
	call count
	write msg1,msg1len
	write more,1
	write newline,n1
	write msg2,msg2len
	write less, 1
	write newline,n1
	mov eax ,1
	mov ebx ,0
	int 80h
