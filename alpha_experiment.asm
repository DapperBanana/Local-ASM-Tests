
START LDX #$00      ; initialize X to 0
      LDY $00       ; load the given number into Y
LOOP  INY           ; increment Y
      CPY $00       ; compare with the given number
      BEQ LOOP      ; if Y is equal to the given number, continue looping
CHECK LDA #$02      ; start checking for factors from 2
      JSR DIVIDE    ; call subroutine to check for factors
      BCS CHECK     ; continue checking for factors if non-zero remainder
      LDA #$00      ; if remainder is zero, Y is not prime
      INX           ; increment X to indicate Y is not prime
      CPX #$02      ; check if X is 2 (the only even prime number)
      BEQ LOOP      ; continue looping if Y is not prime
      LDA Y         ; load Y
      STA $00       ; store the smallest prime number greater than the given number
      RTS           ; return from subroutine

DIVIDE
      SBC $93       ; subtract the divisor from A
      BCC DIVIDE    ; repeat until A is less than the divisor
      RTS           ; return from subroutine

      .org $2000     ; program starting address
      JMP START      ; jump to start of program
