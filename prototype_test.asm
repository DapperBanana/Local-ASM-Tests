
.PROGRAM DecimalToBinary

        ; Define memory addresses for variables
NUM     .ADDR
BINARY  .ADDR
COUNT   .ADDR

        ; Initialize variables
        LDA #0
        STA COUNT
        LDA #0
        STA BINARY

INPUT:  ; Get input decimal number
        LDA #' '
        JSR $FFD2
        JSR $FFD2
        JSR $FFD2
        LDA #' '
        JSR $FFD2
        LDA #' '
        JSR $FFD2

        ; Convert input ASCII number to binary
        LDA NUM
        CMP #$30
        BCC DONE
        CMP #$39
        BCS DONE
        SEC
        LDA NUM
        SBC #$30
        STA NUM
        LDX #10
        LDA COUNT
        CLC

LOOP:   LSR
        ROL BINARY
        DEX
        BNE LOOP
        STA COUNT
        INX
        STA COUNT

        LDA NUM
        BEQ DONE
        STA TEMP
        CLC
        ASL NUM
        ROL NUM
        ROL NUM
        ROL NUM
        LDA TEMP
        SBC #$30
        STA NUM

        JMP LOOP

DONE:   ; Display binary equivalent
        LDA #'B'
        JSR $FFD2
        JSR $FFD2

        LDX #8
PRINT:  LDX #8
        LDA BINARY
        AND #%10000000
        BNE ONE
        LDA #48
ZERO:   JSR $FFD2
        LSR
        DEX
        BNE PRINT
        RTS

ONE:    LDA #49
        JMP ZERO
        RTS

