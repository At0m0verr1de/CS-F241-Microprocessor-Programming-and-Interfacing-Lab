.model tiny
.386
.data
        msg1 db "Enter input : $" 
        
        usn1 db 33 dup("$")

        max1 db 33
        act1 db ?
        inp1 db 33 dup("$")


        act2 db 00
        inp2 db 33 dup("$")

        rowstr dw ?
        rowend dw ?
        colmstr dw ?
        colmend dw ?
        cnt db ?

        nline db 0ah,0dh,"$"

        fname1 db 'lab.txt',0
   
        handle1 dw ?
        handle2 dw ?




.code
.startup


    ; Put 12th byte of file in usn1
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

    ; Take input from the user and store it in inp1.
        mov ah, 08h 
        int 21h


    ; Compare the entered input with 12th byte of file
        lea si, usn1
        add si, 0Bh
        mov bl, [si]
        cmp al, bl
        jz P1

;if the input is not same, then display pattern 2
    P2:
        MOV AH, 00H
        MOV AL, 12H
        INT 10H

        ; Set cursor position to (20, 20)
        MOV AH, 02H
        MOV DH, 20
        MOV DL, 20
        MOV BH, 00
        INT 10H

        ; Initialize parameters for box drawing
        MOV rowstr, 10
        MOV rowend, 200
        MOV colmstr, 10
        MOV colmend, 210
        MOV cnt, 00

    ; Paint the first box
    PAINT3:
        MOV SI, rowstr ; Row start
    
    COLM3:
        MOV CX, colmend ; Column end
    
    ROW3:
        DEC CX
        MOV DI, CX
        PUSH CX
        MOV AH, 0Ch
        MOV AL, 1010b ; Color for first box
        MOV CX, DI
        MOV DX, SI
        INT 10h
        POP CX
        CMP CX, colmstr ; Column start
        JNZ ROW3
        INC SI
        MOV AX, rowend ; Row end
        CMP SI, AX
        JNZ COLM3

    ; Change vertices for the next box
        LEA SI, rowstr
        ADD WORD PTR[SI], 10
    ;    LEA SI, rowend
    ;    SUB WORD PTR[SI], 10
    ;    LEA SI, colmstr
    ;    ADD WORD PTR[SI], 10
    ;    LEA SI, colmend
    ;    SUB WORD PTR[SI], 10
        LEA SI, cnt
        INC BYTE PTR[SI]

        MOV AL, 12h
        MOV BL, cnt
        CMP BL, AL
        JGE TERM ; Terminate if cnt >= 7

        ; Paint the second box
        MOV SI, rowstr ; Row start
    
    COLM4:
        MOV CX, colmend ; Column end
    
    ROW4:
        DEC CX
        MOV DI, CX
        PUSH CX
        MOV AH, 0Ch
        MOV AL, 1101b ; Color for second box
        MOV CX, DI
        MOV DX, SI
        INT 10h
        POP CX
        CMP CX, colmstr ; Column start
        JNZ ROW4
        INC SI
        MOV AX, rowend ; Row end
        CMP SI, AX
        JNZ COLM4

        ; Change vertices for the next box
        LEA SI, rowstr
        ADD WORD PTR[SI], 10
        ;LEA SI, rowend
        ;SUB WORD PTR[SI], 10
        ;LEA SI, colmstr
        ;ADD WORD PTR[SI], 10
        ; LEA SI, colmend
        ;SUB WORD PTR[SI], 10
        LEA SI, cnt
        INC BYTE PTR[SI]

        JMP PAINT3 ; Continue painting boxes



        
 
    ; If the input is same, display the first pattern
    P1: 
        ; Set display mode to 640x480 16 colors
        MOV AH, 00H
        MOV AL, 12H
        INT 10H

        ; Set cursor position to (20, 20)
        MOV AH, 02H
        MOV DH, 20
        MOV DL, 20
        MOV BH, 00
        INT 10H

        ; Initialize parameters for box drawing
        MOV rowstr, 10
        MOV rowend, 200
        MOV colmstr, 10
        MOV colmend, 210
        MOV cnt, 00

    ; Paint the first box
    PAINT1:
        MOV SI, rowstr ; Row start
    
    COLM1:
        MOV CX, colmend ; Column end
    
    ROW1:
        DEC CX
        MOV DI, CX
        PUSH CX
        MOV AH, 0Ch
        MOV AL, 1101b ; Color for first box
        MOV CX, DI
        MOV DX, SI
        INT 10h
        POP CX
        CMP CX, colmstr ; Column start
        JNZ ROW1
        INC SI
        MOV AX, rowend ; Row end
        CMP SI, AX
        JNZ COLM1

        ; Change vertices for the next box
        LEA SI, rowstr
        ADD WORD PTR[SI], 10
    ;    LEA SI, rowend
    ;    SUB WORD PTR[SI], 10
    ;    LEA SI, colmstr
    ;    ADD WORD PTR[SI], 10
    ;    LEA SI, colmend
    ;    SUB WORD PTR[SI], 10
        LEA SI, cnt
        INC BYTE PTR[SI]

        MOV AL, 12h
        MOV BL, cnt
        CMP BL, AL
        JGE TERM ; Terminate if cnt >= 7

        ; Paint the second box
        MOV SI, rowstr ; Row start
        
    COLM2:
        MOV CX, colmend ; Column end
        
    ROW2:
        DEC CX
        MOV DI, CX
        PUSH CX
        MOV AH, 0Ch
        MOV AL, 1010b ; Color for second box
        MOV CX, DI
        MOV DX, SI
        INT 10h
        POP CX
        CMP CX, colmstr ; Column start
        JNZ ROW2
        INC SI
        MOV AX, rowend ; Row end
        CMP SI, AX
        JNZ COLM2

        ; Change vertices for the next box
        LEA SI, rowstr
        ADD WORD PTR[SI], 10
        ;LEA SI, rowend
        ;SUB WORD PTR[SI], 10
        ;LEA SI, colmstr
        ;ADD WORD PTR[SI], 10
    ; LEA SI, colmend
        ;SUB WORD PTR[SI], 10
        LEA SI, cnt
        INC BYTE PTR[SI]

        JMP PAINT1 ; Continue painting boxes

    END1:
        MOV AH, 07H
        INT 21h
        CMP AL, "%"
        JNZ END1 ; Loop until '%' is received

    TERM:
        MOV AH, 4CH ; Terminate program
        INT 21H


   
    lea si,colmstr
    lea si,colmstr
    lea si,colmstr
    lea si,colmstr
    lea si,colmstr
    lea si,colmstr
    lea si,colmstr
   

.exit
end
