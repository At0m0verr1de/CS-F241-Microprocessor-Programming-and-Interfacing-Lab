.model tiny
.data
.code
.startup
    mov ax, 1133h

    mov ch, ah
    mov ah, al
    mov al, ch
    mov bx, ax
    
    mov [bx+20], bx

.exit
end