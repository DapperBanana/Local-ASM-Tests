
        .org $0200

START   LDX #0            ; Initialize index to 0

LOOP    LDA QUESTION,X    ; Load question into A register
        JSR PRINT         ; Print question

        LDX #0            ; Initialize index to 0
CHOICE_LOOP
        LDA CHOICES,X     ; Load choice into A register
        JSR PRINT         ; Print choice

        INX               ; Move to next choice
        CPX #$04          ; Check if all choices printed
        BNE CHOICE_LOOP   ; Loop back if not all choices printed

        JSR READ          ; Read user input

        CMP ANSWER,X      ; Compare user input with correct answer
        BEQ CORRECT       ; Branch to CORRECT if answer is correct
        JMP WRONG         ; Jump to WRONG if answer is wrong

CORRECT LDA #<CORRECT_MSG  ; Load correct message pointer
        STA MESSAGE_PTR
        LDA #>CORRECT_MSG
        STA MESSAGE_PTR+1
        
        JSR PRINT_MSG     ; Print correct message
        JMP NEXT_QUESTION ; Jump to next question

WRONG   LDA #<WRONG_MSG    ; Load wrong message pointer
        STA MESSAGE_PTR
        LDA #>WRONG_MSG
        STA MESSAGE_PTR+1

        JSR PRINT_MSG       ; Print wrong message
        JMP NEXT_QUESTION   ; Jump to next question

NEXT_QUESTION
        INX                 ; Move to next question
        CPX #$03            ; Check if all questions asked
        BEQ END             ; Branch to END if all questions asked

        JMP LOOP            ; Loop back to ask next question

END     BRK                ; End program

MESSAGE_PTR .DSW 2          ; Message pointer to be printed

QUESTION    .BYTE "What is the capital of France?"    ; Question
CHOICES     .BYTE "A. London", 0x00                    ; Choices
            .BYTE "B. Paris", 0x00
            .BYTE "C. Tokyo", 0x00
            .BYTE "D. Berlin", 0x00

ANSWER      .BYTE 'B'       ; Correct answer

CORRECT_MSG .BYTE "Correct! Good job!"                 ; Message for correct answer
WRONG_MSG   .BYTE "Wrong answer. Try again!"           ; Message for wrong answer

PRINT       JSR $FFD2       ; Print message
READ        JSR $FFCF       ; Read user input
