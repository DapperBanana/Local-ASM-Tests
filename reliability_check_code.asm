
ORG $1000 

START:
    LDX #0         ; Initialize index register X to 0
    LDA JOB_PROMPT ; Load job application prompt
LOOP:
    JSR PRINTSTR   ; Print the prompt
    JSR READLINE   ; Read user input
    CMP #0         ; Check if input is empty
    BEQ ENDLOOP    ; Exit loop if empty
    JSR SAVEINPUT  ; Save user input
    INX            ; Increment index
    BNE LOOP       ; Loop back to prompt
ENDLOOP:
    RTS            ; Return from subroutine

JOB_PROMPT:
    .BYTE 13,10,"Enter your name: ",0

SAVEINPUT:
    STX INPUT_INDEX ; Save current index to memory
    STX INPUT_LENGTH ; Save current input length to memory
    LDA #0          ; Reset index
    STA INPUT_INDEX
    RTS

PRINTSTR:
    LDX #0          ; Initialize index register X to 0
NEXTCHAR:
    LDA (MESSAGE),X ; Load next character from message
    BEQ PRINTDONE   ; If end of message, print done
    JSR PRINTCHAR   ; Print character
    INX             ; Increment index
    BNE NEXTCHAR    ; Continue to next character
PRINTDONE:
    RTS

PRINTCHAR:
    JSR $FFD2      ; ROM routine to print character
    RTS

READLINE:
    LDX #0          ; Initialize index register X to 0
NEXTKEY:
    JSR $FFCF      ; ROM routine to get keypress
    CMP #13        ; Check for enter key
    BEQ ENDLINE    ; End input if enter key
    JSR PRINTCHAR  ; Print character
    INX            ; Increment index
    BNE NEXTKEY    ; Continue to next character
ENDLINE:
    LDA #0         ; Null-terminate input
    JSR PRINTCHAR
    RTS

INPUT_INDEX: .BYTE 0
INPUT_LENGTH: .BYTE 0

MESSAGE:
    .BYTE 13,10,"Thank you for applying!",13,10,0

EOF:
