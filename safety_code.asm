
    ; Assume the given string is stored in memory starting at address $8000
    ; The result will be stored in memory starting at address $8100

    LDX #$00 ; Initialize word count index
    STX $FF ; Initialize word count table

next_char:
    lda $8000, X ; Load next character from string
    beq end_of_string ; If end of string, exit

    cmp #$20 ; Check if character is a space
    beq next_char ; Ignore spaces

    sta $FA ; Store current character in temporary register

check_word:
    lda $FA ; Load character
    cmp $8000, X ; Check if current character matches next character from string
    beq increment_count ; If match, increment count

    lda $FA ; Reload character from temporary register
    bne end_check_word ; If not end of word, continue
    jmp next_char ; If end of word, continue to next character

increment_count:
    lda $FF ; Load word count table
    clc
    adc #$01 ; Increment count
    sta $FF ; Store updated count

end_check_word:
    inx ; Move to next character
    jmp check_word ; Check next character

end_of_string:
    lda $FF ; Load word count table
    sta $8100, X ; Store word count in result table
    inx ; Move to next word
    cpx #$10 ; Check if end of word count table
    beq done ; If end of table, exit
    ldx $00 ; Reset character index
    stx $FF ; Reset word count table
    jmp next_char ; Move to next character

done:
    rts
