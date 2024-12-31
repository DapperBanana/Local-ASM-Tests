
; Personality Quiz program
; Asks the user a series of questions to determine their personality type

    .org $0200

start:
    lda #0
    sta $fe
    ldx #0
    ldy #0

question1:
    lda #$20
    jsr $ffd2  ; CHROUT
    lda #<question1_text
    ldx #>question1_text
    jsr $ffd4  ; PRINT
    lda #0
input:
    jsr $ffd7  ; GETIN
    cmp #$44  ; D key pressed
    bne input
    lda #$0D
    jsr $ffd2  ; CHROUT
    lda #<question2_text
    ldx #>question2_text
    jsr $ffd4  ; PRINT
    jmp next_question

question2:
    lda #$20
    jsr $ffd2  ; CHROUT
    lda #<question2_text
    ldx #>question2_text
    jsr $ffd4  ; PRINT
    lda #0
input2:
    jsr $ffd7  ; GETIN
    cmp #$44  ; D key pressed
    bne input2
    lda #$0D
    jsr $ffd2  ; CHROUT
    lda #<question3_text
    ldx #>question3_text
    jsr $ffd4  ; PRINT
    jmp next_question

question3:
    lda #$20
    jsr $ffd2  ; CHROUT
    lda #<question3_text
    ldx #>question3_text
    jsr $ffd4  ; PRINT
    lda #0
input3:
    jsr $ffd7  ; GETIN
    cmp #$44  ; D key pressed
    bne input3
    lda #$0D
    jsr $ffd2  ; CHROUT
    lda #<result_text
    ldx #>result_text
    jsr $ffd4  ; PRINT

next_question:
    inx
    cpx #3
    beq end_quiz
    jmp questionTable, x

end_quiz:
    lda #$20
    jsr $ffd2  ; CHROUT
    lda #<end_text
    ldx #>end_text
    jmp $ffd4  ; PRINT

questionTable:
    .word question1
    .word question2
    .word question3

question1_text: .text "Do you enjoy spending time outdoors? (Press D for yes)"
question2_text: .text "Do you prefer working alone or with others? (Press D for alone)"
question3_text: .text "Are you a night owl or an early bird? (Press D for night owl)"

result_text: .text "Your personality type is: Introvert Night Owl."

end_text: .text "End of quiz"

    .end
