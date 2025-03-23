
* Basic text-based tic-tac-toe game in 6502 Assembly

* Set up variables
    .org $0600      ;start of program
    BOARD .byte $20, $20, $20, $20, $20, $20, $20, $20, $20
    PLAYER .byte $01
    GAME_OVER .byte $00

* Display initial game board
    LDX #$00
LOOP
    LDA BOARD, X
    JSR $FFD2    ; CHROUT
    INX
    CPX #$03
    BCC LOOP
    
* Main game loop
MAIN_LOOP
    LDA PLAYER
    JSR $FFD2
    JSR GET_INPUT
    
    TAX
    LDA BOARD, X
    BEQ SET_BOARD
    
    LDA #'Invalid move'
    JSR $FFD2
    JMP MAIN_LOOP

SET_BOARD
    LDA PLAYER
    STA BOARD, X
    
    JSR CHECK_GAME_OVER
    
    LDA PLAYER
    CMP #$01
    BEQ PLAYER_2
    
    LDA #'O'
    JMP DISPLAY_PLAYER
    
PLAYER_2
    LDA #'X'
    
DISPLAY_PLAYER
    JSR $FFD2
    
    LDA PLAYER
    EOR #$03
    STA PLAYER
    
    JMP MAIN_LOOP

* Get player input
GET_INPUT
    LDA #'Enter row (0-2)'
    JSR $FFD2
    JSR $FFD2

    LDA #'Enter column (0-2)'
    JSR $FFD2
    JSR $FFD2
    
    LDA $FF
    SEC
    SBC #$30
    CMP #$02
    BCC INVALID_INPUT
    ASL A
    
    LDX A
    LDA $FF
    SEC
    SBC #$30
    CMP #$02
    
    INVALID_INPUT
    RTS

* Check for game over condition
CHECK_GAME_OVER
    LDX #$00
ROW_CHECK
    LDA BOARD, X
    STA $FE
    INX
    LDA BOARD, X
    EOR $FE
    STA $FF
    INX
    LDA BOARD, X
    EOR $FF
    STA $FF
    
    INX
    CPX #$03
    BCC ROW_CHECK
    
    BCS GAME_OVER
    
    LDX #$00
DIAG_CHECK
    LDA BOARD, X
    STA $FE
    INX
    LDA BOARD, X
    STA $FF
    INX
    LDA BOARD, X
    STA $FF
    
    LDX #$00
COL_CHECK
    LDA BOARD, X
    STA $FE
    TXA
    CLC
    ADC #$03
    LDX A
    LDA BOARD, X
    STA $FF
    TXA
    CLC
    ADC #$06
    LDX A
    LDA BOARD, X
    STA $FF
    
    LDX $FE
    STA $FE
    LDX $FF
    EOR $FF
    BNE NOT_GAME_OVER
    
    INC GAME_OVER
    RTS
    
NOT_GAME_OVER
    LDX #$00
    INY
CHECK_TIE
    LDA BOARD, X
    BEQ NOT_TIE
    INX
    CPX #$09
    BCC CHECK_TIE
    
    LDA #'It''s a tie!'
    JMP DISPLAY_END
    
NOT_TIE
    RTS
    
GAME_OVER
    LDA PLAYER
    CMP #$01
    BEQ PLAYER_2_WINS
    
    LDA #'Player 1 wins!'
    JMP DISPLAY_END
    
PLAYER_2_WINS
    LDA #'Player 2 wins!'
    
DISPLAY_END
    JSR $FFD2
    RTS
