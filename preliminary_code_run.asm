
START    LDA #10    ; load upper limit into accumulator
         STA UPPER_LIMIT
         LDA #1     ; load lower limit into accumulator
         STA LOWER_LIMIT
         LDX #0     ; initialize counter for prime numbers

LOOP     INY         ; increment Y register (number being checked)
         CPY UPPER_LIMIT   ; check if reached upper limit
         BCS END_LOOP  ; branch if greater than upper limit

         JSR IS_PRIME    ; check if number is prime
         BNE LOOP    ; if not prime, repeat the loop

         INX         ; increment counter for prime numbers
         JMP LOOP    ; repeat the loop

END_LOOP LDA X    ; load counter into accumulator
         BRK    ; end program

IS_PRIME LDA #1    ; load divisor into accumulator
         STA DIVISOR

CHECK_DIVISOR    DEX    ; decrement divisor
         CPX #1    ; check if reached 1
         BEQ IS_PRIME_TRUE   ; if reached 1, number is prime

         TYA    ; load number being checked into Y register
         CPY DIVISOR    ; check if divisible by current divisor
         BEQ IS_NOT_PRIME   ; if divisible, number is not prime
         BNE CHECK_DIVISOR   ; if not divisible, check next divisor

IS_PRIME_TRUE    LDA #1    ; set zero flag to indicate number is prime
         RTS

IS_NOT_PRIME    LDA #0    ; set zero flag to indicate number is not prime
         RTS

UPPER_LIMIT   .BYTE 0
LOWER_LIMIT   .BYTE 0
DIVISOR       .BYTE 0
