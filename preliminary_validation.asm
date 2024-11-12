
.word_counter:
    LDX #0                       ; Initialize word counter
    STX word1_count              ; Store word counter in memory
    STX word2_count              ; Store word counter in memory
    STX word3_count              ; Store word counter in memory

    LDA input_string             ; Load the address of the input string
    LDY #0                       ; Initialize index for scanning the string
.loop:
    LDA (input_string), Y        ; Load the next character from the string
    BEQ .end                     ; Exit loop if end of string is reached

    CMP #" "                     ; Compare character to space
    BEQ .increment_word_counter  ; Increment word counter if space is found

    INY                          ; Move to the next character in the string
    JMP .loop                    ; Continue looping
.increment_word_counter:
    DEC word2_count
    LDA word2_count
    BNE .loop
.end:
    RTS                          ; Return from subroutine

.word1_count: .byte 0            ; Word 1 counter
.word2_count: .byte 0            ; Word 2 counter
.word3_count: .byte 0            ; Word 3 counter

input_string: .byte "hello world  world hello", 0
