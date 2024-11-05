
        .text
        .globl _start

_start:
        lda #0          ; Initialize variables
        sta max_len
        lda #0
        sta current_len
        lda #0
        sta longest_len

loop:
        lda sentence, x    ; Load character from sentence
        cmp #32            ; Check for space (end of word)
        beq end_word

        inc current_len    ; Increment current word length
        inc x              ; Move to next character
        bne loop           ; Continue loop

end_word:
        lda current_len     ; Compare current word length to longest length
        cmp longest_len
        bgt update_longest

        lda current_len     ; Reset current word length
        sta current_len

update_longest:
        sta longest_len     ; Update longest length if necessary

        lda sentence, x    ; Check for end of sentence
        beq end_program

        inc x              ; Move to start of next word
        jmp loop

end_program:
        lda longest_len    ; Load longest word length into Accumulator
        ; Output the result here

        rts

        .data
sentence:
        .asciiz "This is a sample sentence to find the longest word"  ; Sample sentence
        .equ max_len, 0
        .equ current_len, 0
        .equ longest_len, 0
