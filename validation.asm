
START:  LDX #5
        LDY #4

        LDA SIDE       ; Load the side length of the pentagon
        STA TEMP1
        STA TEMP2

        JSR MULT        ; Calculate (5 * s^2)
        JSR DIV         ; Calculate (5 * s^2) / 4

        LDX #0xEA      ; Load the value of 180 into X register
        JSR TAN         ; Calculate tan(180 / 5)

        JSR DIV         ; Calculate area = (5 * s^2) / (4 * tan(180 / 5))

        STA AREA       ; Store the result in AREA

DONE:   BRK

MULT:   LDA TEMP1
        STA SUM

DEC1:   CLC
        ADC TEMP1
        DEX
        BNE DEC1

        LDA SUM
        STA TEMP1
        RTS

DIV:    LDX #0
DIV1:   CLC
        LDA TEMP1      ; Load the dividend
        CMP TEMP2      ; Compare with divisor
        BCC DIV2        ; If dividend < divisor, exit loop
        SBC TEMP2      ; Subtract divisor from dividend
        INX             ; Increment quotient
        JMP DIV1        ; Repeat loop
DIV2:   STA AREA
        RTS

TAN:    SEC
        SBC #0x2C      ; Subtract 5 from 180
        TXA
        JSR SIN
        PLA
        TXA
SIN:    PHP
        STA TEMP1
        LDA #0x00
        JSR MULT
        PLA
        CLC
        ADC #0x20
        JSR SIN
        SEC
        SBC #0x00
        RTS

SIDE:   .BYTE 6
TEMP1:  .BYTE 0
TEMP2:  .BYTE 0
SUM:    .BYTE 0
AREA:   .BYTE 0

        .ORG $1000
        JMP START
