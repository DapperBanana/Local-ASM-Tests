
    .org $0600

start:
    ; Initialize variables
    lda #0   
    sta score   ; Initialize score to 0

    ; Display welcome message
    jsr printString
    lda #message
    jsr printString

quizLoop:
    ; Generate random numbers for the math questions
    lda #randomSeed
    clc
    adc #9
    sta randomSeed
    lda randomSeed
    jsr srand

    ; Generate random numbers for the questions
    lda #randomSeed
    jsr rand
    sta num1

    lda #randomSeed
    jsr rand
    sta num2

    ; Display the math question
    lda #question
    jsr printString
    lda num1
    jsr printNumber
    lda #operation
    jsr printString
    lda num2
    jsr printNumber
    lda #equals
    jsr printString

    ; Get user input for the answer
    lda #input
    jsr printString
    jsr readNumber
    sta userAnswer

    ; Calculate the correct answer
    lda num1
    clc
    adc num2
    sta correctAnswer

    ; Check if the user's answer is correct
    cmp correctAnswer
    beq correct
    lda #incorrectMessage
    jsr printString
    bra nextQuestion

correct:
    ; Increment score if answer is correct
    lda score
    clc
    adc #1
    sta score

    ; Display correct message
    lda #correctMessage
    jsr printString

nextQuestion:
    lda #continueMessage
    jsr printString

    ; Get user input to continue or end the quiz
    lda #input
    jsr printString
    jsr readChar
    cmp #end
    beq endQuiz

    bra quizLoop

endQuiz:
    ; Display final score
    lda #scoreMessage
    jsr printString
    lda score
    jsr printNumber

    ; End program
    lda #$FF
    jsr $FFFE

; Subroutines
printString:
    sta $02
    ldy #0
printLoop:
    lda ($02),y
    beq printEnd
    jsr $FFD2
    iny
    bne printLoop
printEnd:
    rts

printNumber:
    sta $01
    lda #$30
    jsr $FFD2
    lda $01
    rts

readNumber:
    lda #$00
    sta $01
    sta $01
    sty $01
readLoop:
    jsr $FFCF
    cmp #$0D
    beq readEnd
    jsr $FFD2
    ldy $01
    rts

readEnd:
    lda $01
    rts

readChar:
    jsr $FFCF
    rts

srand:
    sta $0E
    rts

rand:
    lda $0E
    adc $0F
    sta $0F
    rts

; Constants
message: .byte "Welcome to the Math Quiz!",0
question: .byte "What is ",0
operation: .byte " + ",0
equals: .byte " = ",0
correctMessage: .byte "Correct!",0
incorrectMessage: .byte "Incorrect. Try again!",0
continueMessage: .byte "Press any key to continue or 'q' to quit.",0
scoreMessage: .byte "Your final score is: ",0
input: .byte "Enter your answer: ",0
end: .byte "q",0

; Variables
num1: .byte 0
num2: .byte 0
score: .byte 0
correctAnswer: .byte 0
userAnswer: .byte 0
randomSeed: .byte 0

    .end
