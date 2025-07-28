
; 6502 Assembly program to calculate GCD of two numbers

        ; Load first number into A
        LDX #NUM1_HI
        LDY #NUM1_LO
        JSR GET_NUMBER

        ; Store first number in NUM1
        STA NUM1_LO
        STY NUM1_HI

        ; Load second number into A
        LDX #NUM2_HI
        LDY #NUM2_LO
        JSR GET_NUMBER

        ; Store second number in NUM2
        STA NUM2_LO
        STY NUM2_HI

        ; Initialize counter
        LDA #0
        STA COUNTER

LOOP    ; Compare NUM1 and NUM2
        LDA NUM1_HI
        SEC
        SBC NUM2_HI
        BNE NOT_EQUAL_HI
        LDA NUM1_LO
        SEC
        SBC NUM2_LO
        BNE NOT_EQUAL_LO

        ; If NUM1 = NUM2, print result and exit
        JSR PRINT_RESULT
        RTS

NOT_EQUAL_LO
        CMP NUM2_LO
        BCC NUM1_LESS_THAN_NUM2
        BCS NUM1_GREATER_THAN_NUM2

NUM1_LESS_THAN_NUM2
        STA NUM2_LO

NEXT
        LDX NUM2_HI
        DEX
        STX NUM2_HI

        LDA COUNTER
        CLC
        ADC #1
        STA COUNTER

        JMP LOOP

NUM1_GREATER_THAN_NUM2
        STA NUM1_LO

NEXT
        LDX NUM1_HI
        DEX
        STX NUM1_HI

        LDA COUNTER
        CLC
        ADC #1
        STA COUNTER
        JMP LOOP

PRINT_RESULT
        LDA NUM1_HI
        JSR PRINT_HEX
        LDA NUM1_LO
        JSR PRINT_HEX
        RTS

; Function to get input number
GET_NUMBER
        JSR INPUT
        CMP #$30
        BCS CONTINUE
        JMP GET_NUMBER

CONTINUE
        SEC
        SBC #$30
        RTS

; Function to print hexadecimal number
PRINT_HEX
        AND #$0F
        CMP #$0A
        BCC PRINT_NUM
        ADC #$07

PRINT_NUM
        ORA #$30
        JSR OUTPUT
        RTS

; Memory locations
NUM1_HI .BYTE 0
NUM1_LO .BYTE 0
NUM2_HI .BYTE 0
NUM2_LO .BYTE 0
COUNTER .BYTE 0

        .END
