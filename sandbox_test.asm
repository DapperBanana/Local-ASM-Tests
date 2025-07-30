
ORG $1000

start:
    LDX #$00    ; Initialize index for current word in the string
    LDY #$00    ; Initialize index for current character in the string
    LDA str,Y   ; Load the first character of the string

next_char:
    CMP #$00    ; Check if end of string
    BEQ done    ; If end of string, exit program

    CMP #" "    ; Check if current character is space
    BEQ check_word  ; If space, check the current word and reset index
    
    INY         ; Move to the next character
    JMP next_char

check_word:
    STY cur_char_idx  ; Store current character index
    LDA #$00    ; Initialize index for checking existing words
    
next_word:
    LDA words,X ; Load the current word from the words array
    CMP str,Y   ; Compare current word with the word in the string
    BEQ word_found  ; If word found, increment count and exit
    INX         ; Move to the next word in the words array
    CMP #$00    ; Check if end of words array
    BEQ add_word    ; If end of words array, add new word
    
    JMP next_word

word_found:
    INC counts,X   ; Increment count for the word
    JMP start

add_word:
    STY word_start  ; Store start index of the new word
    STX words,Y ; Add new word to the words array
    INY         ; Move to the next empty slot in the words array
    JMP start

done:
    BRK

; Data section
str: .asciiz "hello world hello world"
words: .byte $00,$00,$00,$00,$00
counts: .byte $00,$00,$00,$00,$00
cur_char_idx: .byte $00
word_start: .byte $00

END start
