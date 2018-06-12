.model small
.data

.code

mov ax, @data
mov ds, ax

; Accept tens place of 1st no.
mov ah, 01h
int 21h
mov bl, al
cmp bl, 3Ah
jc d1
sub bl, 07h
d1: and bl, 0fh
rol bl, 04h

; Accept ones place of 1st no.
mov ah, 01h
int 21h
cmp al, 3Ah
jc d2
sub al, 07h
d2: and al, 0fh
add bl, al

; Accept tens place of 2nd no.
mov ah, 01h
int 21h
mov cl, al
cmp cl, 3Ah
jc d3
sub cl, 07h
d3: and cl, 0fh
rol cl, 04h

; Accept ones place of 2nd no.
mov ah, 01h
int 21h
cmp al, 3Ah
jc d4
sub al, 07h
d4: and al, 0fh
add cl, al

; Add the 2 nos.
add bl, cl
mov cl, bl

; Display tens place of answer
and bl, 0f0h
ror bl, 04h
cmp bl, 09h
jc d5
add bl, 07h
d5: add bl, 30h
mov dl, bl
mov ah, 02h
int 21h

; Display ones place of answer
mov bl, cl
and bl, 0fh
cmp bl, 09h
jc d6
add bl, 07h
d6: add bl, 30h
mov dl, bl
mov ah, 02h
int 21h

mov ah, 4ch
int 21h
end

