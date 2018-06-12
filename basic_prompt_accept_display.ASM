strgs macro msg
lea dx, msg
mov ah, 09h
int 21h
endm

.model small

.data
n db 1
x db ?
askTerms db 0Ah, 0Dh, "Number of terms (enter as 2-digit): $"
askNum db 0Ah, 0Dh, "Enter a 2-digit number: $"
showNum db 0Ah, 0Dh, "You entered: $"

.code

mov ax, @data
mov ds, ax

strgs askTerms
call accept
mov n, bl
mov cl, [n]
l1:
strgs askNum
call accept
mov x, bl
strgs showNum
mov bl, [x]
call disp
dec cl
jnz l1

mov ah, 4ch
int 21h

accept proc near
mov ah, 01h
int 21h
cmp al, 3Ah
jc d1
sub al, 07h
d1:
and al, 0Fh
mov bl, al
rol bl, 04h
mov ah, 01h
int 21h
cmp al, 3Ah
jc d2
sub al, 07h
d2:
and al, 0Fh
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
d3:
add dl, 30h
mov ah, 02h
int 21h
mov dl, bl
and dl, 0Fh
cmp dl, 0Ah
jc d4
add dl, 07h
d4:
add dl, 30h
mov ah, 02h
int 21h
ret
endp

end
