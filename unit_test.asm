
; Load the addresses of the two strings into registers
    LDX #STR1
    LDY #STR2
    
; Start comparing characters from the first string
COMPARE:
    LDA (X),Y   ; Load a character from the first string
    CMP (Y),Y   ; Compare it with a character from the second string
    
    BEQ MATCH   ; If characters match, go to MATCH
    BEQ DONE    ; If end of string is reached, go to DONE
    
    INX         ; Move to the next character in the first string
    INY         ; Move to the next character in the second string
    BNE COMPARE ; Continue comparing characters
    
MATCH:
    ; Print or store the common character
    STA COMMON
    
    INX         ; Move to the next character in the first string
    INY         ; Move to the next character in the second string
    BNE COMPARE ; Continue comparing characters
    
DONE:
    RTS         ; End of program
    
; Strings to compare
STR1: .BYTE "HELLO",0
STR2: .BYTE "WORLD",0

COMMON: .BYTE 0
