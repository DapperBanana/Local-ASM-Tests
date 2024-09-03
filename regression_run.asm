
; Assuming the matrix is stored in memory starting at address $2000
; The matrix should be 3x3

; Define constants
matrixSize = 3

; Load address of matrix
    LDA #$20   ; Load high byte of address
    STA $FA    ; Store high byte in zero page
    LDA #$00   ; Load low byte of address
    STA $FB    ; Store low byte in zero page

; Check if matrix is invertible
    JSR checkInvertible
    BCS invertible
    JMP notInvertible

checkInvertible:
    LDX #0
    LDY #0

checkRows:
    LDY #0
    JSR checkRow

    INX
    CPX #matrixSize
    BCC checkRows

    RTS

checkRow:
    LDA $FA,X
    STA $FD
    INX
    LDA $FA,X
    STA $FE
    INX
    LDA $FA,X
    STA $FF

    LDX #0
    LDA $FD
    STA $FC
    INX
    LDA $FD
    SEC
    SBC $FE
    STA $FC
    INX
    LDA $FD
    SEC
    SBC $FF
    STA $FC

    LDA $FE
    STA $FB
    LDA $FC
    BEQ rowInvertible
    BCS rowInvertible
    SEC

rowInvertible:
    RTS

invertible:
    ; Matrix is invertible
    JMP end

notInvertible:
    ; Matrix is not invertible
    JMP end

end:
    BRK
