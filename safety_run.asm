
; 6502 Assembly program for a basic text-based weather forecasting system

    .addr    $0200    ; Start program at memory address $0200
    
    .org     $0200    ; Origin of program
    
Start:
    LDX     #0       ; Initialize counter
    
InputLoop:
    LDA     Prompt,X ; Load prompt message
    JSR     PrintMsg ; Print prompt message
    
    LDA     #$20     ; Load ASCII space character
    JSR     GetChar  ; Read user input
    
    CMP     #$59     ; Check if input is 'Y'
    BEQ     Rainy    ; If 'Y', jump to Rainy weather message
    
    CMP     #$4E     ; Check if input is 'N'
    BEQ     Sunny    ; If 'N', jump to Sunny weather message
    
    INX              ; Increment counter
    CPX     #3       ; Check if all 3 prompts have been answered
    BNE     InputLoop; If not, loop back to get next input
    
    JMP     End      ; If all inputs have been answered, jump to end of program
    
Rainy:
    LDA     #RainMsg ; Load Rainy weather message
    JSR     PrintMsg ; Print Rainy weather message
    JMP     End      ; Jump to end of program
    
Sunny:
    LDA     #SunnyMsg ; Load Sunny weather message
    JSR     PrintMsg  ; Print Sunny weather message
    JMP     End       ; Jump to end of program
    
End:
    BRK               ; End program execution

Prompt:
    .text    "Is it going to rain today? (Y/N) "
    .byte    $00      ; Null terminator
    
RainMsg:
    .text    "It is going to rain today. Don't forget your umbrella! "
    .byte    $00      ; Null terminator
    
SunnyMsg:
    .text    "It is going to be sunny today. Enjoy the nice weather! "
    .byte    $00      ; Null terminator
    
PrintMsg:
    LDY     #0        ; Initialize index
    
PrintLoop:
    LDA     $80,Y     ; Load message character
    BEQ     PrintEnd  ; If null terminator, end print loop
    JSR     $FFD2     ; Print character to screen
    INY               ; Increment index
    JMP     PrintLoop ; Loop back to print next character
    
PrintEnd:
    RTS              ; Return from subroutine
