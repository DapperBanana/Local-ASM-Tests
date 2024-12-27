
; Quiz Program in 6502 Assembly

    .org $1000

start:
    lda #0
    sta $f0 ; Question number
    lda #<question1
    sta $f1 ; Question bank address
    lda #>question1
    sta $f2
    lda #0
    sta $f3 ; Correct answers

next_question:
    lda $f0
    cmp #3 ; Check if all questions have been asked
    beq end

    lda $f1
    sta $f4
    lda $f2
    sta $f5 ; Load question address

    jsr print_question
    jsr get_input

    lda $f3
    cmp $f6
    beq correct_answer

    jsr wrong_answer

end:
    rts

correct_answer:
    inc $f3 ; Increment correct answers
    lda #$0d ; New line
    jsr $ffd2
    jsr $ffd2 ; Print correct message
    jmp next_question

print_question:
    lda #$0d ; New line
    jsr $ffd2
    ldy #0
loop:
    lda ($f5),y
    beq end_print
    jsr $ffd2
    iny
    jmp loop
end_print:
    rts

get_input:
    lda #$3f ; ?
    jsr $ffd2
    jsr $ffd2
    lda #0
    jsr $ffd2
    lda #0
    jsr $ffd2
    lda #1
get_input_loop:
    jsr $ffd1
    ; Convert input from ASCII to binary
    cmp #$30
    bcc get_input_loop
    cmp #$3a
    bcs get_input_loop

    sta $f6
    rts

wrong_answer:
    lda #$0d ; New line
    jsr $ffd2
    jsr $ffd2 ; Print wrong message
    jmp next_question

question1:
    .text "What is the largest planet in our solar system? A) Saturn B) Jupiter C) Mars D) Earth"
    .byte 0

question2:
    .text "What is the capital of France? A) London B) Rome C) Paris D) Berlin"
    .byte 0

question3:
    .text "Who wrote the play 'Romeo and Juliet'? A) William Shakespeare B) Charles Dickens C) Jane Austen D) J.K. Rowling"
    .byte 0
