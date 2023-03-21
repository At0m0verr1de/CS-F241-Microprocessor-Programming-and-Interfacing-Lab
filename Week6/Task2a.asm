.model tiny
.data

str1	db	'Enter your name: $'
max1	db	32
act1	db	?
inp1 	db	32 dup('$')


str2    db	'Enter your id: $'
max2	db	32
act2	db	?
inp2 	db	32 dup('$')


fname1	db	'name.txt',0
fname2 	db	'id.txt',0
handle1	dw	?
handle2	dw      ?

nline db 0ah,0dh,'$'

.code
.startup

        LEA dx, str1
        mov ah, 09h
        int 21h
        
        LEA dx, max1
        mov ah, 0Ah
        int 21h
        
        lea dx, nline
        mov ah, 09h
        int 21h

        LEA dx, str2
        mov ah, 09h
        int 21h
        
        LEA dx, max2
        mov ah, 0Ah
        int 21h
        
        lea dx, nline
        mov ah, 09h
        int 21h
        
        ;writing to name.txt
        mov ah, 3Ch
        lea dx, fname1
        mov cl, 0h
        int 21h
        
        mov ah, 3dh
        mov al, 1h
        lea dx, fname1
        int 21h
        mov handle1, ax
       
        mov ah, 40h
        mov bx, handle1
        mov cl, act1 ; cannot write cx, act1 because it is a byte and cx is a word
        lea dx, inp1
        int 21h
        
        
        ;writing to id.txt
        mov ah, 3Ch
        lea dx, fname2
        mov cl, 0h
        int 21h
        
        mov ah, 3dh
        mov al, 1h
        lea dx, fname2
        int 21h
        mov handle2, ax
       
        mov ah, 40h
        mov bx, handle2
        mov cl, act2 ; cannot write cx, act1 because it is a byte and cx is a word
        lea dx, inp2
        int 21h

        mov ah, 3eh
        int 21h
.exit
end

