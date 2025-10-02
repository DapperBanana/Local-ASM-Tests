
WORD_TABLE .BSS 256   ; Table to store word counts (256 words max)
BUFFER     .BSS 256   ; Input string buffer

START:
    LDX #0          ; Initialize index for input buffer
    LDY #0          ; Initialize index for word table
  
    ; Read input string into buffer
READ_LOOP:
    LDA BUFFER,X    ; Load next character from input buffer
    BEQ COUNT_WORDS ; If end of string, go count words
  
    STA $F0         ; Store character in memory for comparison
    INX             ; Move to next character in input buffer
    BNE READ_LOOP   ; Continue reading input string

COUNT_WORDS:
    LDY #0          ; Reset index for word table
COUNT_LOOP:
    LDA WORD_TABLE,Y ; Load current count of word
    BEQ NEW_WORD     ; If count is zero, it's a new word
    
    CMP $F0          ; Compare current word with input buffer
    BEQ WORD_FOUND   ; If match, increment word count

    INY              ; Move to next word in table
    BNE COUNT_LOOP   ; Continue counting words

NEW_WORD:
    STA WORD_TABLE,Y ; Store new word in word table
    JMP COUNT_LOOP   ; Continue counting words

WORD_FOUND:
    INY              ; Increment word count
    STA WORD_TABLE,Y ; Store updated count in word table
    JMP COUNT_LOOP   ; Continue counting words

END:
    BRK              ; End program
