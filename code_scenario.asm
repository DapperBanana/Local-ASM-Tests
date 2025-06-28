
; 6502 Assembly program for a basic text-based chatbot

    .org $0200

start:
    SEI
    CLD
    LDX #$FF
    TXS

loop:
    JSR getInput
    JSR respond
    JMP loop

getInput:
    LDA #$00
    STA $00        ; clear input buffer
    LDX #$00       ; start with first character

inputLoop:
    JSR getChar    ; get user input character
    BEQ endInput   ; if user presses Enter, end input
    STA $0200, X   ; store character in input buffer
    INX
    CPX #$0F       ; check input buffer size
    BNE inputLoop

endInput:
    RTS

getChar:
    JSR $FFCF      ; COUT: Display prompt
    JSR $FFD2      ; CIN: Get character input
    RTS

respond:
    LDA $0200, X   ; get first character of input
    CMP #'H'
    BEQ hello
    CMP #'B'
    BEQ bye
    JMP unknown

hello:
    JSR sendHello
    RTS

bye:
    JSR sendBye
    BRK

sendHello:
    JSR $FFCF      ; COUT: Send "Hello, how can I help you?" message
    RTS

sendBye:
    JSR $FFCF      ; COUT: Send "Goodbye, have a nice day!" message
    RTS

unknown:
    JSR $FFCF      ; COUT: Send "I'm sorry, I don't understand." message
    RTS

    .end start
