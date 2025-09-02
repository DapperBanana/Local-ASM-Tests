
. TEXT EQU $0200

        ORG $0600

START   LDX #0                         ; Initialize index register X
        LDA #NUM_QUESTIONS              ; Load the number of questions
        STA QUESTIONS_LEFT             ; Store in QUESTIONS_LEFT
LOOP    LDA QUESTIONS,X                ; Load the question from array
        JSR PRINT_QUESTION             ; Print the question
        JSR GET_INPUT                  ; Get the user's answer
        CMP ANSWERS,X                  ; Compare with the correct answer
        BEQ CORRECT                    ; Branch if correct
        JSR PRINT_INCORRECT            ; Print "Incorrect!" message
        JMP NEXT_QUESTION              ; Jump to next question
CORRECT JSR PRINT_CORRECT              ; Print "Correct!" message
NEXT_QUESTION
        INX                            ; Increment index
        CPX NUM_QUESTIONS              ; Compare with number of questions
        BNE LOOP                       ; Branch if not all questions have been asked

DONE    RTS                            ; End of program

PRINT_QUESTION
        LDX #0                         ; Initialize index register X
PRINT_LOOP
        LDA QUESTIONS,X                ; Load character from question string
        BEQ DONE_PRINTING              ; Branch if end of string
        JSR PRINT_CHARACTER            ; Print character
        INX                            ; Increment index
        JMP PRINT_LOOP                 ; Repeat for next character
DONE_PRINTING
        RTS                            ; End of subroutine

GET_INPUT
        LDX #0                         ; Initialize index register X
INPUT_LOOP
        JSR READ_CHARACTER             ; Read character from input
        CMP #'A'                       ; Check if character is A
        BEQ STORE_ANSWER_A             ; Branch if A
        CMP #'B'                       ; Check if character is B
        BEQ STORE_ANSWER_B             ; Branch if B
        JMP INPUT_LOOP                 ; Repeat until A or B is entered
STORE_ANSWER_A
        STA USER_ANSWER                ; Store A as user's answer
        RTS                            ; End of subroutine
STORE_ANSWER_B
        LDA #'B'                       ; Store B as user's answer
        STA USER_ANSWER
        RTS                            ; End of subroutine

PRINT_CORRECT
        LDX #0                         ; Initialize index register X
PRINT_CORRECT_LOOP
        LDA CORRECT_MESSAGE,X          ; Load character from message string
        BEQ DONE_PRINTING_CORRECT      ; Branch if end of string
        JSR PRINT_CHARACTER            ; Print character
        INX                            ; Increment index
        JMP PRINT_CORRECT_LOOP         ; Repeat for next character
DONE_PRINTING_CORRECT
        RTS                            ; End of subroutine

PRINT_INCORRECT
        LDX #0                         ; Initialize index register X
PRINT_INCORRECT_LOOP
        LDA INCORRECT_MESSAGE,X        ; Load character from message string
        BEQ DONE_PRINTING_INCORRECT    ; Branch if end of string
        JSR PRINT_CHARACTER            ; Print character
        INX                            ; Increment index
        JMP PRINT_INCORRECT_LOOP       ; Repeat for next character
DONE_PRINTING_INCORRECT
        RTS                            ; End of subroutine

PRINT_CHARACTER
        STA TEXT,X                     ; Store character in text buffer
        JSR $FFD2                      ; Print character on screen
        RTS                            ; End of subroutine

READ_CHARACTER
        JSR $FFCF                      ; Read character from input
        RTS                            ; End of subroutine

QUESTIONS
        .BYTE "What is the capital of France?",0
        .BYTE "What is 2+2?",0

ANSWERS
        .BYTE 'A','P','A','R','I','S',0
        .BYTE 'B','4',0

CORRECT_MESSAGE
        .BYTE "Correct!",0

INCORRECT_MESSAGE
        .BYTE "Incorrect!",0

USER_ANSWER .BYTE 0
QUESTIONS_LEFT .BYTE 0
NUM_QUESTIONS .BYTE 2

        .END
