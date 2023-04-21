.model tiny
.data
string db "ARYAN"
count db 5
.stack
stack1 dw 10 dup(0)
pointer label word
.code
.startup

    lea sp, pointer
    lea si, string
    mov cl, count
    mov ah, 00h

x1: mov al, [si]
    push ax
    inc si
    dec cl
    jnz x1

    mov cl, count
    lea si, string
x2: pop ax
    mov [si], al
    dec cl
    inc si
    jnz x2

.exit
end