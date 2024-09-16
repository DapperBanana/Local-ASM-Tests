
 ; Fitness Tracking System
 ; Program to track daily exercise habits

 .org $1000

 START:
     LDX #0            ; Initialize exercise counter
     JSR INPUT         ; Get user input for exercise
     INX               ; Increment exercise counter
     JSR MORE          ; Ask user if they want to input more exercises
     CPX #5            ; Check if user has input 5 exercises
     BNE START         ; If not, repeat process
     JSR DISPLAY       ; Display summary of exercises
     RTS

 INPUT: 
     LDA TEXT_PROMPT   ; Load prompt message
     JSR PRINT         ; Print prompt message
     LDA #0
     STA BUFFER_PTR    ; Initialize buffer pointer
 LOOP:
     JSR GET_CHAR      ; Get user input character
     CMP #$0D          ; Check for Enter key
     BEQ END_LOOP      ; Break loop if Enter key pressed
     STA BUFFER,X      ; Store character in buffer
     INX
     BNE LOOP
 END_LOOP:
     RTS

 MORE:
     LDA ASK_MORE      ; Load message asking for more input
     JSR PRINT         ; Print message
     JSR GET_CHAR      ; Get user input character
     CMP #'Y'          ; Check if user wants to input more
     BEQ START         ; If yes, go back to input
     RTS

 DISPLAY:
     LDA SUMMARY_MSG   ; Load summary message
     JSR PRINT         ; Print message
     LDX #0            ; Initialize loop counter
 DISPLAY_LOOP:
     LDA BUFFER,X      ; Load exercise from buffer
     JSR PRINT         ; Print exercise
     INX
     CPX #4            ; Check if end of buffer
     BNE DISPLAY_LOOP
     RTS

 GET_CHAR:
     JSR $FFCF        ; Input character from user
     RTS

 PRINT:
     JSR $FFD2        ; Output character to screen
     RTS

 ; Data section
 BUFFER: .BLKB 5       ; Buffer to store exercise inputs
 BUFFER_PTR: .BYTE 0  ; Pointer for buffer
 TEXT_PROMPT: .TEXT "Enter exercise: $"      
 ASK_MORE: .TEXT "Do you want to input more exercises? (Y/N): $"
 SUMMARY_MSG: .TEXT "Your daily exercises: $"

 .END
