
        JSR INPUT
        STA NUM
        JSR FACT
        LDA FACTORIAL
        STA RESULT
        JSR OUTPUT
        BRK

INPUT:  LDX #00
        STX TEMP
INPUT_LOOP:
        LDA $FF00,X
        CMP #0D
        BEQ INPUT_DONE
        SEC
        SBC #30
        TAX
        LDA TEMP
        ASL
        ASL
        ASL
        ASL
        ASL
        CLC
        ADC A
        TAX
        INX
        JMP INPUT_LOOP
INPUT_DONE:
        RTS

FACT:   LDX NUM
        CPX #01
        BEQ BASE_CASE
        DEX
        JSR FACT
        LDA NUM
        STA TEMP
        LDA FACTORIAL
        STA TEMP2
        LDX TEMP2
        JSR MULTIPLY
        STA FACTORIAL
        RTS

BASE_CASE:
        LDA #01
        STA FACTORIAL
        RTS

MULTIPLY:
        LDY #0
        TXA
MULT_LOOP:
        CLC
        ADC FACTORIAL,Y
        STA FACTORIAL,Y
        INY
        CPY #02
        BNE MULT_LOOP
        RTS

NUM:    .BYTE 0
FACTORIAL: .BYTE 0
RESULT: .BYTE 0
TEMP:   .BYTE 0
TEMP2:  .BYTE 0
