.model small
.data

.code

mov ax, @data
mov ds, ax

; Accept tens place
mov ah, 01h
int 21h
cmp al, 3Ah
jc d1
sub al, 07h
d1: and al, 0fh
mov bl, al
rol bl, 04h

; Accept ones place
mov ah, 01h
int 21h
cmp al, 3Ah
jc d2
sub al, 07h
d2: and al, 0fh
add bl, al

; Display tens place
mov dl, bl
and dl, 0f0h
ror dl, 04h
cmp dl, 09h
jc d3
add dl, 07h
d3: add dl, 30h
mov ah, 02h
int 21h

; Display ones place
mov dl, bl
and dl, 0fh
cmp dl, 09h
jc d4
add dl, 07h
d4: add dl, 30h
mov ah, 02h
int 21h

mov ah, 4ch
int 21h
end
