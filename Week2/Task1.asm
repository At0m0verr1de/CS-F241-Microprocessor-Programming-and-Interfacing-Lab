.model tiny

.data

.code

.startup
     ; mov ah, 5bh
     ; mov al, 5dh
     ; N data.txt
     ; L 0200
     ; mov [0200 + 5], ah
     ; mov [0200 + 9], al
.exit

end