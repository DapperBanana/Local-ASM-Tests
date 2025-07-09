
    .org $0200
start:
    lda #0 ; set accumulator to 0
    sta $f0 ; clear answer variable

question1:
    lda #"Q1: What is the capital of France?"
    jsr print ; print question

    lda #"A. Paris"
    jsr print ; print choice A

    lda #"B. London"
    jsr print ; print choice B

    lda #"C. Berlin"
    jsr print ; print choice C

    lda #"D. Rome"
    jsr print ; print choice D

    lda #0
    jsr read_key ; read input key
    cmp #"A"
    beq answer_check ; check answer

    lda #"Try again!"
    jsr print ; print error message
    jmp question1 ; repeat question

answer_check:
    lda #"Correct!"
    jsr print ; print correct message

question2:
    lda #"Q2: What is the largest planet in the solar system?"
    jsr print ; print question

    lda #"A. Jupiter"
    jsr print ; print choice A

    lda #"B. Mars"
    jsr print ; print choice B

    lda #"C. Earth"
    jsr print ; print choice C

    lda #"D. Venus"
    jsr print ; print choice D

    lda #0
    jsr read_key ; read input key
    cmp #"A"
    beq answer_check ; check answer

    lda #"Try again!"
    jsr print ; print error message
    jmp question2 ; repeat question

    jmp end ; end quiz

print:
    sta $f1 ; store character in memory
    ldx #00
print_loop:
    lda ($f1),x ; load character from memory
    beq print_done ; end of string
    jsr $ffd2 ; print character
    inx
    bne print_loop
print_done:
    rts

read_key:
    jsr $ffd7 ; read key
    cmp #"A"
    bcc read_key
    rts

end:
    rts
