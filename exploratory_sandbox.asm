
        .org $0200

start   lda #0
        sta score
        jsr displayQuestion1
        jsr getAnswer
        jsr displayQuestion2
        jsr getAnswer
        jsr displayQuestion3
        jsr getAnswer

displayResult
        lda score
        jsr displayScore

end     rts

displayQuestion1
        lda #<question1
        ldy #>question1
        jsr displayString
        rts

question1
        .asciiz "What is the capital of France? A. London B. Paris C. Rome\n"

displayQuestion2
        lda #<question2
        ldy #>question2
        jsr displayString
        rts

question2
        .asciiz "What is the largest planet in our solar system? A. Mars B. Jupiter C. Earth\n"

displayQuestion3
        lda #<question3
        ldy #>question3
        jsr displayString
        rts

question3
        .asciiz "Who wrote 'Romeo and Juliet'? A. William Shakespeare B. Jane Austen C. Emily Bronte\n"

getAnswer
        lda #0
        sta answer
getInput
        jsr getInput
        lda input
        cmp #'A'
        beq checkAnswer
        cmp #'B'
        beq checkAnswer
        cmp #'C'
        beq checkAnswer
        jsr displayInvalidInput
        jmp getInput

checkAnswer
        lda input
        cmp #'B'
        beq correctAnswer
        jmp incorrectAnswer

correctAnswer
        inc score
        rts

incorrectAnswer
        rts

input   .byte 0
answer  .byte 0
score   .byte 0

displayString
        lda #<string
        ldy #>string
        jsr $ffd2
        rts

string  .byte 0

displayScore
        lda score
        clc
        adc #'0'
        jsr $ffd2
        lda #<scoreString
        ldy #>scoreString
        jsr displayString
        rts

scoreString
        .asciiz " out of 3\n"

displayInvalidInput
        lda #<invalidInput
        ldy #>invalidInput
        jsr displayString
        rts

invalidInput
        .asciiz "Invalid input. Please enter A, B, or C\n"

getInput
        lda #$00
        jsr $ff00
        sta input
        rts

        .org $0400

        .byte $00
