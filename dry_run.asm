
START  LDA #8         ; Load the number of sides of the octagon
       STA SIDES

       LDA #50        ; Load the length of each side (assume 50 units)
       STA SIDE_LENGHT

       LDX #0         ; Initialize index for loop
       LDA #0         ; Initialize area accumulator
LOOP   CMP SIDES      ; Compare loop counter with number of sides
       BEQ END        ; Branch to the end of the program if all sides processed

       CLC            ; Clear carry flag
       LDA SIDE_LENGHT; Load the length of each side
       ADC AREA       ; Add to the total area
       STA AREA

       INX            ; Increment loop counter
       JMP LOOP       ; Jump back to the beginning of the loop

END    HLT            ; Halt the program

AREA   .BYTE 0        ; Variable to store the total area
SIDES  .BYTE 0        ; Variable to store the number of sides
SIDE_LENGHT .BYTE 0   ; Variable to store the length of each side

       .ORG $FFFC     ; Specify the reset vector address
       .WORD START    ; Set the reset vector to the start of the program
