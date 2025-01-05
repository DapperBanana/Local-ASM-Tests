
    .org $1000

start:
    lda text     ; Load the address of the text into the accumulator
    ldx #$00     ; Initialize X register to zero
    ldy #$00     ; Initialize Y register to zero

next_char:
    lda (text), y   ; Load the next character from the text
    beq end_of_text ; If we have reached the end of the text, go to the end

    cmp #'#'        ; Compare the character with '#'
    beq found_hashtag ; If the character is '#', go to the found_hashtag routine

    iny             ; Increment Y register to move to the next character

    jmp next_char   ; Continue to the next character

found_hashtag:
    iny             ; Increment Y register to get the first character of the hashtag

get_hashtag:
    lda (text), y   ; Load the character into the accumulator
    cmp #' '        ; Compare the character with a space
    beq end_hashtag ; If it's a space, we have reached the end of the hashtag

    sta hashtag, x  ; Store the character in the hashtag buffer
    inx             ; Increment X register to move to the next position in the buffer
    iny             ; Increment Y register to move to the next character

    jmp get_hashtag ; Continue to get the rest of the hashtag

end_hashtag:
    lda #' '        ; Add a space character at the end of the hashtag
    sta hashtag, x

    jsr print_hashtag ; Print the hashtag
    lda #'#'        ; Add a hashtag character at the end of the displayed hashtag
    sta hashtag, x
    inx             ; Increment X register
    lda #' '        ; Add a space character at the end of the displayed hashtag
    sta hashtag, x

    lda x           ; Load the length of the hashtag
    clc
    adc #$03        ; Increment X register to skip the hashtag and space characters

    lda y           ; Move Y register to the end of the hashtag
    clc
    adc x           ; Add X register's contents
    tay

    jmp next_char   ; Continue to look for more hashtags

end_of_text:
    rts

print_hashtag:
    lda '#'        ; Display '#' character
    jsr $ffef      ; Call ROM subroutine to output the character

    lda hashtag, x ; Load the first character of the hashtag
    jsr $ffef      ; Call ROM subroutine to output the character

    inx            ; Increment X register
    lda hashtag, x ; Load the next character of the hashtag
    cmp #' '       ; Check if we have reached the end of the hashtag
    beq end_print  ; If we've reached the end, exit

    jsr $ffef      ; Call ROM subroutine to output the character

    jmp print_hashtag ; Continue to print the rest of the hashtag

end_print:
    rts

text:
    .asciiz "This is a #sample text with #hashtags #extracted and displayed."

hashtag:
    .bss 16

    .end start
