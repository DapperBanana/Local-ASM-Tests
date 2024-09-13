
    .org $0600

start
    LDX #9         ; Number of sides of the nonagon
    LDA #$00       ; Initialize the area accumulator
    LDA #$18       ; Length of one side of the nonagon
    STA $00        ; Store the length in memory
    CLC
    ADC $00        ; Add the length to the accumulator
    STA $01        ; Store the result in memory
loop
    DEX            ; Decrement side counter
    BEQ exit       ; If all sides have been calculated, exit the loop
    CLC
    ADC $01        ; Add the previous result to the accumulator
    STA $01        ; Store the result in memory
    BNE loop       ; Continue the loop

exit
    LDY #$00       ; Clear Y register for division
    LDA $01        ; Load the final area value into the A register
    JSR convert    ; Call subroutine to convert the area value to decimal
    BRK            ; End of program

convert
    JSR div10      ; Divide the area value by 10
    STA $01        ; Store the decimal result in memory
    LDA #$30       ; Add ASCII offset to convert to decimal
    ADC #$30
    STA $02        ; Store the converted value in memory
    DEX            ; Decrement the exponent counter
    BNE convert     ; Continue conversion until all digits are converted
    RTS            ; Return from subroutine

div10
    LDA #$00       ; Clear carry
    LDX #$04       ; Set exponent counter
loopdiv
    ASL $01        ; Shift left the area value
    ROL $02        ; Shift left the result
    BCC skip       ; If no overflow, skip subtraction
    SEC
    SBC #$0A       ; Subtract 10 if overflow
skip
    DEX            ; Decrement the exponent counter
    BNE loopdiv    ; Continue loop until all digits are converted
    RTS            ; Return from subroutine
