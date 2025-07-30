
    .org $0200       ; Start address of the program
    
start:
    LDA #$00         ; Initialize the word count to 0
    STA wordCount
    
nextChar:
    LDA $4000,X      ; Load the next character from the text file
    CMP #$20         ; Compare the character to a space
    BEQ spaceFound   ; Branch if it's a space
    CMP #$0D         ; Compare the character to a carriage return
    BEQ endOfFile    ; Branch if it's the end of the file
    INX              ; Increment the index
    JMP nextChar
    
spaceFound:
    INX              ; Increment the index to skip the space
    LDA $4000,X      ; Load the next character
    CMP #$20         ; Compare the character to a space
    BEQ spaceFound   ; Keep skipping consecutive spaces
    INX              ; Increment the word count
    INC wordCount
    JMP nextChar

endOfFile:
    LDA wordCount    ; Load the word count
    STA $C000        ; Store it in memory location $C000
    
    BRK              ; End of the program

wordCount:
    .byte $00        ; Counter for the word count

    .end start       ; End of the program
