
ORG $0200

LDA #0
STA NUM1
STA NUM2
STA RESULT
LDA #0
STA OPERATION

LOOP        LDX #0
            LDY #0
            LDA OPERATION
            CMP #1
            BEQ ADD
            CMP #2
            BEQ SUB
            CMP #3
            BEQ MUL
            CMP #4
            BEQ DIV

GET_NUM     LDA #' '
            JSR $FFD2
            JSR $FFCF
            CMP #10
            BEQ COMPUTE
            SEC
            SBC #48
            TAX
            LDX NUM1
            LDA #0
            STA NUM1,Y
            STX NUM1,Y
            INY
            STY NUM1
            JMP GET_NUM

ADD         LDA #'1'
            STA OPERATION
            JSR GET_NUM
            LDX #0
SUM_LOOP    LDA NUM1,X
            CLC
            ADC NUM2,X
            STA RESULT,X
            INX
            CPX #2
            BNE SUM_LOOP
            JMP PRINT_RESULT

SUB         LDA #'2'
            STA OPERATION
            JSR GET_NUM
            LDX #0
DIFF_LOOP   LDA NUM1,X
            SEC
            SBC NUM2,X
            STA RESULT,X
            INX
            CPX #2
            BNE DIFF_LOOP
            JMP PRINT_RESULT

MUL         LDA #'3'
            STA OPERATION
            JSR GET_NUM
            LDX #0
            LDA #0
            STA NUM1
MUL_LOOP    LDA NUM2
            CMP #0
            BEQ PRINT_RESULT
            SEC
            SBC #1
            STA NUM2
            LDA RESULT
            CLC
            ADC NUM1,X
            STA RESULT
            INX
            JMP MUL_LOOP

DIV         LDA #'4'
            STA OPERATION
            JSR GET_NUM
            LDX #0
            LDA NUM1
            SEC
            SBC NUM2
            STA RESULT
            JSR PRINT_RESULT

PRINT_RESULT
            LDA #' '
            JSR $FFD2
            JSR $FFCF
            LDX #0
            LDA RESULT
            JSR $FFD2
            LDA #' '
            JSR $FFD2
            RTS

COMPUTE     LDA #'*'
            STA OPERATION
            JMP MUL

            RTS

NUM1        .BYTE 2
NUM2        .BYTE 2
RESULT      .BYTE 2
OPERATION   .BYTE 1

END
