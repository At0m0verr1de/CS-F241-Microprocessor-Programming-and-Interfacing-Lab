.model tiny
.data
fname1	db 'name.txt',0
handle1	dw ?
fname2	db	'id.txt',0
handle2	dw ?
fname3	db	'splice.txt',0
handle3	dw	?

part1		db	6 dup('$')
part2		db 13 dup('$')

.code
.startup
    ; open name.txt
    mov ah, 3dh
    mov al, 0h
    lea dx, fname1
    int 21h
    mov handle1, ax

    ; read name from name.txt
    mov ah, 3fh
    mov bx, handle1
    mov cx, 5
    lea dx, part1
    int 21h
    
    ; open id.txt
    mov ah, 3dh
    mov al, 0h
    lea dx, fname2
    int 21h
    mov handle2, ax

    ; read id from id.txt
    mov ah, 3fh
    mov bx, handle2
    mov cx, 12
    lea dx, part2
    int 21h
    
    ; create splice.txt
    mov ah, 3ch
    lea dx, fname3
    mov cl, 0h
    int 21h
    mov handle3, ax

    ; write name and id to splice.txt
    mov ah, 40h
    mov bx, handle3
    mov cx, 5
    lea dx, part1
    int 21h

    mov ah, 40h
    mov bx, handle3
    mov cx, 12
    lea dx, part2
    int 21h

    ; close name.txt
    mov ah, 3eh
    mov bx, handle1
    int 21h

    ; close id.txt
    mov ah, 3eh
    mov bx, handle2
    int 21h

    ; close splice.txt
    mov ah, 3eh
    mov bx, handle3
    int 21h

.exit
end