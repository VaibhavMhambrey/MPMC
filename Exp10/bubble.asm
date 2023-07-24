section .data
	msg db "Enter number of elements: "
	msglen equ $-msg
	msg2 db "Enter the elements in the array: "
	msg2len equ $-msg2
	msg3 db "The sorted array is: "
	msg3len equ $-msg3
	msg4 db "Pass "
	msg4len equ $-msg4
	msg5 db " : "
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
		mov eax,esi
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

bubble_sort:
	mov byte[i],0
	
  outer_loop:
	mov byte[j], -1
	  inner_loop:
	  	inc byte[j]
	  	mov al,[j]
	        mov bl,[num]
	        mov cl, [i]
	        sub bl, cl
	        sub bl, 1
	        cmp al,bl
	        jge exit
	  	movzx esi, byte[j]
	  	mov al, [arr+esi]
	  	mov bl, [arr+esi+1]
	  	cmp al,bl
	  	jle inner_loop
	  	mov [arr+esi+1],al
	  	mov [arr+esi],bl
	        jmp inner_loop
	  exit:
	  	call display
	  	inc byte[i]
	  	mov al,[i]
	        mov bl,[num]
	        sub bl, 1
	        cmp al,bl
	        jl outer_loop
ret

section .bss
	num resb 1
	arr resb 10
	element resb 1
	i resb 1
	j resb 1
	k resb 1
	trash resb 1

section .text
global _start

_start:
	write msg,msglen
	read num,1
	mov eax, [num]
	sub eax, '0'
	mov [num],eax
	write msg2,msg2len
	call input
	call bubble_sort
	
	mov eax,1
	mov ebx,0
	int 80h
