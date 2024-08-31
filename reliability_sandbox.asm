
LDA #7        ; Load the number of sides of the heptagon (7)
LDX #0        ; Initialize the accumulator with value 0
LDY #0        ; Initialize the temp value with value 0

LOOP:
LSR           ; Divide the number of sides by 2 by shifting right
DEY           ; Decrement the temp value
BCC SKIP      ; Skip the add if the carry flag is clear
CLC           ; Clear the carry flag
ADC #91       ; Add the angle of the heptagon (91 degrees)
STY TEMP      ; Store the temp value in memory
TYA           ; Transfer the temp value to the accumulator
BNE LOOP      ; Repeat the loop until the temp value is 0

TEMP:
DB 0          ; Declare a memory location for the temp value

AREA:
DB 0          ; Declare a memory location for the area

SKIP:
LDA TEMP      ; Load the temp value into the accumulator
ASL           ; Multiply by 2
TAX           ; Transfer the accumulator to the X register

LOOP2:
DEY           ; Decrement the temp value
BPL LOOP2     ; Repeat until the temp value is negative

TAY           ; Transfer the accumulator to the Y register
LDA #123      ; Load the length of each side of the heptagon (assume side length is 123 units)
JSR MULT       ; Call the multiply subroutine
STA AREA      ; Store the result in the area memory location

HLT:
BRK           ; Break

MULT:
CLC           ; Clear the carry flag
ADC AREA      ; Add the area to the accumulator
TAX           ; Transfer the accumulator to the X register
RTS           ; Return from subroutine
