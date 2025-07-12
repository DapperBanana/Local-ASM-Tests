
COUNT_CHARS:

    LDX #0             ; Initialize index for string
    LDY #0             ; Initialize index for characters
    STY INDEX          ; Store index for characters
    STY COUNT          ; Store count for characters

LOOP:
    LDA STRING,X       ; Load the character from the string
    BEQ END            ; Exit loop if end of string reached
    
    LDX #0             ; Reset index for characters
    
CHECK_CHARS:
    CMP CHARACTERS,X   ; Compare the character with the characters array
    BEQ CHAR_FOUND     ; Branch if character found
    
    INX                ; Increment index for characters
    CPX #NUM_CHARS     ; Check if end of characters array reached
    BNE CHECK_CHARS    ; Loop until all characters checked
    
    INY                ; Increment index for characters
    STY INDEX          ; Store index for characters
    LDA STRING,X       ; Load next character from string
    JMP LOOP           ; Continue loop
    
CHAR_FOUND:
    LDA COUNT,X        ; Load current count for character
    INY                ; Increment count
    STA COUNT,X        ; Store new count for character
    BRA LOOP           ; Continue loop

END:
    BRK

STRING:
    .ASCII "HELLO"     ; Input string to count characters
    .BYTE 0            ; Null terminator for end of string
    
CHARACTERS:
    .ASCII "ABCDEFGHIJKLMNOPQRSTUVWXYZ"  ; Characters array to check for

NUM_CHARS = *-CHARACTERS

COUNT:
    .BYTE 0            ; Array to store count of each character

INDEX:
    .BYTE 0            ; Index for characters array

    .ORG $FFFC
    .WORD START

START:
    JSR COUNT_CHARS    ; Call the COUNT_CHARS subroutine
    BRK
