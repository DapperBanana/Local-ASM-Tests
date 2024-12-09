
        ORG $2000
START   LDA #0              ; Initialize variables
        STA CURR_TERM
        LDA #1
        STA NEXT_TERM
        LDA #MAX_TERMS
        STA TERM_COUNT
LOOP    LDA CURR_TERM       ; Output current term
        JSR OUTPUT_TERM
        LDA CURR_TERM       ; Calculate next term
        CLC
        ADC NEXT_TERM
        STA TEMP
        LDA NEXT_TERM
        STA CURR_TERM
        LDA TEMP
        STA NEXT_TERM
        DEC TERM_COUNT
        BNE LOOP
END     BRK

OUTPUT_TERM
        ; Output the value in the A register
        ; (Write code here to output the value)
        RTS

MAX_TERMS .BYTE 10  ; Change this value to generate different number of terms
CURR_TERM .BYTE 0
NEXT_TERM .BYTE 0
TERM_COUNT .BYTE 0
TEMP      .BYTE 0

        .END
