.model small
.data
B db 04,02,05,01,08
n db ($-B)
.code
mov ax,@data
mov ds,ax
mov cl,n
dec cl
outerloop:mov ch,cl
mov SI,0
innerloop:mov al,B[SI]
inc SI
cmp al,B[SI]
jb noxg
xchg al,B[SI]
mov B[SI-1],al
noxg:dec ch
jnz innerloop
dec cl
jnz outerloop
mov ah,4ch
int 21h
end
