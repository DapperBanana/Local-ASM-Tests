
;Program to calculate the surface area of a cube
;
;Formula for the surface area of a cube is 6 * length^2

.segment "CODE"

LDX #length ; Load length of cube into X register
JSR SQUARE ; Call subroutine to square the length
TAY ; Transfer result to Y register

LDA #6 ; Load constant 6 into accumulator
CLC ; Clear carry flag
ADC Y ; Add the squared length value from Y register
STA result ; Store the result in memory location 'result'

BRK ; End program

;Subroutine to square the input value
SQUARE
TAX ; Transfer value from X register to accumulator
CLC ; Clear carry flag
ADC 0 ; Add value from zero page
STA 0 ; Store result at zero page
LDA 0 ; Load result back to accumulator
RTS ; Return from subroutine

.segment "DATA"
length .byte 3 ; Length of the cube
result .byte 0 ; Store result of surface area calculation
