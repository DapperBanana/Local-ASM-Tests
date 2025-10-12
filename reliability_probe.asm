
        .org $0200

START:  LDX #2        ; initialize counter to start at 2
        LDY #2        ; initialize divisor to start at 2
        LDZ #0        ; initialize prime counter to zero

LOOP:   CPX #30       ; check if we have reached the end of the range
        BCS EXIT      ; if yes, exit the loop

        JSR IS_PRIME  ; check if the current number is prime
        BEQ NOT_PRIME ; if not prime, skip incrementing prime counter

        INZ           ; increment prime counter

NOT_PRIME:
        INX           ; increment counter
        JMP LOOP      ; continue the loop

EXIT:   BRK           ; exit program

IS_PRIME:
        CPY #2        ; check if divisor is 2
        BEQ PRIME     ; if yes, the number is prime

        CPY X         ; check if divisor equals counter
        BEQ PRIME     ; if yes, the number is prime

        CPY X         ; check if number is divisible by current divisor
        BEQ NOT_PRIME ; if yes, the number is not prime

        INY           ; increment divisor
        JMP IS_PRIME  ; continue checking

PRIME:  LDA #1        ; set zero flag to indicate prime number
        RTS           ; return from subroutine
