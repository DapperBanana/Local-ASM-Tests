
; Count the occurrences of each word in a given string

.word_lengths:
    .byte 3, 4, 5, 5 ; Define the lengths of the words to search for
    .byte 0          ; Null terminator

.word_counts:
    .byte 0, 0, 0, 0 ; Initialize word counts to zero

.text:
    LDA #<string   ; Load the low byte of the address of the string into A
    STA $FB        ; Store it in zero page memory
    LDA #>string   ; Load the high byte of the address of the string into A
    STA $FC        ; Store it in zero page memory

    LDX #0         ; Initialize index X to 0
loop:
    LDA .word_lengths, X ; Load the length of the current word
    BEQ done        ; If the length is 0, we're done
    STA $FD       ; Store it in a temp variable
    LDA #0         ; Clear the word count
    STA $FE
  
inner_loop:
    LDA $FB, X    ; Load a character from the string
    STA $FF
  
    CMP #0        ; Check for null terminator
    BEQ next_word    ; If reached the end of the string, go to the next word

    LDA .word_lengths, X ; Load the length of the current word
    CMP $FF       ; Compare it with the current character
    BNE not_match    ; If not a match, go to the next character

    INX          ; Increment index to move to the next character
    DEC $FD      ; Decrement the remaining length of the word
    BNE inner_loop    ; Repeat for the rest of the word

    INC .word_counts, X  ; Increment the count for the current word

    JMP inner_loop

not_match:
    INX          ; Move to the next character in the string
    JMP inner_loop

next_word:
    LDX $FD       ; Restore the length of the word
    DEX          ; Decrement index to point to the next word length
    INX          ; Increment index to move to the next word
    JMP loop

done:
    RTS

string:
    .asciiz "hello world hello again world"
