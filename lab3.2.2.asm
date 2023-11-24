display_string:
    mov ah, 0Eh
    mov al, [bx:si]
    cmp al, 0 
    je done_display  
    int 10h
    inc si 
    jmp display_string

read_from_diskette:
    mov ah, 02h 
    mov al, byte [N]  
    mov ch, byte [Head] 
    mov cl, byte [Sector] 
    mov dh, byte [Track]  
    mov dl, 0
    mov bx, buffer  
    int 13h  
    mov byte [error_code], ah  



display_error_code:
    mov si, error_code  
    mov bx, 0
    call display_string  


display_data:
    mov si, buffer  
    mov bx, 0
    call display_string 

pagination:
    mov ah, 0  
    int 16h  
    cmp ah, 20h  
    jne pagination_done 
    call display_data  
    jmp pagination 

done_display:


buffer: times 256 db 0
error_code: times 1 db 0



floppy_ram:
    mov ah, 02h
    mov al, 30
    mov ch, 35
    mov cl, 2
    mov dl, 0
    mov dh, 0
    mov es , bx 
    mov bx , 7e00h
    int 13h


    ; 631 = 35 * 18 + 1
    ; track = 35
    ; sector = 2