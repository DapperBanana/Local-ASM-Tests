
; Decimal to Binary conversion program

.ORG $0200

LDA #0          ; Accumulator = 0
STA $01         ; Store the converted binary number in memory location $01

LDX #7          ; Start from the most significant bit (MSB)

ConversionLoop:
    ASL           ; Left shift the accumulator
    PHP           ; Push the processor status to the stack
    CLC           ; Clear the carry flag

    LDA $00       ; Load the decimal number from memory location $00
    ROL           ; Rotate the decimal number left into the carry

    LSR           ; Shift the carry into the accumulator
    
    PLP           ; Pull the processor status from the stack
    BCC NotCarry  ; Branch if there is no carry
    ORA #1        ; OR the accumulator with 1 if there is a carry
NotCarry:
    
    STA $01       ; Store the result in memory location $01
    
    DEX           ; Decrement the X register
    BPL ConversionLoop ; Branch to the ConversionLoop if X is positive

; End of program
BRK             ; Break and end the program execution

.ORG $0220

DecimalNumber: .BYTE 42 ; Decimal number to convert to binary

.ORG $FE00
VECTOR: .WORD $0200
