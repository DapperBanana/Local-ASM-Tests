
; Program to calculate the area of a circle given its radius

    .org $0200
    LDX #10             ; Load the radius value (change as needed)
    JSR CalculateArea   ; Call the subroutine to calculate the area
    BRK                 ; End of program

CalculateArea:
    STX radius          ; Store the radius value in memory
    LDA radius          ; Load the radius value
    JSR Multiply        ; Call the subroutine to square the radius
    
    LDX result          ; Load the squared radius value
    LDA #3              ; Load the constant pi value
    JSR Multiply        ; Call the subroutine to multiply by pi
    
    STA area            ; Store the calculated area value
    RTS                 ; Return from subroutine

Multiply:
    STX operand2        ; Store operand2 value in memory
    LDA #0              ; Initialize accumulator to 0
    STA result          ; Initialize result to 0
    
multiplyLoop:
    LDA operand2        ; Load operand2 value
    BNE multiplyCalc    ; If operand2 is not 0, calculate
    RTS                 ; Return if done
    
multiplyCalc:
    CLC                 ; Clear carry flag
    ADC result          ; Add result to accumulator
    DEC operand2        ; Decrement operand2
    JMP multiplyLoop    ; Repeat multiplication

    .org $0300
radius: .byte 0
operand2: .byte 0
result: .byte 0
area: .byte 0
