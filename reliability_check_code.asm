
; 6502 Assembly program for a basic text-based movie recommendation system

    processor 6502
    include "vcs.h"
    
    ; Define constants
    .const
    
messageWelcome = "Welcome to Movie Recommender\n"
messageOptions = "Choose a genre:\n1. Action\n2. Comedy\n3. Drama\n"
messageActionRecommendation = "You should watch 'Die Hard'\n"
messageComedyRecommendation = "You should watch 'The Hangover'\n"
messageDramaRecommendation = "You should watch 'The Shawshank Redemption'\n"
messageInvalidOption = "Invalid option. Please try again.\n"
messageQuit = "Thank you for using Movie Recommender. Have a good day!\n"

    ; Define variables
    .var
    
input:  .byte   0    ; Input for user choice
output: .byte   0    ; Output for recommendation
    
    ; Start of the program
    .org $0200
    
start:
    LDX #0         ; Initialize X register
    STX output     ; Initialize output variable to 0
    
    ; Print welcome message
    LDA #<messageWelcome
    LDY #>messageWelcome
    JSR PRINT
    
    ; Print options for genres
    LDA #<messageOptions
    LDY #>messageOptions
    JSR PRINT
    
inputLoop:
    ; Get user input
    JSR GETNUM
    TAX            ; Store input in X register
    
    ; Check user input
    CPX #1         ; Check if input is 1 (Action)
    BEQ actionSelected
    CPX #2         ; Check if input is 2 (Comedy)
    BEQ comedySelected
    CPX #3         ; Check if input is 3 (Drama)
    BEQ dramaSelected
    
    ; Invalid option, try again
    LDA #<messageInvalidOption
    LDY #>messageInvalidOption
    JSR PRINT
    JMP inputLoop
    
actionSelected:
    ; Print Action recommendation
    LDA #<messageActionRecommendation
    LDY #>messageActionRecommendation
    JSR PRINT
    BRA endProgram
    
comedySelected:
    ; Print Comedy recommendation
    LDA #<messageComedyRecommendation
    LDY #>messageComedyRecommendation
    JSR PRINT
    BRA endProgram
    
dramaSelected:
    ; Print Drama recommendation
    LDA #<messageDramaRecommendation
    LDY #>messageDramaRecommendation
    JSR PRINT
    BRA endProgram
    
endProgram:
    ; Print goodbye message
    LDA #<messageQuit
    LDY #>messageQuit
    JSR PRINT
    
    ; End program
    RTS
    
    ; Get user input as number
    .proc GETNUM
GETNUM:
    LDA #'0'        ; Initialize input as '0'
    STA input
inputLoop:
    LDA #0xFF
    JSR CHROUT    ; Output prompt
    JSR GETCH      ; Read user input
    CMP #'0'
    BCC inputLoop  ; Loop until input is a number
    CMP #'9'
    BCS inputLoop
    
    SEC
    SBC #'0'
    TAX             ; Store input in X register
    LDA #32
    JSR CHROUT     ; Output a space
    RTS
    .endproc
    
    ; Print null-terminated string
    .proc PRINT
PRINT:
    LDY #0          ; Initialize Y register
    
printLoop:
    LDA (Y), Y      ; Load next character
    BEQ endPrint    ; Check for null terminator
    JSR CHROUT     ; Print character
    JMP printLoop   ; Continue printing
    
endPrint:
    RTS
    .endproc
