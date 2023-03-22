
.model tiny
.data
        msg1 db "Enter 10 character long User Name : $" 
        
        usn1 db 33 dup("$")

        max1 db 33
        act1 db ?
        inp1 db 33 dup("$")

        msg2 db "enter 5 character long password : $"
        
        pass1 db 33 dup("$")

        act2 db 00
        inp2 db 33 dup("$")

        msg3 db "Hello $"

        msg4 db "Wrong Username $"

        msg5 db "Wrong Password $"

        nline db 0ah,0dh,"$"

        fname1 db 'user.txt',0
        fname2 db 'pswd.txt',0
        handle1 dw ?
        handle2 dw ?




.code
.startup
    ; Display message 1 on the screen and go to the next line.
        lea dx, msg1 
        mov ah, 09h 
        int 21h

    ; Add a new line after the message.
        lea dx, nline
        mov ah, 09h
        int 21h

    ; Take input from the user and store it in inp1.
        lea dx, max1 
        mov ah, 0ah 
        int 21h

    ; Put username in usn1
        mov ah,3dh
        mov al,0h
        lea dx,fname1
        int 21h
        mov handle1,ax

        mov ah,3fh
        mov bx,handle1
        mov cx,20h
        lea dx,usn1
        int 21h    

        mov ah,3eh
        int 21h

    ; Compare the entered username with the stored username.
        cld
        lea di, inp1 
        lea si, usn1
        inc act1
        mov cx, act1
        repe cmpsb 
        jcxz l1

    ; If the username is incorrect, display the "wrong username" message and exit.
        lea dx, nline
        mov ah, 09h 
        int 21h
        lea dx, msg4 
        mov ah, 09h 
        int 21h
        mov ah, 4ch
        int 21h
        
    ; If the user name is correct, display the "enter password" message.
    l1: lea dx, nline 
        mov ah, 09h 
        int 21h
        lea dx, msg2 
        mov ah, 09h 
        int 21h
        lea dx, nline 
        mov ah, 09h 
        int 21h

    ; Take password input from the user, masking the characters.
        mov cx,20h 
        lea di, inp2 
    l2: mov ah, 08h 
        int 21h
        cmp al,nline
        je l4
        mov [di], al 
        mov dl, '*' 
        mov ah, 02h 
        int 21h
        inc di 
        inc act2
        dec cx 
        jnz l2    

    ; Put password in pass1
    l4: mov ah,3dh
        mov al,0h
        lea dx,fname2
        int 21h
        mov handle2,ax

        mov ah,3fh
        mov bx,handle2
        mov cx,20h
        lea dx,pass1
        int 21h    

        mov ah,3eh
        int 21h

    ; Compare the entered password with the stored password.
        cld
        inc act2
        mov cx, act2 
        lea di, inp2 
        lea si, pass1
        repe cmpsb 
        jcxz l3

    ; If the password is incorrect, display the "wrong password" message and exit.
        lea dx, nline 
        mov ah, 09h 
        int 21h
        lea dx, msg5 
        mov ah, 09h 
        int 21h
        mov ah, 4ch
        int 21h

   ; If the password is correct, display the greeting message and the username.
    l3: lea dx, nline 
        mov ah, 09h 
        int 21h
        lea dx, msg3 
        mov ah, 09h 
        int 21h
        lea dx, usn1 
        mov ah,09h 
        int 21h
        lea dx, nline 
        mov ah, 09h 
        int 21h 

.exit
end