txt macro msg
lea dx, msg
mov ah, 09h
int 21h
endm

.model small
.data
n1 db ?
n2 db ?
sum db ?
diff db ?
prod dw ?
choice db ?
askNum db 0Ah, 0Dh, "Enter a number (2-digit) : $"
askOp db 0Ah, 0Dh, "Enter your choice (2-digit) : $"
showSum db 0Ah, 0Dh, "Sum is ---> $"
showDiff db 0Ah, 0Dh, "Difference is ---> $"
showProd db 0Ah, 0Dh, "Product is ---> $"
header db 0Ah, 0Dh, "*******MENU*******$"
op1 db 0Ah, 0Dh, "1. Addition$"
op2 db 0Ah, 0Dh, "2. Subtraction$"
op3 db 0Ah, 0Dh, "3. Multiplication$"
op0 db 0Ah, 0Dh, "0. EXIT$"

.code

mov ax, @data
mov ds, ax

; accept 2 nos.
txt askNum
call accept
mov n1, bl
txt askNum
call accept
mov n2, bl

l1:
call showMenu
txt askOp
call accept
mov choice, bl
mov al, choice
cmp al, 01h
jne d11
call addition
d11:
mov al, choice
cmp al, 02h
jne d12
call subtract
d12:
mov al, choice
cmp al, 03h
jne d13
call multiply
d13:
mov al, choice
cmp al, 00h
jne l1

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

addition proc near
mov al, n1
add al, n2
mov sum, al
txt showSum
mov bl, sum
call disp
ret
endp

subtract proc near
mov al, n1
sub al, n2
mov diff, al
txt showDiff
mov bl, diff
call disp
ret
endp

multiply proc near
mov al, n1
mul n2
mov prod, ax
txt showProd
mov ax, prod
mov bl, ah
call disp
mov ax, prod
mov bl, al
call disp
ret
endp

showMenu proc near
txt header
txt op1
txt op2
txt op3
txt op0
ret
endp

end
