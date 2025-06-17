
        .org $1000

sentence .asciiz "The quick brown fox jumps over the lazy dog"
length   .byte 0
longest  .byte 0

        .org $2000

start:  lda #0          ; Initialize variables
        sta longest

loop:   lda sentence, x ; Load character from sentence
        beq done         ; If end of the sentence, exit loop
        cmp #$20         ; Compare with space character
        beq check        ; If space, check length of current word
        inx              ; Move to next character
        jmp loop

check:  lda length      ; Load current length
        cmp longest      ; Check if current length is longer than longest
        bcc not_longest  ; If not, skip updating longest
        lda length       ; If yes, update longest
        sta longest

not_longest:
        lda #0           ; Reset length for next word
        sta length
        inx
        jmp loop

done:   lda longest     ; Load longest length
        jmp $

        .org $FFFC
        .word start
