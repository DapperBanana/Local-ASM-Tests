
; Check if a given string is a valid email address
;
; Input: 
;   - String pointer in X register
; Output:
;   - Carry flag set if the string is a valid email address
;   - Zero flag set if the string is not a valid email address

START:
    LDA #$00          ; Initialize counter for '@' symbol
    STA COUNT
    LDA #$00          ; Initialize counter for '.'
    STA DOT_COUNT

CHECK_EMAIL:
    LDA $X            ; Load next character from string
    CMP #0            ; Check for null terminator
    BEQ VALID_EMAIL   ; End of string, valid email address

    CMP #'@'          ; Check for '@' symbol
    BEQ AT_FOUND
    CMP #'.'          ; Check for '.'
    BEQ DOT_FOUND

    INX               ; Move to next character
    JMP CHECK_EMAIL   ; Continue checking characters

AT_FOUND:
    INC COUNT         ; Increment '@' symbol counter
    INX               ; Move to next character
    JMP CHECK_EMAIL   ; Continue checking characters

DOT_FOUND:
    INC DOT_COUNT     ; Increment '.' counter
    INX               ; Move to next character
    JMP CHECK_EMAIL   ; Continue checking characters

VALID_EMAIL:
    LDA COUNT         ; Load count of '@' symbols
    CMP #1            ; Check for exactly one '@' symbol
    BNE NOT_VALID_EMAIL

    LDA DOT_COUNT     ; Load count of '.' symbols
    CMP #1            ; Check for exactly one '.' symbol
    BNE NOT_VALID_EMAIL

    SEC               ; Set carry flag for valid email address
    RTS

NOT_VALID_EMAIL:
    CLC               ; Clear carry flag for invalid email address
    RTS
