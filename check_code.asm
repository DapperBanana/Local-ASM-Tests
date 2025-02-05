
; Fantasy Sports Manager Program

        .org $0200
START   LDX #0          ; Initialize index register X to 0
LOOP    LDA PROMPT,X    ; Load character from prompt string
        BEQ DONE        ; If end of prompt string, exit
        JSR $FFD2       ; Print character
        INX             ; Increment index
        JMP LOOP        ; Repeat loop
DONE    RTS

PROMPT  .byte "Welcome to Fantasy Sports Manager! Press any key to continue.", $00

        .end
