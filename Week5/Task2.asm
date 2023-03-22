.model tiny
.data
max1 db 32
act1 db ?
inp1 db 32 dup(0)
.code
.startup

        lea dx,max1
        mov ah,0ah
        int 21h
        mov cl,act1
        lea di,inp1
    X1: mov bl,[di]
        sub bl,20h
        mov [di],bl
        inc di
        loop X1
        mov bl,24h
        mov [di],bl
        lea dx,inp1
        mov ah,09h
        int 21h

.exit
end
