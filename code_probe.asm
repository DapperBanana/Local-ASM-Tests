
START:
    LDX #0           ; Initialize index for sentence generation
GENERATE_WORD:
    LDA random_table, X   ; Get a random number from the random table at index X
    AND #$0F         ; Mask upper 4 bits to get a number between 0-15
    STA random_num
    
    LDA current_word   ; Load current word index
    TAX               ; Transfer current word to X register
    
    LDA transition_matrix, X  ; Load row of transition matrix corresponding to current word
    CLC
    ADC random_num    ; Calculate index for next word in transition matrix
    STA next_word     ; Store index of next word in next_word variable
    
    LDA next_word     ; Load next word index to be printed
    JSR print_word    ; Print the next word
    
    LDA next_word     ; Transfer next word index to current word index
    STA current_word
    
    INX               ; Increment index for sentence generation
    CPX #16           ; Check if end of sentence has been reached
    BNE GENERATE_WORD ; If not, continue generating words
    
    RTS
    
print_word:
    LDA words_table, X   ; Load next word from words table
    CMP #$00          ; Check for end of word marker
    BEQ END_OF_SENTENCE   ; If end of word marker is reached, end sentence
    JSR PRINT_CHAR    ; Print character
    INX               ; Increment index for next word
    JMP print_word    ; Continue printing the word
    
END_OF_SENTENCE:
    JMP START
    
transition_matrix:
    .byte $10, $20, $30, $40, $50, $60, $70, $80, $90, $A0, $B0, $C0, $D0, $E0, $F0, $00
    ; Transition matrix for each word, representing the probability of moving to each word
    
words_table:
    .byte "The ", "quick ", "brown ", "fox ", "jumps ", "over ", "the ", "lazy ", "dog ", $00
    ; List of words to be used in the generated sentences
    
random_table:
    .byte $2A, $3F, $12, $5C, $1A
    ; Random number table to generate random indices for transition matrix
