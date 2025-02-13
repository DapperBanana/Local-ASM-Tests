
    ORG $0200

START
    ; Display a welcome message
    LDX #WELCOME
    JSR PRINT_STRING

    ; Display the first question
    LDX #QUESTION1
    JSR PRINT_STRING

    ; Load the correct answer to accumulator
    LDA #ANSWER1
    STA CORRECT_ANSWER

    ; Get user input
    JSR GET_INPUT
    
    ; Compare user input with correct answer
    CMP CORRECT_ANSWER
    BEQ CORRECT_ANSWER_MSG
    
    ; Display incorrect answer message
    LDX #WRONG_ANSWER
    JMP PRINT_STRING

CORRECT_ANSWER_MSG
    ; Display correct answer message
    LDX #CORRECT_ANSWER
    JSR PRINT_STRING
    
    ; Display the second question
    LDX #QUESTION2
    JSR PRINT_STRING
    
    ; Load the correct answer to accumulator
    LDA #ANSWER2
    STA CORRECT_ANSWER

    ; Get user input
    JSR GET_INPUT

    ; Compare user input with correct answer
    CMP CORRECT_ANSWER
    BEQ CORRECT_ANSWER_MSG
    
    ; Display incorrect answer message
    LDX #WRONG_ANSWER
    JMP PRINT_STRING

    ; End the program
END
    BRK

WELCOME
    .BYTE "Welcome to the Educational Quiz!", $00

QUESTION1
    .BYTE "What is the capital of France?", $00

ANSWER1
    .BYTE "Paris", $00

QUESTION2
    .BYTE "What is the largest planet in our solar system?", $00

ANSWER2
    .BYTE "Jupiter", $00

CORRECT_ANSWER
    .BYTE 0

WRONG_ANSWER
    .BYTE "Sorry, that's incorrect. Try again.", $00

PRINT_STRING
    LDY #0
LOOP
    LDA (X),Y
    BEQ EXIT
    JSR $FFD2
    INY
    JMP LOOP
EXIT
    RTS

GET_INPUT
    JSR $FFCF
    RTS
