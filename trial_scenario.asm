
; Reverse the order of words in a sentence

    .text
    .org $0200

start:
    LDX #0              ; Initialize index for current word
    LDY #0              ; Initialize index for current character within word
    LDA sentence,X      ; Load first character of sentence
    BEQ end             ; If end of sentence, exit program
    
find_next_word:
    INX                 ; Move to next character
    LDA sentence,X      ; Load next character
    BEQ reverse_words   ; If end of word, reverse current word
    
    JMP find_next_word  ; Otherwise, continue to next character
    
reverse_words:
    LDX #0              ; Reset index for character within word
reverse_loop:
    LDA sentence,X      ; Load character from current word
    BEQ print_word      ; If end of word, print reversed word
    
    INX                 ; Move to next character
    JMP reverse_loop     ; Continue looping for current word
    
print_word:
    STX temp            ; Save index of last character in word
    
    LDY #0              ; Initialize index for copied characters in output
copy_word:
    LDX temp            ; Load index of last character in word
    LDA sentence,X      ; Load character from current word
    STA reversed_sentence,Y ; Copy character to reversed sentence
    
    INY                 ; Move to next character in output
    DEX                 ; Move to previous character in word
    CPX #0              ; If beginning of word is reached, exit loop
    BNE copy_word
    
    INX                 ; Move to beginning of next word
    LDA $00,X           ; Load character of next word
    BEQ end             ; If end of sentence, exit program
    
    INY                 ; Move to next space in output sentence
    LDA #$20            ; Insert space between words
    STA reversed_sentence,Y
    
    INY                 ; Move to next character in output
    JMP find_next_word  ; Continue to next word
    
end:
    BRK                 ; Exit program
    
    .data
sentence:
    .asciiz "This is a sample sentence to reverse"
reversed_sentence:
    .block 50
temp:
    .byte 0
