.model tiny

.data
    array1 db 91h, 02h, 083h, 0Ah, 075h, 0Ah, 047h, 012h, 076h, 61h
    count db 0Ah
    NEG1 db ?

.code

.startup
    mov bx, offset array1
    mov al, 00h
    mov cl, 0Ah ; total elements
    mov dl, 00h ; maintain count
    
    check:
    cmp [bx], al
    jl found ; if less than 0, then found
    inc bx
    dec cl
    jnz check
    jmp finish
    found:
    inc dl ; increment count
    inc bx
    dec cl
    jnz check
    finish:
    mov NEG1, dl ; store count in NEG1
.exit

end