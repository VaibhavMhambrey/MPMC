section .data
	msg db "Enter number of elements: "
	msglen equ $-msg
	msg2 db "Enter elements: "
	msg2len equ $-msg2
	msg3 db "Enter element to search: "
	msg3len equ $-msg3
	msg4 db "Found at index: "
	msg4len equ $-msg4
	msg5 db "Not found"
	msg5len equ $-msg5
	newline db 10
	space db ' '

%macro write 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
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
	mov byte[i], 0
	mov esi, arr
	l_input:
		read element, 1
		mov ebx, [element]
		sub ebx, '0'
		mov [esi], ebx
		inc esi
		inc byte[i]
		mov al, [i]
		mov bl, [num]
		sub bl,'0'
		CMP al,bl
		JL l_input
ret

binary_search:
	mov eax,0
	mov [lb],eax
	mov eax,[num]
	sub eax, '0'
	sub eax,1
	mov [ub],eax
	
  label:
  	mov al,[lb]
  	mov bl,[ub]
  	add al,bl
  	mov bl,2
  	cbw
  	div bl
  	mov bl,[key]
  	sub bl,'0'
  	movzx esi,al
  	mov cl,[arr+esi]
  	cmp cl, bl
  	jl update_low
  	jg update_up
  	add al,'0'
  	mov [mid],al
  	write msg4,msg4len
  	write mid,1
  	write newline,1
  	mov eax,1
  	mov ebx,0
  	int 80h
  update_low:
  	add al,1
  	mov [lb],al
  	jmp compare
  update_up:
  	sub al,1
  	mov [ub],al
  	jmp compare
  compare:
  	mov al,[lb]
  	mov bl,[ub]
  	cmp al,bl
  	jle label
  	write msg5,msg5len
  	write newline,1
ret
  	
section .bss
	num resb 1
	key resb 1
	arr resb 10
	element resb 1
	i resb 1
	lb resb 2
	ub resb 2
	mid resb 1
	trash resb 1

section .text
global _start

_start:
	write msg,msglen
	read num,1
	write msg2,msg2len
	call input
	write msg3,msg3len
	read key,1
	call binary_search
	mov eax,1
  	mov ebx,0
  	int 80h
