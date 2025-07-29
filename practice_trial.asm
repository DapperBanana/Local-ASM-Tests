
ORG $0200

LDA #$00        ; Load accumulator with null terminator
STA $03FE       ; Initialize end of the string

LDX #$00        ; Initialize counter for current position in the string

LOOP:
    LDA $0200,X     ; Load character from string into accumulator
    CMP #$20        ; Compare character to space
    BCC NOT_PUNCT   ; Branch if character is not a punctuation

    AND #%11111110  ; Clear bit 0 to remove punctuation
    STA $0200,X     ; Store character back into string
    
NOT_PUNCT:
    INX             ; Increment counter
    BNE LOOP        ; Continue until zero page overflow
    
BRK               ; Exit program

ORG $FC00

STRING:
    .BYTE "Hello, World! How are you?", $00

