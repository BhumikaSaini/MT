txt macro msg
lea dx, msg
mov ah, 09h
int 21h
endm

.model small
.data
askStr db, 0Ah, 0Dh, "Enter the string: $"
eql db, 0Ah, 0Dh, "Strings equal ! $"
neql db, 0Ah, 0Dh, "Strings not equal ! $"
wSOps db, 0Ah, 0Dh, "***With string operations***$"
woSOps db, 0Ah, 0Dh, "***Without string operations***$"
mStr1 db 100, ?, 100 dup("$")
mStr2 db 100, ?, 100 dup("$")

.code
mov ax, @data
mov ds, ax
mov es, ax

; accept strings
txt askStr
lea dx, mStr1
mov ah, 0Ah
int 21h
txt askStr
lea dx, mStr2
mov ah, 0Ah
int 21h

; get str lens
txt woSOps
lea si, [mStr1+1]
lea di, [mStr2+1]
mov bh, [si]
mov bl, [di]
mov cl, bh
cmp bh, bl
jne neD
l1:
inc si
inc di
mov bh, [si]
mov bl, [di]
cmp bh, bl
jne neD
dec cl
jnz l1
jz eD

neD:
txt neql
jmp nxtOp

eD:
txt eql
jmp nxtOp

nxtOp:
; get str lens
txt wSOps
lea si, [mStr1+2]
lea di, [mStr2+2]
mov cl, [si]
cld
repe cmpsb
cmp cl, 00h
jne neD2
je ed2

neD2:
txt neql
jmp termi

eD2:
txt eql
jmp termi

; terminate
termi:
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
