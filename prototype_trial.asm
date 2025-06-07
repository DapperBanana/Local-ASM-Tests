
; Vampire number checking program in 6502 Assembly

START LDX #$00         ; Initialize index register X to 0
      LDY #$00         ; Initialize index register Y to 0
      LDA #$80         ; Load the number to be checked into the accumulator

LOOP  CMP #$00         ; Check if the number is zero
      BEQ DONE        ; If number is zero, exit loop

      ROL             ; Rotate the bits left to separate the digits
      PHA             ; Push the digit onto the stack
      INY             ; Increment the index register Y
      BNE LOOP        ; Loop back to check next digit

CHECK LDX #$01         ; Initialize index register X to 1
      LDY #$00         ; Initialize index register Y to 0
      CLC             ; Clear the carry flag

NEXT  LDA $0100,X      ; Load the first digit of the number into the accumulator
      BEQ DONE        ; If end of number is reached, exit loop

      CMP $0100,Y      ; Compare the first digit with other digits
      BNE NOT_VAMPIRE  ; If digits don't match, jump to NOT_VAMPIRE

      INX             ; Increment the index register X
      INY             ; Increment the index register Y
      BNE NEXT        ; Loop back to check next digit

      BCS NOT_VAMPIRE  ; If all digits match, but too many, jump to NOT_VAMPIRE

      SEC             ; Set the carry flag

      RTS             ; Return from subroutine

NOT_VAMPIRE
      CLC             ; Clear the carry flag

DONE  RTS             ; End of program

      .ORG $C000      ; Start program at memory address $C000
      .DA 12345       ; Number to be checked

      .ORG $FFFA      ; Interrupt vector
      .DW START       ; Start of program
