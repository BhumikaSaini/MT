txt macro msg
lea dx, msg
mov ah, 09h
int 21h
endm

.model small
.data

n11 db ?
n12 db ?
n13 db ?
n14 db ?
n21 db ?
n22 db ?
quo1 db ?
quo2 db ?
rem1 db ?
rem2 db ?
askNum db 0Ah, 0Dh, "Enter numerator (8-digit) : $"
askDen db 0Ah, 0Dh, "Enter denominator (4-digit) : $"
showQuo db 0Ah, 0Dh, "Quotient ---> $"
showRem db 0Ah, 0Dh, "Remainder ---> $"
.code

mov ax, @data
mov ds, ax

; accept 1st no.
txt askNum
call accept
mov dh, bl
mov n11, dh
call accept
mov dl, bl
mov n12, dl
call accept
mov dh, bl
mov n13, dh
call accept
mov dl, bl
mov n14, dl

; accept 2nd no.
txt askDen
call accept
mov dh, bl
mov n21, dh
call accept
mov dl, bl
mov n22, dl


mov dh, n11
mov dl, n12
mov ah, n13
mov al, n14
mov bh, n21
mov bl, n22
div bx
mov quo1, ah
mov quo2, al
mov rem1, dh
mov rem2, dl

txt showQuo
mov bl, quo1
call disp
mov bl, quo2
call disp

txt showRem
mov bl, rem1
call disp
mov bl, rem2
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
cmp dl, 09h
jc d3
add dl, 07h
d3: add dl, 30h
mov ah, 02h
int 21h
mov dl, bl
and dl, 0Fh
cmp dl, 09h
jc d4
add dl, 07h
d4: add dl, 30h
mov ah, 02h
int 21h
ret
endp

end
