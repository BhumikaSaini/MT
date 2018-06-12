txt macro msg
lea dx, msg
mov ah, 09h
int 21h
endm

.model small
.data
askNum db 0Ah, 0Dh, "Enter numerator (4-digit) : $"
askDen db 0Ah, 0Dh, "Enter denominator (2-digit) : $"
showQuo db 0Ah, 0Dh, "Quotient ---> $"
showRem db 0Ah, 0Dh, "Remainder ---> $"
n1 dw ?
n2 db ?
quo db ?
rem db ?

.code

mov ax, @data
mov ds, ax

; accept 1st no.
txt askNum
call accept
mov dh, bl
call accept
mov dl, bl
mov n1, dx

; accept 2nd no.
txt askDen
call accept
mov n2, bl

mov ax, n1
mov bl, n2
div bl
mov quo, al
mov rem, ah

txt showQuo
mov bl, quo
call disp
txt showRem
mov bl, rem
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