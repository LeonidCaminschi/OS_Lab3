org 7c00h

mov ch, 35
mov cl, 1
mov dl, 0
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Memory_Buffer)
mov bx, Name_Group    ; Move Memory_Buffer address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h

Name_Group times 10 db "@@@FAF-211 Rotaru Ion###", 0