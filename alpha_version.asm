
    ; Calculate the area of a regular hexagon

    AREA_OF_HEX EQU $      ; Define address of the hexagon area variable

    ORG $8000             ; Start program at address $8000

    LDA #6                ; Load the number of sides of the hexagon
    STA SIDES             ; Store it in memory
    LDA #10               ; Load the length of a side of the hexagon
    STA LENGTH            ; Store it in memory
    JSR CALC_AREA         ; Call the subroutine to calculate the area

    JMP *                 ; End program

CALC_AREA:
    LDA SIDES             ; Load the number of sides of the hexagon
    STA SIDES_LEFT        ; Store it in memory

LOOP:
    LDA AREA_OF_HEX       ; Load the current area
    ADC LENGTH            ; Add the length of a side
    STA AREA_OF_HEX       ; Store the new area
    DEC SIDES_LEFT        ; Decrement the counter
    BNE LOOP              ; Loop until all sides are calculated

    RTS

    LENGTH EQU $10        ; Define address for hexagon side length
    SIDES EQU $20         ; Define address for number of sides
    SIDES_LEFT EQU $30    ; Define address for sides left in loop

    END
