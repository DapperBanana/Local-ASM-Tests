
        .org $0200

start   lda str        ; Load the starting address of the string into A register
        sta ptr        ; Store the starting address in a pointer
        ldx #0         ; Set index to 0
        ldy #0         ; Set counter to 0 (for @ character)

loop    lda (ptr),y    ; Load the current character of the string
        cmp #0         ; Check for end of string
        beq valid      ; Branch to valid if end of string

        cmp #'@'       ; Check for '@' character
        beq at_found   ; Branch to at_found if '@' character found

        cmp #'0'       ; Check for valid email address character
        bcc invalid    ; If character is less than '0', invalid
        cmp #'9'       ; Check for valid email address character
        bcc valid_char ; If character is less than '9', valid character
        cmp #'A'       ; Check for valid email address character
        bcc invalid    ; If character is less than 'A', invalid
        cmp #'Z'       ; Check for valid email address character
        bcc valid_char ; If character is less than 'Z', valid character
        cmp #'a'       ; Check for valid email address character
        bcc invalid    ; If character is less than 'a', invalid
        cmp #'z'       ; Check for valid email address character
        bcc valid_char ; If character is less than 'z', valid character
        cmp #'.'
        beq valid_char
        cmp #'_'
        beq valid_char
        cmp #'+'
        beq valid_char

invalid lda #0
        rts           ; Return invalid

valid_char
        iny           ; Increment counter
        inc ptr       ; Move to next character
        jmp loop      ; Continue to next character

at_found
        cpx #0         ; Check if index is 0
        bne invalid    ; If index is not 0, invalid
        inc ptr       ; Move to next character after '@'
        jmp loop      ; Continue to check characters

valid   lda #1        ; Return valid
        rts           ; Return valid

ptr     .ds 2         ; Pointer to current character
str     .byte "example@email.com",0  ; Example email address string

        .end
