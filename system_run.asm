
    .org $0200

START:
    LDA #$00            ; Initialize accumulator
    STA $FC             ; Clear screen 

PRINT_MESSAGE:
    LDX #$00            ; Initialize X register
PRINT_LOOP:
    LDA MESSAGE,X       ; Load character from message
    CPX #$00            ; Check for end of message
    BEQ END_PRINT       ; If end of message, exit print loop
    JSR PRINT_CHAR      ; Print character to screen
    INX                 ; Increment X register
    JMP PRINT_LOOP      ; Repeat until end of message

END_PRINT:
    RTS

PRINT_CHAR:
    JSR $FFD2           ; Print character to screen
    RTS

MESSAGE:
    .asciiz "Hello! How can I help you today?" 

    .end START
