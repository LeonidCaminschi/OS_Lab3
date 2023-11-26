org 7c00h

;Leonid Caminschi
mov ch, 12              ;211/18 = nr of track
mov cl, 13               ;211 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group1)
mov bx, Name_Group1    ; Move Name_Group1 address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h

mov ch, 13              ;240/18 = nr of track
mov cl, 6               ;240 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group1)
mov bx, Name_Group1    ; Move Name_Group1 address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h

;Georgeana Globa
mov ch, 23              ;421/18 = nr of track
mov cl, 7               ;421 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group2)
mov bx, Name_Group2    ; Move Name_Group2 address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h

mov ch, 25              ;450/18 = nr of track
mov cl, 0               ;450 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group2)
mov bx, Name_Group2    ; Move Name_Group2 address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h


;Dan Hariton
mov ch, 27              ;481/18 = nr of track
mov cl, 13               ;481 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group3)
mov bx, Name_Group3   ; Move Name_Group3 address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h

mov ch, 28              ;510/18 = nr of track
mov cl, 6               ;510 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group3)
mov bx, Name_Group3    ; Move Name_Group3 address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h


;Ion Rotaru
mov ch, 35              ;631/18 = nr of track
mov cl, 1               ;631 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group4)
mov bx, Name_Group4    ; Move Name_Group4 address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h

mov ch, 37              ;660/18 = nr of track
mov cl, 12               ;660 mod 18 = nr os sector
mov dl, 0   
mov dh, 0
mov ax, 0               ; Clear AX
mov es, ax               ; Set ES to 0 (segment of Name_Group4)
mov bx, Name_Group4    ; Move Name_Group4 address to BX
mov ax, 0301h            ; Set AH to 03 (write sectors) and AL to 01 (sector count)
int 13h


Name_Group1 times 10 db "@@@FAF-211 Leonid CAMINSCHI###", 0
Name_Group2 times 10 db "@@@FAF-211 Georgeana GLOBA###", 0
Name_Group3 times 10 db "@@@FAF-211 Dan HARITON###", 0
Name_Group4 times 10 db "@@@FAF-211 Ion ROTARU###", 0
