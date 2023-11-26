org 7c00h

mov ch, 35              ;631/18 = nr of track
mov cl, 1               ;631 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group)
mov bx, Name_Group    ; Move Name_Group address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h

mov ch, 37              ;660/18 = nr of track
mov cl, 12               ;660 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group)
mov bx, Name_Group    ; Move Name_Group address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h

Name_Group times 10 db "@@@FAF-211 Rotaru Ion###", 0