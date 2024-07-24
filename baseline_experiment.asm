
START LDX #0            ; Initialize sum to 0
      LDA #10           ; Load the constant 10 into A register for multiplication
      STA TEMP          ; Store the constant in TEMP location

LOOP  LDA VALUE,X       ; Load the input value into A register
      ADC TEMP         ; Add the constant to the input value
      STA VALUE,X      ; Store the updated value back in memory
      INX              ; Increment X for the next iteration
      CPX #4           ; Check if X has reached the end of the array
      BNE LOOP         ; If not, go back to LOOP

      LDA VALUE        ; Load the final sum value into A register
      STA RESULT       ; Store the result in RESULT location

DONE  BRK               ; End of program

VALUE .byte 4, 8, 12, 16 ; Input values
TEMP  .byte 0            ; Constant value for multiplication
RESULT .byte 0           ; Output value
