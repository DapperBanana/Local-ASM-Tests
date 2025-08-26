
    .org $0200

start:
    ldx #text_end - text - 1  ; Load the length of the sentence into X
    ldy #0                   ; Initialize Y to 0 for the first word index
    lda #0                   ; Clear A register for storing word boundary
    sta word_end_ptr

reverse_words:
    ; Find the end of the current word
    lda text,x              ; Load the current character
    bne check_space        ; Check if the character is not zero
    dey                    ; If character is zero, decrement word index
    lda word_end_ptr       ; Load word end pointer
    sta word_end_indexes,y ; Store the end index of the current word
    lda #0                 ; Reset A register to zero
    sta word_end_ptr       ; Reset word end pointer
    inx                    ; Move to the previous character
    cpx #0                 ; Check if entire sentence is processed
    bne reverse_words      ; Continue if not
    jmp print_reversed     ; Print the reversed sentence

check_space:
    cmp #$20   ; Check if the current character is a space
    beq found_space
    dec x      ; Move to the previous character
    bne check_space

found_space:
    ; Found a space, store the end index of the current word
    lda word_end_ptr      ; Load word end pointer
    sta word_end_indexes,y ; Store the end index of the current word
    iny                   ; Increment word index
    lda x                 ; Start a new word, store the start index
    sta word_start_indexes,y
    lda #1                ; Set A register to 1 for word boundary
    sta word_end_ptr      ; Store the word boundary
    jmp reverse_words     ; Continue checking for words

print_reversed:
    ldx #0                   ; Initialize X for printing
    ldy #0                   ; Initialize Y for accessing word indexes
    lda word_end_indexes,y   ; Load the end index of the first word
    jsr print_word           ; Print the first word
    dec y                    ; Move to the next word
    bpl print_reversed       ; Continue if there are more words

end:
    rts

print_word:
    lda word_start_indexes,y ; Load the start index of the word
    sta temp_ptr
    loop:
        lda text,temp_ptr    ; Load the character from the start index
        beq end_word         ; Exit loop if zero byte is reached
        jsr $ffd2            ; Print the character
        iny                  ; Move to the next character
        inc temp_ptr
        jmp loop
    end_word:
        lda #$20            ; Print a space
        jsr $ffd2
        rts

text: 
    .asciiz "Reverse order of words in a sentence"
word_start_indexes: .byte 0,0,0,0,0,0
word_end_indexes:   .byte 0,0,0,0,0,0
word_end_ptr:       .byte 0
temp_ptr:           .byte 0

text_end:
