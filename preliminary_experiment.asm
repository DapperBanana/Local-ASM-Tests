
ORG $C000
START:
    LDX #0        ; initialize index register for looping through job applications
    LDY #0        ; initialize index register for storing user input
    
PRINT_TEXT:
    LDA TEXT_MSG, Y   ; load current character of text message into accumulator
    BEQ INPUT_MSG  ; if end of message reached, go to user input
    
    JSR $FFD2     ; call KERNAL routine to print character
    INY           ; increment index register
    JMP PRINT_TEXT

INPUT_MSG:
    LDX #0        ; initialize index register for storing user input
    LDA #$00      ; clear accumulator
    STA INPUT_BUF, X  ; clear input buffer

READ_INPUT:
    JSR $FFE4     ; call KERNAL routine to get user input
    CMP #$0D      ; check if Enter key pressed
    BEQ PROCESS_INPUT  ; if Enter key pressed, go to processing input

    STA INPUT_BUF, X  ; store user input in buffer
    INX            ; increment index register
    JMP READ_INPUT

PROCESS_INPUT:
    LDA INPUT_BUF, X  ; load first character of input
    CMP #'Q'        ; check if user input is 'Q' to quit
    BEQ QUIT        ; if 'Q' pressed, quit program

    STA APPLICANT_NAME, X ; store applicant's name
    INX                ; increment index register
    LDA #'C'           ; load 'C' for confirmation message
    STA CONF_MSG       ; store confirmation message character

CONFIRM_APPLICANT:
    LDA CONF_MSG
    BEQ PRINT_TEXT     ; if end of confirmation message reached, print text message
    JSR $FFD2          ; print confirmation message character
    JMP CONFIRM_APPLICANT

QUIT:
    BRK             ; end program

TEXT_MSG:  .BYTE "Welcome to the job application system! Please enter your name: "
CONF_MSG:  .BYTE "Thank you for applying! Press 'Q' to quit or enter your name: "
INPUT_BUF: .BLKB 30
APPLICANT_NAME: .BLKB 30

