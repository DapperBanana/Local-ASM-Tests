
    .org $0200          ; Start program at address $0200

start:
    lda #<url          ; Load low byte of address of string into A
    ldx #>url          ; Load high byte of address of string into X
    jsr isValidURL     ; Call isValidURL subroutine
    bcc validURL       ; Branch if carry flag is clear (URL is valid)
    jmp invalidURL     ; Jump to invalidURL subroutine if URL is invalid

isValidURL:
    lda (x), y         ; Load character from string into A
    beq valid          ; If character is null terminator, URL is valid
    cmp #'a'           ; Check if character is lowercase letter
    bcs checkUpper     ; Branch if carry flag is set (i.e. character is not lowercase letter)
    cmp #'A'           ; Check if character is uppercase letter
    bcs checkDigit     ; Branch if carry flag is set (i.e. character is not uppercase letter)
    cmp #'0'           ; Check if character is digit
    bcc invalid        ; Branch if carry flag is clear (i.e. character is not digit)
    
checkUpper:
    cmp #'z'           ; Check if character is lowercase letter
    bcs invalid        ; Branch if carry flag is set (i.e. character is neither uppercase letter nor digit)
    
checkDigit:
    cmp #'9'           ; Check if character is digit
    bcc invalid        ; Branch if carry flag is clear (i.e. character is neither uppercase letter nor digit)
    
    iny                ; Increment index Y to check next character
    jmp isValidURL     ; Repeat process for next character

valid:
    clc                ; Clear carry flag to indicate valid URL
    rts                ; Return from subroutine

invalid:
    sec                ; Set carry flag to indicate invalid URL
    rts                ; Return from subroutine

validURL:
    ; Add code here to handle valid URL
    rts

invalidURL:
    ; Add code here to handle invalid URL
    rts

url:
    .ascii "http://www.example.com"  ; String to check if it is a valid URL

    .end                ; End of program
