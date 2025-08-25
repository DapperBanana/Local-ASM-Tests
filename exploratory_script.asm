
        .ORIG $0200

NUM     .DEF  $00    ; Number to check for primality
DIVISOR .DEF  $01    ; Division counter
IS_PRIME .DEF  $02    ; Flag indicating if NUM is prime

        LDX #2         ; Set divisor to 2
        LDY #0         ; Initialize IS_PRIME flag to false (not prime)

LOOP    CPX NUM       ; Compare X register with NUM
        BEQ PRIME     ; If X equals NUM, it is prime
        CPX #256      ; Check if X is larger than 256
        BEQ NOT_PRIME ; If X is 256, NUM is prime
        JSR DIVIDE    ; Check if NUM is divisible by X
        INX           ; Increment divisor
        BNE LOOP      ; Loop back to check next divisor

PRIME   LDA #1         ; Set IS_PRIME flag to true (prime)
        STY IS_PRIME
        BRA END

NOT_PRIME
        LDA #0         ; Set IS_PRIME flag to false (not prime)
        STY IS_PRIME

END     BRK

DIVIDE  SEC            ; Set carry flag for division
        LDA NUM        ; Load the number to divide into A
        SBC #0         ; Subtract 0 to clear carry
        LSR            ; Shift right to divide by the divisor
        CMP NUM        ; Compare result with original number
        BNE NOT_DIVISOR ; If quotient is not equal to NUM, not a divisor
        RTS

NOT_DIVISOR
        CLC            ; Clear carry flag for next iteration
        RTS

        .END
