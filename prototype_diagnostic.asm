
; Tic Tac Toe Game in 6502 Assembly

; Constants
BLACK = $00
WHITE = $20
RED = $0D
GREEN = $0A
BLUE = $09
RESET = $01
CR = $0D
SPACE = $20
COMMA = $2C
QUESTION = $3F
DOT = $2E

; Memory locations
HORIZONTAL = $F0
VERTICAL = $F1
PLAYER = $F2
CURSOR = $F3
CURRENT_TURN = $F4
BOARD = $F5

; Start of program
Start:
    LDA RESET
    STA $D020     ; Set border to black
    STA $D021     ; Set background to black
    LDA #$3F
    STA $01       ; Set cursor to top left corner

    ; Initialize variables
    LDA #$01
    STA PLAYER
    LDA #$11
    STA CURSOR
    LDA #$01
    STA CURRENT_TURN

    ; Display instructions
    JSR ClearScreen
    LDA #<Instructions
    LDY #>Instructions
    JSR PrintString

GameLoop:
    ; Update board
    LDA CURRENT_TURN
    CMP #$01
    BEQ Player1Turn
    BNE Player2Turn

Player1Turn:
    LDA #$0D
    STA HORIZONTAL
    LDA #$2E
    STA VERTICAL
    JSR UpdateBoard
    JMP CheckWinner

Player2Turn:
    LDA #$0D
    STA HORIZONTAL
    LDA #$2F
    STA VERTICAL
    JSR UpdateBoard
    JMP CheckWinner

CheckWinner:
    ; Check for a winner
    JSR CheckHorizontal
    JSR CheckVertical
    JSR CheckDiagonal
    CMP #$20
    BEQ GameOver
    JMP SwitchPlayer

SwitchPlayer:
    LDA CURRENT_TURN
    EOR #$10
    STA CURRENT_TURN
    JMP GameLoop

GameOver:
    LDA #<WinnerMessage
    LDY #>WinnerMessage
    JSR PrintString
    RTS

UpdateBoard:
    LDA CURSOR
    STA BOARD, X
    JMP DrawBoard

DrawBoard:
    LDY #$00   ; Start position of board
DrawLoop:
    LDA BOARD, Y
    BEQ DrawDone
    JSR PrintChar
    INY
    JMP DrawLoop

DrawDone:
    JMP GameLoop

CheckHorizontal:
    LDA HORIZONTAL
    ASL
    TAX
    LDA BOARD, X
    EOR BOARD, X+1
    EOR BOARD, X+2
    ATA BOARD, X+3
    RTS

CheckVertical:
    LDA VERTICAL
    ASL
    TAX
    LDA BOARD, X
    EOR BOARD, X+4
    EOR BOARD, X+8
    ATA BOARD, X+12
    RTS

CheckDiagonal:
    LDA #$00
    LDY #$00
    LDX #$00
    LDA BOARD, Y
    EOR BOARD, Y+5
    EOR BOARD, Y+10
    ATA BOARD, Y+15
    LDA BOARD, X+2
    EOR BOARD, Y+5
    EOR BOARD, Y+10
    ATA BOARD, Y+15
    RTS

PrintString:
    LDA (Y), X
    BEQ PrintDone
    JSR PrintChar
    INX
    JMP PrintString

PrintChar:
    STA $D800
    INX
    JMP PrintChar

PrintDone:
    RTS

Instructions:
    .BYTE QUESTION, SPACE
    .BYTE DOT, DOT, DOT, CR
    .BYTE SPACE, SPACE, SPACE, SPACE
    .BYTE QUESTION, DOT, QUESTION, SPACE
    .BYTE DOT, CR
    .BYTE SPACE, QUESTION, DOT, SPACE
    .BYTE DOT, DOT, DOT, CR
    .BYTE SPACE, SPACE, SPACE, SPACE
    .BYTE QUESTION, DOT, DOT, DOT, CR
    .BYTE CR

WinnerMessage:
    .BYTE SPACE, SPACE, SPACE, SPACE
    .BYTE DOT, DOT, DOT, CR
    .BYTE SPACE, SPACE, DOT, SPACE
    .BYTE DOT, DOT, DOT, CR
    .BYTE SPACE, DOT, SPACE, SPACE
    .BYTE DOT, CR
    .BYTE CR

.END Start
