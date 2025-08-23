
; Quiz Program in 6502 Assembly

; Load questions and answers into memory
QUESTION_1 .byte "What is the capital of France?"
ANSWER_1 .byte "Paris"
QUESTION_2 .byte "What is the largest planet in our solar system?"
ANSWER_2 .byte "Jupiter"

; Set up variables
BUFFER .res 32 ; Buffer to store user input
ANSWER_BUFFER .res 32 ; Buffer to store correct answer
CORRECT_ANSWERS .byte 0 ; Counter for correct answers

; Main program
start:
    lda #1
    sta CORRECT_ANSWERS ; Reset correct answers counter

    ; Question 1
    lda #<QUESTION_1
    sta ANSWER_BUFFER
    lda #>QUESTION_1
    sta ANSWER_BUFFER + 1
    jsr get_answer

    lda ANSWER_BUFFER
    cmp ANSWER_1
    beq correct_answer
    jmp wrong_answer

correct_answer:
    inc CORRECT_ANSWERS

    ; Question 2
    lda #<QUESTION_2
    sta ANSWER_BUFFER
    lda #>QUESTION_2
    sta ANSWER_BUFFER + 1
    jsr get_answer

    lda ANSWER_BUFFER
    cmp ANSWER_2
    beq correct_answer
    jmp wrong_answer

wrong_answer:
    ; Display wrong answer message
    lda #"W"
    jsr $ffd2 ; Output character to screen

    ; Jump back to start if user wants to try again
    lda CORRECT_ANSWERS
    cmp #2
    bne start

    ; Exit program
    rts

; Get user input
get_answer:
    lda #0
    sta BUFFER
read_loop:
    jsr $ffcc ; Get key press
    cmp #$0d ; Check if Enter key is pressed
    beq end_read
    sta BUFFER, x
    inx
    jmp read_loop

end_read:
    rts
