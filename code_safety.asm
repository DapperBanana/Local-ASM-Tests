
    .org $1000

start:
    lda #0            ; Initialize score to 0
    sta score

    ; Question 1
    jsr print_question1
    jsr get_answer
    sta answer
    lda answer
    cmp #1
    beq introvert

    ; Question 2
    jsr print_question2
    jsr get_answer
    sta answer
    lda answer
    cmp #1
    beq extrovert

    ; Question 3
    jsr print_question3
    jsr get_answer
    sta answer
    lda answer
    cmp #1
    beq introvert

    ; Question 4
    jsr print_question4
    jsr get_answer
    sta answer
    lda answer
    cmp #1
    beq extrovert

    ; Results
introvert:
    lda score
    beq intro_statement
    lda #1
    sta score
    jsr intro_statement
    rts

extrovert:
    lda score
    beq extro_statement
    lda #1
    sta score
    jsr extro_statement
    rts

intro_statement:
    lda #4
    jsr print_intro_statement
    rts

extro_statement:
    lda #4
    jsr print_extro_statement
    rts

print_question1:
    lda #1
    jsr print_question
    rts

print_question2:
    lda #2
    jsr print_question
    rts

print_question3:
    lda #3
    jsr print_question
    rts

print_question4:
    lda #4
    jsr print_question
    rts

print_intro_statement:
    lda #5
    jsr print_statement
    rts

print_extro_statement:
    lda #6
    jsr print_statement
    rts

print_question:
    ; Load question string into accumulator based on question number
    ldx #0
    lda question_strings, x
    jsr print_string
    rts

print_statement:
    ; Load statement string into accumulator based on statement number
    ldx #0
    lda statement_strings, x
    jsr print_string
    rts

print_string:
    ; Output the character in the accumulator
    sta $FFD2
    rts

get_answer:
    lda $FFD0         ; Read user input from keyboard
    rts

score: .byte 0
answer: .byte 0

question_strings:
    .asciiz "Do you prefer spending time alone rather than with a group of people?\n"
    .asciiz "Do you enjoy meeting new people and socializing?\n"
    .asciiz "Are you more comfortable observing a situation rather than being the center of attention?\n"
    .asciiz "Do you tend to speak your mind and enjoy being the life of the party?\n"

statement_strings:
    .asciiz "You are more of an introvert.\n"
    .asciiz "You are more of an extrovert.\n"
