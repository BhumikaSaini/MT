.model small

.data
no1 db ?
no2 db ?
ans dw ?

.code

mov ax, @data
mov ds, ax

;accept the 2 nos
call accept
mov no1, bl
call accept
mov no2, bl

;move 1st no to al
mov al, no1
;multiply
mul no2
;ans stored in ax
mov ans, ax

; display higher byte of answer
mov bl, ah
call disp
; display lower byte of answer
mov ax, ans
mov bl, al
call disp

;terminate
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
