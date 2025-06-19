
.INCLUDE "6502.inc"

* Variables
RIGHT_ANSWER      .BYTE 20       ; Variable to store the right answer
USER_ANSWER       .BYTE 1        ; Variable to store user's answer
QUESTION_NUMBER   .BYTE 1        ; Variable to store question number

BUFFER            .BYTE 20       ; Buffer to store user input

MSG_WELCOME       .BYTE "Welcome to the educational quiz! Press any key to start." .null
MSG_QUESTION_1    .BYTE "What is the capital of France? A) London B) Paris C) Rome" .null
MSG_QUESTION_2    .BYTE "What is 2 + 2? A) 3 B) 4 C) 5" .null
MSG_QUESTION_3    .BYTE "Who wrote Romeo and Juliet? A) Shakespeare B) Dickens C) Austen" .null
MSG_CORRECT       .BYTE "Correct! Press any key to continue." .null
MSG_WRONG         .BYTE "Wrong answer. The correct answer is:" .null
MSG_END           .BYTE "End of quiz. Press any key to exit." .null

* Start of program
RESET:  LDA #0
        STA QUESTION_NUMBER
        LDA #<BUFFER
        STA $02
        LDA #>BUFFER
        STA $03
        
        LDA #<MSG_WELCOME
        STA $06
        LDA #>MSG_WELCOME
        STA $07
        JSR $FFD2

LOOP:   LDA QUESTION_NUMBER
        CMP #1
        BEQ QUESTION_1
        CMP #2
        BEQ QUESTION_2
        CMP #3
        BEQ QUESTION_3
        BEQ END
        
QUESTION_1: 
        LDA #<MSG_QUESTION_1
        STA $06
        LDA #>MSG_QUESTION_1
        STA $07
        JSR $FFD2
        
        LDA #'B'
        STA RIGHT_ANSWER
        
        JSR READ_USER_INPUT
        
        CMP #'B'
        BEQ CORRECT
        
        LDY #<MSG_WRONG
        JSR PRINT_STRING
        
        LDA #<MSG_QUESTION_1
        STA $06
        LDA #>MSG_QUESTION_1
        STA $07
        JSR $FFD2
        BRA LOOP

QUESTION_2: 
        LDA #<MSG_QUESTION_2
        STA $06
        LDA #>MSG_QUESTION_2
        STA $07
        JSR $FFD2
        
        LDA #'B'
        STA RIGHT_ANSWER
        
        JSR READ_USER_INPUT
        
        CMP #'B'
        BEQ CORRECT
        
        LDY #<MSG_WRONG
        JSR PRINT_STRING
        
        LDA #<MSG_QUESTION_2
        STA $06
        LDA #>MSG_QUESTION_2
        STA $07
        JSR $FFD2
        BRA LOOP

QUESTION_3: 
        LDA #<MSG_QUESTION_3
        STA $06
        LDA #>MSG_QUESTION_3
        STA $07
        JSR $FFD2
        
        LDA #'A'
        STA RIGHT_ANSWER
        
        JSR READ_USER_INPUT
        
        CMP #'A'
        BEQ CORRECT
        
        LDY #<MSG_WRONG
        JSR PRINT_STRING
        
        LDA #<MSG_QUESTION_3
        STA $06
        LDA #>MSG_QUESTION_3
        STA $07
        JSR $FFD2
        BRA LOOP

CORRECT: 
        LDX #<MSG_CORRECT
        JSR PRINT_STRING
        
        INY
        JSR READ_KEY
        
        INC QUESTION_NUMBER
        JMP LOOP

END:    LDX #<MSG_END
        JSR PRINT_STRING
        
        INY
        JSR READ_KEY
        JMP RESET

PRINT_STRING:
        LDA (Y)
        BEQ RETURN
        JSR $FFD2
        INY
        BRA PRINT_STRING

RETURN: RTS
        
READ_USER_INPUT:
        JSR $FFCF    ; Input a character
        STA USER_ANSWER
        RTS
        
READ_KEY:
        JSR $FFE4    ; Wait for any keypress
        RTS

* Interrupt routine
NMI:    RTI

* End of program
        .END
