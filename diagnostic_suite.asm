
COUNT_WORDS:
    LDX #0      ; Initialize index register to 0
    LDY #0      ; Initialize Y register as counter for words
    LDA $1000,X ; Load the first character from the text file
    BEQ END     ; Branch to END if end of file is reached

NEXT_CHAR:
    CMP #$20    ; Compare the current character to a space (ASCII value 32)
    BEQ CHECK_SPACE ; Check if the character is a space
    INX         ; Increment index register to move to the next character
    BNE NEXT_CHAR ; Branch to NEXT_CHAR

CHECK_SPACE:
    INX         ; Increment index to skip the space
    LDA $1000,X ; Load the next character after the space
    CMP #$20    ; Compare the character to a space
    BEQ CHECK_SPACE ; Check next character if it is a space
    INY         ; Increment word count
    BNE NEXT_CHAR ; Branch back to NEXT_CHAR

END:
    ; Word count is stored in Y register
    BRK         ; Exit the program
