
    ORG $1000
START:
    LDX #$08        ; Initialize X register to 8 as we are converting 8-bit decimal numbers
    LDA #Decimal    ; Load the decimal number into the accumulator
    STA Output      ; Store the decimal number in the Output buffer
CONVERT_LOOP:
    ASL Output      ; Shift the bits in the Output buffer to the left
    BCC BIT_ZERO    ; Branch if the carry flag is not set
    ORA #1          ; Set the least significant bit to 1
BIT_ZERO:
    ADC Output      ; Add the original value of Output back in
    BCC SKIP_SHIFT  ; Branch if no overflow occurred
    SEC             ; Set the carry flag for the subtract operation
    SBC #$0A        ; Subtract 10 to correct the decimal value
SKIP_SHIFT:
    DEX             ; Decrement the counter
    BNE CONVERT_LOOP; Loop back if X is not zero
    BRK             ; Exit the program

Decimal: .BYTE $35     ; Decimal number to convert (53 in decimal)

Output:  .BYTE $00     ; Output buffer to store the binary conversion

    .END
