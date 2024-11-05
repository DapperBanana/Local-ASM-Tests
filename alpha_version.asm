
        .org $2000
START:  LDX #$00         ; Initialize word count to 0
        LDY #$00
LOOP:   LDA FILE,X       ; Load next character from file
        CMP #$20         ; Check if character is a space
        BEQ CHECK        ; If space, check if word has ended
        INX              ; Increment pointer to next character
        BNE LOOP         ; Loop back to read next character
CHECK:  CPX #1024        ; Check if end of file
        BEQ DONE         ; If end of file, finish
        CMP #$00         ; Check if character is null terminator
        BEQ DONE         ; If null terminator, finish
        INY               ; Increment word count
        BNE LOOP          ; Loop back to read next character
DONE:   STY WORDCNT      ; Store word count in memory location
        BRK

WORDCNT: .BYTE $00       ; Memory location to store word count
FILE:    .INCBIN "textfile.txt" ; Load text file

        .org $FFFC
        .word START
