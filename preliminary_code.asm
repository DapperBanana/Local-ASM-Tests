
        .org $0200

START:  LDA #9         ; Load the number of sides of the regular nonagon into the accumulator
        STA SIDES      ; Store it in the SIDES variable
        
        LDX #SIDES     ; Load the number of sides into X register
        LDY #5         ; Load the length of one side of the nonagon into Y register
        
        LDA #0         ; Initialize the area accumulator to 0
        STA AREA
        
LOOP:   LDA AREA       ; Load the current area into the accumulator
        CLC            ; Clear the carry flag
        ADC X          ; Add the number of sides to the current area
        STA AREA       ; Store the new area
        
        DEX            ; Decrement X register to count down the sides
        BNE LOOP       ; Branch back to LOOP if X register is not zero
        
        LDA AREA       ; Load the final area value into the accumulator
        STA RESULT     
        
        ; Halt the program
        BRK          

SIDES:  .byte 0
AREA:   .byte 0
RESULT: .byte 0

        .end
