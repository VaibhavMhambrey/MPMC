section .data
    string1 db "Enter size of fibo series: ", 10
    string1len equ $-string1
    string2 db "The series is: ", 10
    string2len equ $-string2
    newline db '', 10
    nl equ $-newline

%macro write_string_number 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read_number 1
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, 5
    int 80h
%endmacro

%macro addition 3
    mov eax, [%1]
    sub eax, '0'
	mov ebx, [%2]
    sub ebx, '0'
    add eax, ebx
    add eax, '0'
	mov [%3], eax
%endmacro

fibonacci:
    mov al,[num]
    sub al, '0'
    mov bl, 0
    cmp al, bl
    je  exit

    mov al, '0'
    mov [a], al
    write_string_number a, 5
    write_string_number newline, nl
    mov al,[num]
    sub al, '0'
    mov bl, 1
    cmp al, bl
    je  exit

    mov al, '1'
    mov [b], al
    write_string_number b, 5
    write_string_number newline, nl
    mov al,[num]
    sub al, '0'
    mov bl, 2
    cmp al, bl
    je  exit

    mov eax, '2'
    mov [count], eax
    L1:
        addition a, b, c
        write_string_number c, 9
        write_string_number newline, nl 
        mov eax, [b]
        mov [a], eax
        mov eax, [c]
        mov [b], eax
        mov eax, [count]
        inc eax
        mov [count], eax
        mov al, [count]
        mov bl, [num]
        cmp al, bl
        jl L1
    exit:
ret

section .bss
    num resb 5
    a resb 5
    b resb 5
    c resb 5
    inter resb 5
    count resb 5

section .text 
    global _start
_start: 

    write_string_number string1, string1len
    read_number num

    write_string_number string2, string2len
    call fibonacci

    mov eax, 1
    mov ebx, 0
    int 80h
