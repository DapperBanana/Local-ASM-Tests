
    .org $0200

Main:
    LDA #0           ; Initialize accumulator to 0
    STA Area         ; Store the area of the polygon
    LDA SideLength   ; Load the side length of the polygon
    STA Temp         ; Store the side length in a temporary register

CalcArea:
    LDX NumSides     ; Load the number of sides of the polygon
    CPX #0           ; Check if X is 0
    BEQ Done         ; If X is 0, we are done
    LDA Temp         ; Load the side length from the temporary register
    STA Temp2        ; Store side length in another temporary register
    CLC
    ADC Area         ; Add the current area to the accumulator
    STA Area         ; Store the new area
    LDA Temp         ; Load the side length from the temporary register
    ADC Area         ; Add current area to the accumulator
    STA Area         ; Store the new area
    DEX              ; Decrement X
    JMP CalcArea     ; Repeat until X is 0

Done:
    RTS              ; Return from subroutine

SideLength:
    .byte 5          ; Side length of the polygon

NumSides:
    .byte 6          ; Number of sides of the polygon

Area:
    .word 0          ; Area of the polygon

Temp:
    .byte 0          ; Temporary register for side length

Temp2:
    .byte 0          ; Temporary register for side length
