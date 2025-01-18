
.org $0200 ; Start address of our program

START:
    LDX #0          ; Initialize X register to 0 (for counting characters)
    LDY #0          ; Initialize Y register to 0 (for storing the length of the longest word)
    LDA sentence    ; Load the address of the start of the sentence into the accumulator
    STA ptr         ; Store the address in a pointer

LOOP:
    LDA (ptr),Y     ; Load character from the sentence into the accumulator
    CMP #32         ; Compare with space character
    BEQ CHECK_WORD  ; Branch to check if we have found the end of a word
    
    INY             ; Increment Y register (increase character count)
    BNE LOOP        ; Branch always back to LOOP (next character)
    
CHECK_WORD:
    CPY longest_len ; Compare the length of the current word with the longest word found so far
    BCC UPDATE_LEN  ; If the current word is longer, update the longest word length
    
    LDY #0          ; Reset Y register to 0 for counting the next word
    INC ptr         ; Increment the pointer to the start of the next word
    BNE LOOP        ; Branch always back to LOOP (start counting next word)

UPDATE_LEN:
    STY longest_len ; Store the length of the longest word
    BRA LOOP        ; Branch always back to LOOP (continue processing the remaining words)

; Data section
sentence:   .asciiz "This is a sample sentence to find the longest word"
ptr:        .addr $0000   ; Pointer to the current word in the sentence
longest_len: .byte 0       ; Length of the longest word found so far

.end    ; End of program
