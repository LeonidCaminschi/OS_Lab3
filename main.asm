org 7c00h            ; Set the origin of the program to 7c00h (where bootloaders usually start)

load_memory:
	mov ah, 02h         ; Set the function to read disk sectors
	mov al, 4           ; Number of sectors to read
	mov cx, 2           ; Cylinder and sector
	mov dh, 0           ; Head
	mov dl, 0           ; Drive (0 for floppy)
	mov bx, 0           ; Memory buffer
	mov es, bx          ; Set ES to 0
	mov bx, 7e00h       ; Buffer destination address
	int 13h             ; Invoke BIOS disk I/O function

	mov ah, 02h         ; Set the function to set cursor position
	mov bh, 0           ; Page number
	mov dh, -1          ; Row (0-based)
	mov dl, 0           ; Column (0-based)
	int 10h             ; Invoke BIOS video function

init_prompt:
	mov word [pointer], prompt    ; Load the address of the prompt string
	call set_string_to_buffer    ; Copy the prompt to the buffer

	mov byte [move_next], 0     ; Clear the move_next flag
	call echo

write_chr:
	mov ah, 0
	int 16h             ; Wait for a keyboard keypress

	cmp ah, 0eh         ; Check if Backspace was pressed
	je press_backspace
	cmp ah, 1ch         ; Check if Enter was pressed
	je press_enter
	
	cmp al, 20h         ; Check if the character is a space
	jl write_chr        ; Ignore non-printable characters

	cmp si, buffer + 256  ; Check if the buffer is full
	je write_chr

	mov [si], al         ; Store the character in the buffer
	inc si

	mov ah, 09h         ; Set the function to print character with attribute
	mov bl, 07h         ; Attribute (white on black)
	mov cx, 1           ; Number of characters to print
	int 10h             ; Invoke BIOS video function

	mov ah, 03h         ; Set the function to get cursor position
	mov bh, 0           ; Page number
	int 10h             ; Invoke BIOS video function

	mov ah, 02h         ; Set the function to set cursor position
	cmp dl, 79          ; Check if the cursor is at the end of the line
	jl prompt_cursor
	inc dh
	mov dl, -1

prompt_cursor:
	inc dl
	int 10h             ; Move the cursor

	cmp dh, 24           ; Check if the cursor is at the bottom of the screen
	jl write_chr

	cmp dl, 79           ; Check if the cursor is at the end of the line
	jl write_chr

	mov ah, 06h          ; Set the function to scroll the screen up
	mov al, 1            ; Number of lines to scroll
	mov bh, 07h          ; Attribute (white on black)
	mov cx, 0            ; Upper-left corner
	mov dx, 184fh        ; Lower-right corner
	int 10h              ; Invoke BIOS video function

	mov ah, 02h         ; Set the function to set cursor position
	mov bh, 0           ; Page number
	mov dx, 174fh       ; New cursor position
	int 10h             ; Invoke BIOS video function

	jmp write_chr       ; Continue writing characters

press_backspace:
	cmp si, buffer       ; Check if the buffer is empty
	je write_chr

	sub si, 1             ; Move the buffer pointer back
	mov byte [si], 0     ; Clear the character

	mov ah, 03h         ; Set the function to get cursor position
	mov bh, 0           ; Page number
	int 10h             ; Invoke BIOS video function

	cmp dl, 0           ; Check if the cursor is at the beginning of the line
	jz previous_line
	jmp write_space

previous_line:
	mov ah, 02h         ; Set the function to set cursor position
	mov dl, 79           ; Move to the end of the previous line
	sub dh, 1            ; Move up one line
	int 10h              ; Invoke BIOS video function

write_space:
	mov ah, 02h         ; Set the function to set cursor position
	sub dl, 1            ; Move left one character
	int 10h              ; Invoke BIOS video function

	mov ah, 0ah         ; Set the function to print character with attribute
	mov al, 20h         ; Space character
	mov cx, 1           ; Number of characters to print
	int 10h             ; Invoke BIOS video function
	jmp write_chr        ; Continue writing characters

press_enter:
	cmp si, buffer       ; Check if the buffer is empty
	je init_prompt

	mov ecx, commands          ; Load the address of the commands
	sub ecx, 4                ; Start from the last command

next_command:
	add ecx, 4                ; Move to the next command

	cmp dword [ecx], 0         ; Check if the command is null-terminated
	je command_echo

	mov edi, [ecx]             ; Load the address of the current command
	mov si, buffer             ; Load the address of the buffer

command_string_cmp_loop:
	cmp byte [si], 20h         ; Check if the buffer character is a space
	je command_length_check

	cmp byte [si], 0           ; Check if the buffer character is null-terminated
	je command_length_check

	cmp byte [edi], 0          ; Check if the command character is null-terminated
	je next_command

	mov bl, [si]               ; Load the buffer character
	cmp bl, [edi]              ; Compare it with the command character
	jne next_command

	inc si
	inc edi

	jmp command_string_cmp_loop

command_length_check:
	cmp byte [edi], 0         ; Check if the command string is null-terminated
	jne next_command

	add ecx, commands_names    ; Load the address of the command names
	sub ecx, commands          ; Calculate the index of the command

	cmp word [ecx], echo      ; Check if the command is "echo"
	jne command_call

	mov di, buffer              ; Load the address of the buffer
	mov si, buffer              ; Load the address of the buffer

command_call:
	mov byte [move_next], 1    ; Set the move_next flag
	call dword [ecx]           ; Call the command function
	jmp init_prompt

command_echo:
	mov byte [move_next], 1    ; Set the move_next flag
	call echo                  ; Call the echo function
	jmp init_prompt

echo:
	inc si                     ; Increment the buffer pointer
	cmp byte [si], 0           ; Check if the buffer character is null-terminated
	jne echo

	mov ah, 03h                ; Set the function to get cursor position
	mov bh, 0                  ; Page number
	int 10h                    ; Invoke BIOS video function

	sub si, buffer             ; Subtract the buffer address to get the length of the string
	jz clear_buffer            ; If the string is empty, clear the buffer

	cmp dh, 24                 ; Check if the cursor is at the bottom of the screen
	jl print_word

	mov ah, 06h                ; Set the function to scroll the screen up
	mov al, 1                  ; Number of lines to scroll
	mov bh, 07h                ; Attribute (white on black)
	mov cx, 0                  ; Upper-left corner
	mov dx, 184fh              ; Lower-right corner
	int 10h                    ; Invoke BIOS video function

	mov dh, 17h                ; Reset the cursor row

	cmp byte [line], 1        ; Check if line flag is set
	jne print_word

	mov ah, 03h                ; Set the function to get cursor position
	mov bh, 0                  ; Page number
	int 10h                    ; Invoke BIOS video function
	dec dh

print_word:
	mov bh, 0                  ; Page number
	mov ax, 0                  ; Video page
	mov es, ax                 ; Set ES to 0
	mov bp, buffer             ; Load the address of the buffer

	mov bl, 07h                ; Attribute (white on black)
	mov cx, si                 ; String length
	dec dl                     ; Decrement column position
	cmp byte [line], 1        ; Check if line flag is set
	je write_word

	inc dh                     ; Increment row position
	mov dl, 0                  ; Reset column position
	jmp write_word

write_word:
	mov ax, 1301h              ; Set the function to write a string
	int 10h                    ; Invoke BIOS video function

clear_buffer:
	mov si, buffer              ; Load the address of the buffer

clear_buffer_loop:
	mov byte [si], 0            ; Clear each character in the buffer
	inc si
	cmp byte [si], 0
	jne clear_buffer_loop
	mov si, buffer              ; Reset the buffer pointer
	ret

set_string_to_buffer:
	call clear_buffer           ; Clear the buffer
	mov di, [pointer]           ; Load the address of the source string
	mov si, buffer              ; Load the address of the buffer

str_set_buffer:
	mov bl, [di]                ; Load a character from the source string
	mov byte [si], bl          ; Copy it to the buffer
	inc si
	inc di
	cmp byte [di], 0           ; Check if the source string is null-terminated
	jne str_set_buffer
	ret

write:
	ret 

align 512

line db 0             ; Variable for line flag
move_next db 0        ; Variable for move_next flag
prompt db "user:",0   ; Prompt string
pointer dw 0000h      ; Variable for the address of the prompt string

buffer: times 256 db 0h  ; Buffer for user input

command_1 db "write", 0  ; Command 4: write

commands dd command_1, 0  ; Array of command addresses
commands_names dd write          ; Array of command names

align 512
