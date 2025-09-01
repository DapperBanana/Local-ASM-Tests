
START    LDX #0        ; Initialize X register to hold the sum
         LDA #2        ; Start checking from number 2
LOOP     JSR ISPRIME  ; Call subroutine to check if number is prime
         BCC NOT_PRIME ; Branch if not prime
         CLC          ; Clear carry flag
         ADC A         ; Add prime number to sum
NOT_PRIME INX          ; Increment X register
         INX          ; Skip over next number
         INX
         LDA X        ; Load current number into A
         CMP #10      ; Check if we have reached the limit
         BCC LOOP     ; Loop back if not reached
         RTS          ; Return from subroutine

ISPRIME  STA TEMP      ; Store the number to be checked
         LDA #2        ; Start checking divisors from 2
         CLC          ; Clear carry flag
CHECK    SEC          ; Set carry flag
         SBC A         ; Subtract divisor from number
         BCC NOT_DIVISIBLE ; Branch if not divisible
         RTS          ; Return if not prime
NOT_DIVISIBLE LDA TEMP  ; Reload original number
         CMP #1        ; Check if we have reached 1 (the number is prime)
         BCC IS_PRIME ; Branch if prime
         DEC A         ; Decrement divisor
         JMP CHECK     ; Check next divisor
IS_PRIME LDA #1        ; Set carry flag to indicate number is prime
         RTS          ; Return from subroutine

TEMP     .BYTE 0
