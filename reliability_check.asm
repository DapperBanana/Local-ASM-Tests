
.ORG $0200   ; Start memory address

LDA #$08     ; Load the number of sides of the octagon
STA sides

LDA #$20     ; Load the length of each side of the octagon
STA sideLength

LDA #$01     ; Initialize area accumulator
STA area

LDA sideLength
CLC          ; Clear carry flag
ADC sideLength ; Add side length to itself
TAX          ; Transfer result to X register

loop:
    DEX      ; Decrement X register
    BNE loop ; Branch back to loop if not zero

    LDA area ; Load current value of area
    ADC sideLength ; Add side length to area
    STA area ; Store the updated area value

    DEC sides ; Decrement the number of remaining sides
    BNE loop ; Branch back to loop if there are more sides left

    LDA area ; Final result is in the area accumulator
    ; Process the result or store it to memory

DONE:
    NOP      ; No operation - program end

.ORG $FFFA   ; Set interrupt vector to program start address
DW $0200
