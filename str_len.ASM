txt macro msg
lea dx, msg
mov ah, 09h
int 21h
endm

.model small
.data
askStr db, 0Ah, 0Dh, "Enter the string: $"
showLen db, 0Ah, 0Dh, "String length= $"
wSOps db, 0Ah, 0Dh, "***With string operations***$"
woSOps db, 0Ah, 0Dh, "***Without string operations***$"
mStr db 100, ?, 100 dup("$")

.code
mov ax, @data
mov ds, ax

txt askStr
lea dx, mStr
mov ah, 0Ah
int 21h
lea si, [mStr+2]
mov bl, 00h
l1:
mov al, [si]
inc si
inc bl
cmp al, 0Dh
jne l1
je destn

destn:
dec bl
txt wSOps
txt showLen
call disp

txt woSOps
txt showLen
lea si, [mStr+1]
mov bl, [si]
call disp

; terminate
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
