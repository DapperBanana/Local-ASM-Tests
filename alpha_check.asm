
ORG $0200   ; Start program at address $0200

START:
    LDX #$00   ; Initialize X register to point to first character of first string
    LDY #$00   ; Initialize Y register to point to first character of second string

COMPARE_LOOP:
    LDA (STRING1, X)   ; Load character from first string
    CMP (STRING2, Y)   ; Compare character with character from second string
    BEQ FOUND_COMMON   ; If characters are the same, jump to FOUND_COMMON
    
    INY   ; Increment Y to move to next character in second string
    CPY #LENGTH2   ; Compare Y with length of second string
    BNE COMPARE_LOOP   ; If Y is not equal to length of second string, continue loop
    
    INX   ; Increment X to move to next character in first string
    CPX #LENGTH1   ; Compare X with length of first string
    BNE COMPARE_LOOP   ; If X is not equal to length of first string, continue loop
    
    JMP END   ; If program reaches here, common characters not found
    
FOUND_COMMON:
    STA RESULT, X   ; Store common character in RESULT string
    INX   ; Increment X
    CPX #LENGTH1   ; Compare X with length of first string
    BNE COMPARE_LOOP   ; If X is not equal to length of first string, continue loop
    
END:
    BRK   ; End program

STRING1:
    .BYTE "HELLO"
LENGTH1 = * - STRING1

STRING2:
    .BYTE "WORLD"
LENGTH2 = * - STRING2

RESULT:
    .BYTE $00   ; Initialize empty string for storing common characters
    
    .ORG $FFFA   ; Interrupt vector table
    .WORD START   ; Initialize reset vector to point to START

    .END   ; End of program
