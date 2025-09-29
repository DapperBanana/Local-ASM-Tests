
.org $0200

; Load matrix into memory
    LDX #0
loadMatrix:
    LDA matrix, X
    STA $FE00, X
    INX
    CPX #9
    BNE loadMatrix

; Check row sums
    LDA #$00
    STA $FE09
    LDX #0
checkRows:
    LDA #$00
    STA $FE08
    LDY #0
    LDA $FE00, X
    CLC
    ADC $FE01, X
    ADC $FE02, X
    STA $FE08
    LDX #0
    LDA $FE03, X
    CLC
    ADC $FE04, X
    ADC $FE05, X
    STA $FE08
    LDX #0
    LDA $FE06, X
    CLC
    ADC $FE07, X
    ADC $FE08, X
    STA $FE08
    LDA $FE09
    CMP $FE08
    BNE notMagic

; Check column sums
    LDA #$00
    STA $FE09
    LDY #0
checkColumns:
    LDA #$00
    STA $FE08
    LDX #0
    LDA $FE00, Y
    CLC
    ADC $FE03, Y
    ADC $FE06, Y
    STA $FE08
    LDY #0
    LDA $FE01, Y
    CLC
    ADC $FE04, Y
    ADC $FE07, Y
    STA $FE08
    LDY #0
    LDA $FE02, Y
    CLC
    ADC $FE05, Y
    ADC $FE08, Y
    STA $FE08
    LDA $FE09
    CMP $FE08
    BNE notMagic

; Matrix is a magic torus
    BRK

notMagic:
    BRK

matrix:
    .byte 1, 5, 9, 6
    .byte 8, 2, 3, 4
    .byte 7, 11, 12, 13

.end
