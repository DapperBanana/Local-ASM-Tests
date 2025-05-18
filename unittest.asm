
        .org $0200

start   lda #<message     ; load low byte of message address
        ldx #>message     ; load high byte of message address
        ldy #0             ; initialize counter for vowels
        ldx #0             ; initialize index for string traversal

loop    lda message,x      ; load character from string
        cmp #0             ; check if end of string
        beq done           ; if end of string, exit loop

        cmp #'a'           ; check if character is 'a'
        beq is_vowel       ; if vowel, increment counter

        cmp #'e'           ; check if character is 'e'
        beq is_vowel       ; if vowel, increment counter

        cmp #'i'           ; check if character is 'i'
        beq is_vowel       ; if vowel, increment counter

        cmp #'o'           ; check if character is 'o'
        beq is_vowel       ; if vowel, increment counter

        cmp #'u'           ; check if character is 'u'
        beq is_vowel       ; if vowel, increment counter

        inx                ; increment index
        bra loop           ; continue loop

is_vowel
        iny                ; increment counter
        inx                ; increment index
        bra loop           ; continue loop

done    lda #<result      ; load low byte of result address
        sta result         ; store result
        lda #>result      ; load high byte of result address
        sta result+1       ; store result

        rts

message .byte "hello world",0
result  .word 0

        .end
