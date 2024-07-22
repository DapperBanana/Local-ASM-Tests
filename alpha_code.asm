
    .org $0200
START:
    LDX #0           ; Initialize index register
LOOP:
    LDA PROMPT,X     ; Load prompt message character
    BEQ END          ; Check for end of message
    JSR PRINTCHAR    ; Print character to screen
    INX              ; Increment index register
    JMP LOOP         ; Loop to next character
END:
    LDA #0
    STA $FFFC        ; End program
    RTS

PROMPT:
    .byte "Enter the current temperature: ", $00

PRINTCHAR:   ; Subroutine to print character in A to screen
    STA $D012    ; Write character to screen
    RTS

    .end
