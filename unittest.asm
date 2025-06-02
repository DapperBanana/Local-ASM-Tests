
START:  LDX #7         ; Initialize counter to 7 for a heptagon
        LDA #0         ; Initialize area accumulator to 0
LOOP:   STA TEMP       ; Store the area accumulator in TEMP
        LDA #5         ; Load the constant 5 into the accumulator
        JSR MUL        ; Call the multiplication subroutine with the constant 5
        LDA TEMP       ; Load the stored area accumulator back into the accumulator
        CLC            ; Clear the carry flag
        ADC RESULT     ; Add the result of the multiplication to the area accumulator
        STA RESULT     ; Store the new area accumulator in RESULT
        DEX            ; Decrement the counter
        BNE LOOP       ; Branch back to LOOP if counter is not zero
        RTS

TEMP:   .BYTE 0         ; Temporary storage for the area accumulator
RESULT: .BYTE 0         ; Final result of the area calculation

MUL:    TAX            ; Transfer the constant to the X register
        LDA TEMP       ; Load the stored area accumulator into the accumulator
MULT:   CLC            ; Clear the carry flag
        ASL A          ; Multiply the accumulator by 2
        BCC NOMULT     ; Branch to NOMULT if no overflow
        ADC TEMP       ; Add the stored accumulator to the result if overflow
NOMULT: DEX            ; Decrement X register
        BNE MULT       ; Branch back to MULT if X register is not zero
        RTS
