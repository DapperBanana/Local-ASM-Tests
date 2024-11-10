
    LDX #0      ; Initialize index for current character
    LDY #0      ; Initialize index for current word
    LDA text,Y  ; Load first character into accumulator
check_char:
    CMP #0      ; Check for end of text
    BEQ end

    CMP #' '    ; Check for space character
    BEQ end_of_word

    CMP #'#'    ; Check for hashtag character
    BEQ found_hashtag

    INY         ; Increment current character index
    INX         ; Increment current word index
    JMP check_char

end_of_word:
    LDX #0      ; Reset index for new word
    INY         ; Increment current character index
    JMP check_char

found_hashtag:
    STA hashtags,X  ; Store hashtag in hashtags array
    INX             ; Increment index for next hashtag
    INY             ; Increment current character index
    JMP check_char

end:
    RTS

hashtags:
    .Block 16     ; Array to store hashtags

text:
    .Text "This is a #sample text with #hashtags and #numbers #1234"
