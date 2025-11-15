
.org $0200

START:
    LDX #$00            ; Initialize X register to 0
    LDA message,X       ; Load first character of string into A register
    BEQ END             ; If end of string is reached, go to END
LOOP:
    CMP #32             ; Compare with ASCII value for space character
    BEQ SPACE_FOUND     ; If space character is found, go to SPACE_FOUND
    INX                 ; Increment X register
    LDA message,X       ; Load next character of string into A register
    BNE LOOP            ; If not end of string, go back to LOOP

END:
    RTS                 ; Return from subroutine

SPACE_FOUND:
    INX                 ; Increment X register to skip space character
    LDA word_count,X    ; Load current word count into A register
    INX                 ; Increment X register
    CLC                 ; Clear carry flag
    ADC #1              ; Increment word count
    STA word_count,X    ; Store updated word count
    BRA LOOP            ; Go back to LOOP

.word_count:            ; Array to store word counts (initialized to zero)
    .byte 0,0,0,0,0

message:
    .asciiz "hello world hello hello world"

    .end
