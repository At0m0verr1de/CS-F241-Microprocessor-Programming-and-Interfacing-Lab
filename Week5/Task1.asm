.model tiny
.data
res1 db 'The character entered is a$'
res2 db 'not a$'
.code
.startup

        mov ah,08h
        int 21h
        cmp al,61h
        je X1
        lea dx, res2
        jmp X3
    X1: lea dx, res1
    X3: mov ah,09h
        int 21h

.exit
end