
START:  LDX #0        ; Initialize the game board
        STX BOARD

        LDA #32       ; Print out the empty game board
PRINT:  JSR $FFD2     ;   ASCII char to screen
        INX
        CPX #9
        BNE PRINT

GAME:   JSR PRINT      ; Prompt player X to make a move
        LDA #88       ; Player X symbol
        JSR INPUT

        JSR CHECKWIN   ; Check if player X has won
        BCS XWIN

        JSR PRINT      ; Prompt player O to make a move
        LDA #79       ; Player O symbol
        JSR INPUT

        JSR CHECKWIN   ; Check if player O has won
        BCS OWIN

        JMP GAME       ; Continue game loop

XWIN:   LDA #32
        JSR PRINT

        LDA #88
        JSR PRINT
        LDA #87
        JSR PRINT
        LDA #73
        JSR PRINT
        LDA #78
        JSR PRINT

        LDA #32
        JSR PRINT

        RTS

OWIN:   LDA #32
        JSR PRINT

        LDA #79
        JSR PRINT
        LDA #32
        JSR PRINT
        LDA #87
        JSR PRINT
        LDA #73
        JSR PRINT
        LDA #78
        JSR PRINT

        LDA #32
        JSR PRINT

        RTS

INPUT:  JSR $FFD0     ; Get user input
        STA BOARD,X   ; Store user input in game board
        RTS

CHECKWIN:
        LDA BOARD
        CMP BOARD+1
        CMP BOARD+2
        BEQ WIN

        LDA BOARD+3
        CMP BOARD+4
        CMP BOARD+5
        BEQ WIN

        LDA BOARD+6
        CMP BOARD+7
        CMP BOARD+8
        BEQ WIN

        LDA BOARD
        CMP BOARD+3
        CMP BOARD+6
        BEQ WIN

        LDA BOARD+1
        CMP BOARD+4
        CMP BOARD+7
        BEQ WIN

        LDA BOARD+2
        CMP BOARD+5
        CMP BOARD+8
        BEQ WIN

        LDA BOARD
        CMP BOARD+4
        CMP BOARD+8
        BEQ WIN

        LDA BOARD+2
        CMP BOARD+4
        CMP BOARD+6
        BEQ WIN

        BCC NOMOVE
        LDA #255
        RTS

WIN:    LDA #255
        RTS

NOMOVE: LDA #0
        RTS

BOARD:  .BYTE 9,9,9,9,32,9,9,9,9
