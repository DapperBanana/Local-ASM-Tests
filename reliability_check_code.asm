
        .org $0200
START   LDX #MESSAGES
        STX MESSAGE_PTR

LOOP    JSR PRINT_PROMPT
        JSR GET_INPUT
        JSR RESPOND
        JSR PRINT_RESPONSE
        JMP LOOP

PRINT_PROMPT
        LDA #MSG_PROMPT
        JSR PRINT_STRING
        RTS

GET_INPUT
        LDX #BUFFER
        LDY #$00
READ    JSR GET_CHAR
        STY ,X
        INX
        CPY #MAX_LENGTH
        BNE READ
        RTS

GET_CHAR
        LDA #$FF
        JSR $FFCF
        RTS

RESPOND
        LDA #MSG_HI
        JSR PRINT_STRING
        RTS

PRINT_RESPONSE
        LDX #BUFFER
        JSR PRINT_STRING
        RTS

PRINT_STRING
        LDY #0
PRINT_LOOP
        LDA (Y,X)
        BEQ PRINT_DONE
        JSR $FFD2
        INY
        JMP PRINT_LOOP
PRINT_DONE
        RTS

BUFFER      .block $20
MESSAGE_PTR .block $02

MSG_PROMPT  .text    "> "
MSG_HI      .text    "Hello! How can I help you?"
MESSAGES
        .text    "I am just a simple chatbot. What can I do for you?"
        .text    "Let's chat some more!"
        .text    "Goodbye!"

MAX_LENGTH  = $20

        .end
