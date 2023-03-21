.model tiny
.data
str1	db	'Enter your name: $'

max1	db	32
act1	db	?
inp1 	db	32 dup('$')

fname	db	'testing.txt',0
handle	dw	?
.code
.startup

        LEA dx, str1
        mov ah, 09h
        int 21h
        
        LEA dx, max1
        mov ah, 0Ah
        int 21h
        
        mov ah, 3Ch
        lea dx, fname
        mov cl, 0h
        int 21h
        
        mov ah, 3dh
        mov al, 1h
        lea dx, fname
        int 21h
        mov handle, ax
       
        mov ah, 40h
        mov bx, handle
        mov cl, act1 ; cannot write cx, act1 because it is a byte and cx is a word
        lea dx, inp1
        int 21h
        
        mov ah, 3eh
        int 21h

.exit
end

