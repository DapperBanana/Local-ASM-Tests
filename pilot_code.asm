
START:
    CLD
    LDA #0
    STA RESULT ; Initialize RESULT to 0

    ; Load the first set into memory
    LDA SET1, X
    STA TEMP
    INX

    ; Check for end of set
CHECK_SET1:
    LDA SET1, X
    BEQ END_SET1

    ; Check if element is already in RESULT
    LDX #0
CHECK_RESULT1:
    LDA RESULT, X
    CMP TEMP
    BEQ SKIP_ADD1
    INX
    BNE CHECK_RESULT1
    STA RESULT, X
    INX

SKIP_ADD1:
    LDA TEMP
    STA RESULT, X

    INX
    JMP CHECK_SET1

END_SET1:
    
    ; Load the second set into memory
    LDX #0
    LDA SET2, X
    STA TEMP
    INX

    ; Check for end of set
CHECK_SET2:
    LDA SET2, X
    BEQ END_SET2

    ; Check if element is already in RESULT
    LDX #0
CHECK_RESULT2:
    LDA RESULT, X
    CMP TEMP
    BEQ SKIP_ADD2
    INX
    BNE CHECK_RESULT2
    STA RESULT, X
    INX

SKIP_ADD2:
    LDA TEMP
    STA RESULT, X

    INX
    JMP CHECK_SET2

END_SET2:
    
    ; Print the union set
    LDX #0
PRINT_RESULT:
    LDA RESULT, X
    BEQ END_PRINT
    JSR $FFD2 ; Print the element
    INX
    JMP PRINT_RESULT

END_PRINT:
    BRK

SET1:
    .byte 1, 2, 3, 4, 5 ; First set
SET2:
    .byte 4, 5, 6, 7, 8 ; Second set
RESULT:
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; Result set

TEMP:
    .byte 0

    .org $fffc
    .word START ; Set reset vector
