
        .org $0200

        LDA #MATRIX
        LDY #0
        JSR CALC_V0
        LDY #1
        JSR CALC_V0
        LDY #2
        JSR CALC_V0

        LDX #3              ; prepare to calculate cofactor 1
        LDA #MATRIX
        JSR CALC_COFACTOR

        LDX #4              ; prepare to calculate cofactor 2
        LDA #MATRIX
        JSR CALC_COFACTOR

        LDX #5              ; prepare to calculate cofactor 3
        LDA #MATRIX
        JSR CALC_COFACTOR

        LDX #DETERMINANT
        LDA D0
        STA (DETERMINANT),X  ; store the final determinant value

COMPLETE:
        BRK

DETERMINANT:
        .byte 0

MATRIX:
        .byte 1, 2, 3
        .byte 0, 4, 5
        .byte 7, 8, 9

CONSTANTS:
V0 = $00
D0 = $01

CALC_V0:
        LDA (V0),Y
        STA D0
        INY
        RTS

CALC_COFACTOR:
        STX V0
        LDA #0
        STA D0

        LDA #(MATRIX-1)
        CLC
        ADC V0
        TAX              ; calculate the offset to the start of cofactor matrix
        LDY #0
ROW_LOOP:
        LDA (V0),Y
        STA D0

        LDA MATRIX
        CLC
        ADC V0
        TAX
        LDA (V0),Y
        STA D0

        LDA MATRIX
        CLC
        ADC V0
        TAX
        LDA (V0),Y
        STA D0

        LSR D0           ; divide by 2
        LSR D0           ;  to get an average value

        LDA D0
        SEC
        SBC (D0),Y
        STA D0

        LDA MATRIX
        CLC
        ADC V0
        TAX
        LDA (D0),Y
        CLC
        ADC V0
        TAX
        LDA (D0),Y
        STA D0

        TYA
        CLC
        ADC #3
        TAY

        DEC X
        BEQ ADD_COFACTOR
        JMP ROW_LOOP

ADD_COFACTOR:
        LDA D0
        CLC
        ADC (DETERMINANT,X)  ; add the calculated cofactor to the final determinant
        STA (DETERMINANT),X

        RTS
