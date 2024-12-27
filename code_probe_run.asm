
; Program to perform addition and subtraction operations on a 3x3 matrix

        .org $0200

MatrixA .byte $01, $02, $03
        .byte $04, $05, $06
        .byte $07, $08, $09

MatrixB .byte $09, $08, $07
        .byte $06, $05, $04
        .byte $03, $02, $01

Result  .byte 9 dup(0)

        ; Load matrix A and matrix B into memory
        LDA #0
        LDX #0
loadA:  LDA MatrixA, X
        STA $0100, X
        INX
        CPX #9
        BNE loadA

        LDX #0
loadB:  LDA MatrixB, X
        STA $0200, X
        INX
        CPX #9
        BNE loadB

        ; Perform addition of matrices A and B
        LDX #0
addLoop: LDA $0100, X
        CLC
        ADC $0200, X
        STA Result, X
        INX
        CPX #9
        BNE addLoop

        ; Perform subtraction of matrices A and B
        LDX #0
subLoop: LDA $0100, X
        SEC
        SBC $0200, X
        STA Result, X
        INX
        CPX #9
        BNE subLoop

        ; Halt the program
halt:   BRK

        .end
