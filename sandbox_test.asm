
; Fitness Tracking System
; By: Your Name

    .org $0200 ; Start program at memory location $0200

    LDX #$00 ; Initialize tracker for number of exercises completed

loop:
    JSR printMenu ; Display menu options
    JSR getInput ; Get user input
    
    CMP #$30 ; Check if user selection is '0' (exit)
    BEQ exit
    
    CMP #$31 ; Check if user selection is '1' (completed exercise)
    BEQ completedExercise
    
    JMP loop ; Continue looping if user input is invalid

completedExercise:
    INX ; Increment exercise count
    JSR printCompletedExercise ; Display message that exercise was completed
    JMP loop ; Return to menu

exit:
    JSR printExitMessage ; Display exit message
    RTS ; End program

; Subroutines
printMenu:
    LDA #$0C ; Clear screen
    JSR $FFD2 ; Output character
    
    LDA #<menuText ; Load low byte of menuText address
    LDY #>menuText ; Load high byte of menuText address
    JSR $FFBD ; Output text at memory address
    
    RTS

printCompletedExercise:
    LDA #$0C ; Clear screen
    JSR $FFD2 ; Output character
    
    LDA #<completedText ; Load low byte of completedText address
    LDY #>completedText ; Load high byte of completedText address
    JSR $FFBD ; Output text at memory address
    
    RTS

printExitMessage:
    LDA #$0C ; Clear screen
    JSR $FFD2 ; Output character
    
    LDA #<exitText ; Load low byte of exitText address
    LDY #>exitText ; Load high byte of exitText address
    JSR $FFBD ; Output text at memory address
    
    RTS

getInput:
    JSR $FFCF ; Input character
    RTS

; Data section
menuText:
    .asciiz "Fitness Tracking System\n\n1. Mark exercise completed\n0. Exit\n\nSelect an option: "

completedText:
    .asciiz "Exercise marked as completed.\n"

exitText:
    .asciiz "Exiting program. Goodbye!\n"

    .end ; End of program
