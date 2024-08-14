
.ORG $0200

START:
    LDX #0           ; Initialize index register
    
DISPLAY_PROMPT:
    LDA PROMPT,X     ; Load character from prompt string
    BEQ GET_INPUT     ; If end of string, get input
    
    JSR $FFD2        ; Output character to screen
    INX              ; Increment index
    JMP DISPLAY_PROMPT

GET_INPUT:
    JSR $FFCF        ; Input a character
    
    CMP #$0D         ; Check if Enter key pressed
    BEQ PROCESS_INPUT
    
    STA $FB          ; Store input character in memory
    INX              ; Increment index
    JMP GET_INPUT

PROCESS_INPUT:
    LDX #0           ; Reset index register
    
    LDA $FB,X        ; Load first character of input
    CMP #'A'         ; Check if input is 'A'
    BEQ APPLY        ; If 'A', apply for job
    
    LDA $FB,X        ; Load second character of input
    CMP #'Q'         ; Check if input is 'Q'
    BEQ QUIT         ; If 'Q', quit program
    
    JMP INVALID_INPUT

APPLY:
    LDA #0           ; Clear accumulator
    STY $FC          ; Set Y register to 0
    
    LDY #0           ; Initialize index register
    
ENTER_NAME:
    LDA NAME_PROMPT,Y ; Load character from name prompt string
    BEQ ENTER_EMAIL   ; If end of string, enter email address
    
    JSR $FFD2        ; Output character to screen
    INY              ; Increment index
    JMP ENTER_NAME

ENTER_EMAIL:
    LDX #0           ; Reset index register
    
    LDY #0           ; Initialize index register
    
EMAIL_PROMPT:
    LDA EMAIL_PROMPT,Y ; Load character from email prompt string
    BEQ SUBMIT_APP    ; If end of string, submit application
    
    JSR $FFD2        ; Output character to screen
    INY              ; Increment index
    JMP EMAIL_PROMPT

SUBMIT_APP:
    JSR $FFD2        ; Output success message
    RTS              ; Return from subroutine

QUIT:
    RTS              ; Return from subroutine

INVALID_INPUT:
    JSR $FFD2        ; Output invalid input message
    RTS              ; Return from subroutine

PROMPT: 
    .BYTE "Would you like to apply for a job? (A)pply or (Q)uit: ", $00
    
NAME_PROMPT: 
    .BYTE "Enter your name: ", $00
    
EMAIL_PROMPT: 
    .BYTE "Enter your email address: ", $00
    
    .END

