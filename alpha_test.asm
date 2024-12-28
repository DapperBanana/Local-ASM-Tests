
; Fitness Tracking System
; Enable ASCII mode with BASIC ROM calls
        .WORD   $FDED           ; Enable BASIC ROM routines
        .WORD   $FF69           ; Enable ASCII mode
        .WORD   $FFFF           ; End of initialization routine

START
        LDX     #$00            ; Initialize index register
        LDY     #$00            ; Initialize secondary index register
        
PRINT_MESSAGE
        LDA     MESSAGE,X       ; Load next character of message
        BEQ     END             ; End of message, exit program
        JSR     $FFD2           ; Output character to screen
        INX                     ; Increment index register
        BNE     PRINT_MESSAGE   ; Continue printing message
        
END
        RTS                     ; Return from subroutine

MESSAGE
        .BYTE   "Welcome to the Fitness Tracking System", $0D, $0A
        .BYTE   "Enter your workout details below:", $0D, $0A
        .BYTE   "1. Enter number of steps taken: ", $00
        .BYTE   "2. Enter number of calories burned: ", $00
        .BYTE   "3. Enter minutes of exercise: ", $00
        .BYTE   "4. Exit", $00

        .END
