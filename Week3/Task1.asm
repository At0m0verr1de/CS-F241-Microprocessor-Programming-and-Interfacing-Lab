.model tiny

.data
    array1 db 91h, 02h, 083h, 0Ah, 075h, 0Ah, 047h, 012h, 076h, 61h

.code

.startup
    mov bx, offset array1
    mov al, 0Ah
    mov cl, 0Ah
    mov dl, 65h

    check:
    cmp [bx], al
    jz found
    inc bx
    dec cl
    jnz check
    jmp finish
    found:
    mov [bx], dl
    inc bx
    dec cl
    jnz check
    finish:
.exit

end