
      .org $1000

START LDX #0          ; Initialize X register to zero
      LDA NUMBER      ; Load the number into the Accumulator
      AND #$01        ; Mask the least significant bit
      BEQ IS_EVEN     ; Branch if even
IS_ODD
      ; Number is odd
      ; Add your code here to handle odd numbers
      RTS             ; Return from subroutine
IS_EVEN
      ; Number is even
      ; Add your code here to handle even numbers
      RTS             ; Return from subroutine

NUMBER .byte 42        ; Change this value to test different numbers

      .end
