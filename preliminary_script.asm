
; Hangman Game

.PRG

START:
    JSR INIT_GAME
    
MAIN_LOOP:
    JSR DISPLAY_BOARD
    JSR GET_GUESS
    
    LDA GUESS
    CMP WORD,Y
    BEQ END_GAME
    
    JSR UPDATE_BOARD
    
    JMP MAIN_LOOP

INIT_GAME:
    LDX #0
INIT_LOOP:
    LDA WORD,X
    STA BOARD,X
    INX
    CPX #8
    BNE INIT_LOOP
    
    RTS

DISPLAY_BOARD:
    LDX #0
DISPLAY_LOOP:
    LDA BOARD,X
    STA $600,X
    INX
    CPX #8
    BNE DISPLAY_LOOP
    
    RTS

GET_GUESS:
    LDA #0
    JSR $FFCF
    
    STA GUESS
    
    RTS

UPDATE_BOARD:
    LDX #0
UPDATE_LOOP:
    LDA WORD,Y
    CMP GUESS
    BEQ UPDATE_CHAR
    INY
    INX
    CPX #8
    BNE UPDATE_LOOP
    
    RTS

UPDATE_CHAR:
    LDA GUESS
    STA BOARD,Y
    
    RTS

END_GAME:
    RTS

GUESS:
    .BYTE 0

WORD:
    .BYTE "HANGMAN"
    
BOARD:
    .BYTE "_______"

    .END
