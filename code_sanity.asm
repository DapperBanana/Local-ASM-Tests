
        ORG $0200

        LDA #35         ; Load the length of one side of the octagon
        STA SIDE

        LDA SIDE        ; Load the side length to accumulator
        ADC SIDE        ; Multiply side length by 2 (to get the length of the octagon's diagonal)
        STA DIAGONAL

        LDA DIAGONAL    ; Load the diagonal length to accumulator
        SEC
        SBC SIDE        ; Subtract the side length from the diagonal length
        STA HALFSIDE

        LDA SIDE        ; Load the side length to accumulator
        STA TEMPSIDE

        LDA DIAGONAL    ; Load the diagonal length to accumulator
        STA TEMPDIAG

        CLC
        LDA TEMPSIDE
        ADC HALFSIDE    ; Add half the side length to the parameter
          
        LDA TEMPSIDE
        JSR MULT        ; Calculate square of side and save the result in PRODUCT_1       

        LDA HALFSIDE
        JSR MULT        ; Calculate square of half-side and save the result in PRODUCT_2

        LDA PRODUCT_1
        SEC
        SBC PRODUCT_2 ; Subtract the square of half-side from the square of side 
        STA AREA

        RTS

MULT    PHA
        PLA
        STA MULTIPLIER_MUL1

        STX MULTIPLIER_MUL2
        LDA #$00
        STA RESULT
        STA RESULT+1
        TAX

DOUBLE_A    ASL A
        ROL MULTIPLIER_MUL1
        BCC SKIP_ADD_MUL2
        CLC
        LDA RESULT+1
        ADC MULTIPLIER_MUL2
        STA RESULT+1
SKIP_ADD_MUL2    LDA RESULT
        ADC MULTIPLIER_MUL1
        STA RESULT
        DEC X
        BNE DOUBLE_A
        LDA RESULT
        STA PRODUCT_1
        RTS

SIDE    .BYTE 0
DIAGONAL .BYTE 0
HALFSIDE .BYTE 0
MULTIPLIER_MUL1 .BYTE 0
MULTIPLIER_MUL2 .BYTE 0
RESULT  .WORD 0
AREA    .WORD 0
PRODUCT_1 .WORD 0
PRODUCT_2 .WORD 0
RESULT  .WORD 0
TEMPSIDE .BYTE 0
TEMPDIAG .BYTE 0

        END
