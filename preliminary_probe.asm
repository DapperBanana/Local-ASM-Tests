
        .org $0200

        LDA #5                  ; Load the number of sides of the pentagon
        STA sides

        LDA #10                 ; Load the length of each side of the pentagon
        STA sideLength

        JSR calculateArea       ; Call the calculateArea subroutine

        LDA area+1              ; Load the high byte of the area
        STA $FB                 ; Store it in memory at address $FB
        LDA area                ; Load the low byte of the area
        STA $FA                 ; Store it in memory at address $FA

done:   BRK                     ; End of program

calculateArea:
        LDX #0                  ; Initialize index register X to 0
        LDA sideLength          ; Load the length of each side
        CLC
nextSide:
        ADC area,X              ; Add the area of the current side to the total area
        STA area,X              ; Store the result
        INX                     ; Increment X
        CPX sides               ; Compare X to the number of sides
        BNE nextSide            ; Loop until all sides are processed
        RTS                     ; Return from subroutine

sides:  .byte 0                ; Variable to store the number of sides
sideLength: .byte 0            ; Variable to store the length of each side
area:   .byte 0, 0             ; Variable to store the area of the pentagon
