section .data
msg db 'Enter name '
msgLen equ $-msg
msg1 db 'Name: '
msg1Len equ $-msg1
 
%macro writesystem 2
	mov eax,4
	mov ebx,1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
 
%macro readsystem 2
	mov eax,3
	mov ebx,2
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

 
section .bss
n RESW 5
cnt RESB 5

section .text
global _start
 
_start:
    mov eax, 1
    mov [cnt],eax
	writesystem msg, msgLen
	readsystem n, 5
	writesystem msg1, msg1Len
    
print:
    writesystem n,5
    mov eax, [cnt]
    inc eax
    mov ebx, 9
    cmp eax,ebx
    jg exit
    mov [cnt],eax
    jmp print
exit:
    mov eax, 1
    mov ebx, 0
int 80h
	
