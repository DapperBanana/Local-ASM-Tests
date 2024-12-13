
        .segment "CODE"
START:  LDX #10     ; Number of sides in a decagon
        LDA #5      ; Length of one side of the decagon
        JSR CALC_AREA  ; Call subroutine to calculate area
        STA RESULT  ; Store result in memory
        BRK         ; End program

CALC_AREA:
        CLC         ; Clear carry flag
        LDA #0      ; Initialize accumulator to 0
LOOP:   ADC RESULT  ; Add length of side to accumulator
        DEX         ; Decrement counter
        BNE LOOP    ; Loop until all sides are accounted for
        LSR         ; Divide accumulator by 2 to get apothem
        ASL         ; Shift back left to get area
        RTS         ; Return from subroutine

RESULT: .byte 0
