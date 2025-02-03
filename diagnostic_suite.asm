
.INCLUDE "6502.h" ; Include 6502 header file

.DEF PRIME_SUM = $f0 ; Define memory location for storing the sum of prime numbers
.DEF PRIME_LIMIT = $f1 ; Define memory location for storing the limit

        LDA #$00 ; Initialize sum to 0
        STA PRIME_SUM

        LDA #10 ; Set the limit to calculate prime numbers up to 10
        STA PRIME_LIMIT

LOOP:
        LDX #$02 ; Start checking for prime numbers from 2
CHECK_PRIME:
        CPX PRIME_LIMIT ; Check if we have reached the limit
        BEQ END_PROGRAM

        LDY #$02 ; Start divisibility check from 2
DIVISIBILITY_CHECK:
        CPY X ; Check if X is divisible by Y
        BEQ PRIME_NUMBER
        INY
        CPY X
        BNE DIVISIBILITY_CHECK

        INX
        JMP CHECK_PRIME

PRIME_NUMBER:
        CLC
        ADC X ; Add prime number to the sum
        STA PRIME_SUM

        INX
        JMP CHECK_PRIME

END_PROGRAM:
        NOP ; No operation placeholder for end of program

        .END ; End of program
