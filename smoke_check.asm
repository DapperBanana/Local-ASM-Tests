
ORG $0200

START:
    LDA TEMP_C         ; Load the Celsius temperature into the accumulator
    STA TEMP_F         ; Store the Celsius temperature in TEMP_F
    LDX #9             ; Load the constant 9 into X register
    STX MULTIPLIER     ; Store the multiplier in MULTIPLIER
    LDA #32            ; Load the constant 32 into the accumulator
    STA CONSTANT       ; Store the constant 32 in CONSTANT
    JSR MULT           ; Call the MULT subroutine to multiply TEMP_F by 9
    JSR DIV            ; Call the DIV subroutine to divide TEMP_F by 5
    LDA CONSTANT       ; Load the constant 32 back into the accumulator
    CLC                ; Clear the carry flag
    ADC TEMP_F         ; Add TEMP_F to the accumulator
    STA TEMP_F         ; Store the result in TEMP_F
    RTS                ; Return from subroutine

MULT:                  ; Multiply TEMP_F by 9
    LDA TEMP_F
    CLC
    ADC TEMP_F
    ADC TEMP_F
    ADC TEMP_F
    STA TEMP_F
    RTS

DIV:                   ; Divide TEMP_F by 5
    LDA TEMP_F
    LSR
    LSR
    LSR
    STA TEMP_F
    RTS

TEMP_C: .BYTE 25       ; Celsius temperature (input)
TEMP_F: .BYTE 0        ; Fahrenheit temperature (output)
MULTIPLIER: .BYTE 0
CONSTANT: .BYTE 0

.END
