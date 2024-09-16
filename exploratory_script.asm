
START:
    LDX #2   ; Initialize X register to 2 (starting point for prime numbers)
    LDY #0   ; Initialize Y register to store the sum of prime numbers
LOOP:
    JSR IS_PRIME   ; Call subroutine to check if X is a prime number
    BEQ NOT_PRIME   ; If X is not a prime number, skip adding it to the sum
    CLC
    LDA Y
    ADC X   ; Add X to the sum stored in Y register
    STA Y
NOT_PRIME:
    INX   ; Increment X to check the next number
    CPX #LIMIT   ; Check if the limit has been reached
    BCC LOOP   ; If not, continue looping
DONE:
    ; The sum of prime numbers up to the limit is stored in the Y register
    JMP $   ; End program

IS_PRIME:
    STX DIVISOR   ; Save the current number in the divisor register
    LDX #2   ; Set divisor to 2
DIV_LOOP:
    CPX #DIVISOR   ; Check if X is equal to divisor
    BEQ IS_PRIME   ; If X is equal to divisor, it is a prime number
    SEC
    SBC DIVISOR   ; Subtract divisor from the current number
    BCS DIV_LOOP   ; If the result is still positive, continue looping
    RTS

LIMIT = $FF   ; Change this value to set the limit for prime numbers calculation
DIVISOR = $FE   ; Temporary register to store divisor

    .org $FFFC   ; Program entry point
    .word START
