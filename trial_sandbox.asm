
START    LDX #1         ; Initialize X register to start range
         LDY #0         ; Initialize Y register to count prime numbers

LOOP     INX            ; Increment X register to check next number
         CPX #50        ; Check if end of range
         BEQ DONE       ; Exit loop if end of range

         JSR ISPRIME    ; Call subroutine to check if number in X register is prime
         BNE NOTPRIME   ; Branch to NOTPRIME if number is not prime

         INY            ; Increment Y register to count prime number
NOTPRIME JMP LOOP       ; Continue looping

DONE     BRK            ; Exit program

ISPRIME  LDY #2         ; Start with divisor of 2
         LDA #$00       ; Initialize A register
         STA $01        ; Initialize remainder to 0

DIVLOOP  CPX $01        ; Compare X register with number being checked
         BEQ ISPRIMEYES ; Branch to ISPRIMEYES if no remainder
         LDA $01        ; Load remainder from memory
         CLC            ; Clear carry for division
         SBC $01        ; Subtract divisor from remainder
         STA $01        ; Store new remainder
         BCS DIVLOOP    ; Branch if no borrow to continue division

ISPRIMEYES
         CMP #$00       ; Check if remainder is 0
         BEQ PRIME      ; Branch to PRIME if prime
         SEC            ; Set carry if not prime
         RTS            ; Return from subroutine

PRIME    SBC $01        ; Subtract divisor to undo last division
         CLC            ; Clear carry for division
         RTS            ; Return from subroutine
