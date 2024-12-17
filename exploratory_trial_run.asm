
; Rock-Paper-Scissors Game in 6502 Assembly Language

    .org $0200  ; Start address of the program

    LDX #$00    ; Initialize score counter for player
    LDY #$00    ; Initialize score counter for computer
    STX PlayerScore
    STY ComputerScore

GameLoop:
    JSR GetPlayerChoice
    JSR GetComputerChoice
    JSR DetermineWinner
    JSR DisplayResult
    JMP GameLoop

GetPlayerChoice:
    LDA #$00
    STA PlayerChoice
    LDX #$00
GetPlayerInput:
    LDA $C000, X
    CMP #$31  ; Check if input is '1' for rock
    BEQ RockChosen
    CMP #$32  ; Check if input is '2' for paper
    BEQ PaperChosen
    CMP #$33  ; Check if input is '3' for scissors
    BEQ ScissorsChosen
    INX
    CPX #$02  ; Check if input is valid
    BNE GetPlayerInput
    RTS

RockChosen:
    LDA #$01
    STA PlayerChoice
    RTS

PaperChosen:
    LDA #$02
    STA PlayerChoice
    RTS

ScissorsChosen:
    LDA #$03
    STA PlayerChoice
    RTS

GetComputerChoice:
    LDA #$00
    JSR Randomize
    LSR A
    AND #$03
    STA ComputerChoice
    RTS

Randomize:
    LDA $D020
    ROR A
    STA $D020
    RTS

DetermineWinner:
    CMP PlayerChoice, ComputerChoice
    BEQ Tie
    CMP PlayerChoice, #$01
    BEQ PlayerRock
    CMP PlayerChoice, #$02
    BEQ PlayerPaper
    CMP PlayerChoice, #$03
    BEQ PlayerScissors
    RTS

Tie:
    JMP UpdateScore

PlayerRock:
    CMP ComputerChoice, #$03
    BNE PlayerWins
    RTS

PlayerPaper:
    CMP ComputerChoice, #$01
    BNE PlayerWins
    RTS

PlayerScissors:
    CMP ComputerChoice, #$02
    BNE PlayerWins
    RTS

PlayerWins:
    INC PlayerScore
    RTS

UpdateScore:
    INC ComputerScore
    RTS

DisplayResult:
    LDA PlayerScore
    JSR DisplayScore
    LDA ComputerScore
    JSR DisplayScore
    RTS

DisplayScore:
    STA ScoreToDisplay
    LDA #$30
    CLD
    LDX #$02
GetDigit:
    LDA ScoreToDisplay
    DIV #$0A
    STA ScoreToDisplay
    ADC #$30
    STA $D020, X
    DEX
    BNE GetDigit
    RTS

PlayerScore:
    .byte #$00

ComputerScore:
    .byte #$00

PlayerChoice:
    .byte #$00

ComputerChoice:
    .byte #$00

ScoreToDisplay:
    .byte #$00

    .end
