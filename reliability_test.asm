
* = $4000

START   LDX #$00        ; Initialize word count to 0
LOOP    LDA $4000, X    ; Load next character from text file
        BEQ END         ; Check for end of file
        CMP #$20        ; Compare character with space character
        BNE SKIP        ; Skip if character is not a space
        INX             ; Increment word count
SKIP    INX             ; Move to next character
        BNE LOOP        ; Continue looping
END     STA $4010       ; Store the word count in memory
        BRK             ; End program

* = $4010

WORD_COUNT  .byte $00    ; Word count variable
