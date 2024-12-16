
ORG $1000

start:
    LDX #$00       ; Set up accumulator index for matrix
    LDY #$00       ; Set up index for determinant calculation

    ; Load the matrix
    LDA matrix, X
    STA $FC        ; Store matrix element in $FC

    INX            ; Increment matrix index
    LDA matrix, X
    STA $FD        ; Store matrix element in $FD

    INX            ; Increment matrix index
    LDA matrix, X
    STA $FE        ; Store matrix element in $FE

    ; Calculate the determinant
    LDA $FC
    CLC
    ADC $FD
    ADC $FE        ; Add elements on the downward diagonal
    STA $FB

    LDA $FD
    SEC
    SBC $FC
    SBC $FE        ; Subtract elements on the upward diagonal
    STA $FA

    LDA $FE
    CLC
    ADC $FC
    ADC $FD        ; Add elements on the downward diagonal
    STA $F9

    ; Calculate determinant = (a*e*i) + (b*f*g) + (c*d*h) - (c*e*g) - (a*f*h) - (b*d*i)
    LDA $FE
    CLC
    ADC $FA
    ADC $F9
    STA $F8

    LDA $FB
    SEC
    SBC $FC
    SBC $F9
    STA $F7

    LDA $FD
    CLC
    ADC $F8
    ADC $FA
    STA $F6
    
    ; Store determinant in $F6
    LDA $F6
    STA determinant

    ; End program
    BRK

matrix:
    .BYTE $01, $02, $03
    .BYTE $04, $05, $06
    .BYTE $07, $08, $09

determinant:
    .BYTE $00

.END start
