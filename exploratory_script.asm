
.INCLUDE "6502.INC"

START LDX #5                 ; Set number of sides of the icosahedron
  LDY #70                  ; Set side length of the icosahedron

  ; Calculate the area of the icosahedron
  JSR MULT                  ; Multiply number of sides by side length
  STX TEMP                   ; Store result in temporary memory
  JSR MULT                  ; Multiply result by 5
  STA AREA                   ; Store final result in AREA variable

  ; Halt the program
  BRK

MULT LDA #$00                 ; Initialize result to zero
  CLC

LOOP1 ADC TEMP                 ; Add SIDE
  DEX                       ; Decrement X
  BNE LOOP1                 ; Loop until X is zero

  RTS

TEMP   .BYTE $00               ; Temporary memory for calculations
AREA   .BYTE $00               ; Resulting area

.END
