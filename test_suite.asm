
    .org $8000

    ; Constants
    CH_EOF = $FF     ; End of File marker
    CR = $0D         ; Carriage return
    LF = $0A         ; Line feed
    PROMPT MSG_IS "CHATBOT: Enter your message (max 20 characters): "
    RESPONSE_MSG IS "Hi there! How can I help you today?"

    ; Variables
    BUFFER .blk 21   ; Buffer to store user input

    ; Entry point
    Start:
        ; Display prompt message
        LDX #0
        JSR PrintString
        
        ; Get user input
        LDA #20        ; Max input length
        STA BUFFER+20  ; Initialize buffer end marker
        LDX #0         ; Initialize buffer index
    GetChar:
        JSR GetCharInput
        CMP #CR        ; Check for enter key
        BEQ ProcessInput
        STA BUFFER,X   ; Store input character in buffer
        INX
        BNE GetChar
        
    ProcessInput:
        LDA #0          ; Null-terminate buffer
        STA BUFFER,X
        LDA #<BUFFER    ; Load address of buffer
        LDY #>BUFFER
        JSR PrintString
        
        ; Check for "exit" command
        LDX #0
    CheckExit:
        LDA BUFFER,X
        CMP #"e"
        BNE NotExit
        INX
        LDA BUFFER,X
        CMP #"x"
        BNE NotExit
        INX
        LDA BUFFER,X
        CMP #"i"
        BNE NotExit
        INX
        LDA BUFFER,X
        CMP #"t"
        BNE NotExit
        INX
        LDA BUFFER,X
        BEQ ExitProgram
        
    NotExit:
        ; Display default response
        LDX #0
        JSR PrintResponse
        
        ; Loop back to get new input
        JMP GetChar
        
    ExitProgram:
        BRK

    ; Subroutine to print a null-terminated string from the specified address
    PrintString:
        LDY #0
    PrintChar:
        LDA (X),Y
        BEQ PrintEnd
        JSR $FFD2  ; COUT
        INY
        JMP PrintChar
    PrintEnd:
        RTS

    ; Subroutine to get a character from user input
    GetCharInput:
        lda #$FF
        sta $C000
        ldy #$00
    GetCharInputLoop:
        lda $C000
        cmp #$FF
        beq GetCharInputLoop
        lda $C000
        rts

    ; Subroutine to print the response message
    PrintResponse:
        LDX #0
        JSR PrintString
        RTS

    .end Start
