.model tiny
.data
num1 db 5
num2 db 2
fact1 db ?
fact2 db ?

.stack
stack1 dw 10 dup(0)

.code
.startup

mov bl, num1
mov dl, num1
sub dl, num2

mov cl,bl
lea si, fact1
call fact


mov cl, dl
lea si, fact2
call fact


mov ah, 00h
mov al, fact1
mov bl, fact2
div bl



fact proc
    push dx
    push ax
    mov al, 01h

x1: mul cl
    dec cl
    jnz x1
    mov [si], al
    pop ax
    pop dx
    ret
fact endp

.exit
end