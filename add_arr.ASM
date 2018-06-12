txt macro msg
lea dx, msg
mov ah, 09h
int 21h
endm

.model small
.data
arr1 db 10, ?, 10 dup('$')
sum db ?
askNum db 0Ah, 0Dh, "Enter a number (2-digit) : $"
showSum db 0Ah, 0Dh, "Sum is ---> $"

.code

mov ax, @data
mov ds, ax

lea si, arr1
mov cl, 0Ah
l1: 
txt askNum
call accept
mov [si], bl
inc si
dec cl
jnz l1

lea si, arr1
mov cl, 0Ah
mov al, 00h
l2: add al, [si]
inc si
dec cl
jnz l2
mov sum, al

txt showSum
mov bl, sum
call disp

mov ah, 4ch
int 21h

accept proc near
mov ah, 01h
int 21h
cmp al, 3Ah
jc d1
sub al, 07h
d1: and al, 0Fh
mov bl, al
rol bl, 04h
mov ah, 01h
int 21h
cmp al, 3Ah
jc d2
sub al, 07h
d2: and al, 0Fh
add bl, al
ret
endp

disp proc near
mov dl, bl
and dl, 0F0h
ror dl, 04h
cmp dl, 0Ah
jc d3
add dl, 07h
d3: add dl, 30h
mov ah, 02h
int 21h
mov dl, bl
and dl, 0Fh
cmp dl, 0Ah
jc d4
add dl, 07h
d4: add dl, 30h
mov ah, 02h
int 21h
ret
endp

end
