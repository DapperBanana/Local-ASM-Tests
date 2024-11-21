
        .org $0200   ; Start address of program

sentence        .asciiz "The quick brown fox jumped over the lazy dog."
max_length      .byte 0     ; Variable to store the maximum word length
current_length  .byte 0     ; Variable to store the current word length
char            .byte 0     ; Variable to store the current character being processed
ptr_sentence    .word 0     ; Pointer to current position in sentence

        lda #<sentence    ; Load low byte of pointer to sentence
        sta ptr_sentence
        lda #>sentence    ; Load high byte of pointer to sentence
        sta ptr_sentence+1

find_length:
        lda (ptr_sentence),y  ; Load character from current position in sentence
        beq end_of_sentence   ; If end of sentence character, exit loop

        cmp #" "              ; Check if current character is a space
        beq next_word         ; If space, move to next word

        inc current_length    ; Increment current word length
        jmp next_char         ; Move to next character in word

next_word:
        cmp max_length        ; Compare current word length with maximum word length
        bcc update_max_length ; If current word length is greater, update max length

        lda #0                ; Reset current word length
        sta current_length

update_max_length:
        sta max_length

next_char:
        iny                    ; Move to next character in sentence
        jmp find_length

end_of_sentence:
        brk                    ; End of program

        .end
