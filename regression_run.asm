
START    LDA #0            ; Initialize variables
         STA COUNT
         STA DIVISOR
         LDA #2            ; Set initial divisor to 2
         STA PRIME
         LDX #NUMBER       ; Load number into X register
         
LOOP     CPX #1            ; Check if number is 1
         BEQ PRINT        ; If number is 1, print prime factors
         
         LDA PRIME         ; Load current prime into accumulator
         JSR DIVISIBLE     ; Check if the number is divisible by the current prime
         BEQ NOT_DIVISIBLE ; If not divisible, try with next prime
         
         LDA PRIME         ; If divisible, print prime factor
         JSR PRINT_FACTOR
         
         LDA #0
         STA NUMBER        ; Divide the number by the prime factor
         LDX #NUMBER
         JMP LOOP          ; Repeat until number is 1
         
NOT_DIVISIBLE
         INC PRIME         ; Try with next prime number
         JMP LOOP
         
PRINT    RTS

DIVISIBLE CMP DIVISOR
         BEQ PRIME_DIVISIBLE
         INC DIVISOR
         JMP DIVISIBLE

PRIME_DIVISIBLE
         LDA #1
         RTS

PRINT_FACTOR
         ; Code to print the prime factor
         RTS

NUMBER   .BYTE 24          ; Number to find prime factors of
COUNT    .BYTE 0           ; Counter for prime factors found
DIVISOR  .BYTE 0           ; Current divisor being tested
PRIME    .BYTE 2           ; Current prime number being tested
