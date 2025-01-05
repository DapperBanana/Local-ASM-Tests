
.prime_sum
    LDX #2              ; initialize X register to 2 (first prime number)
    LDY #2              ; initialize Y register to 2 (divider)
    LDA #0              ; initialize accumulator to 0 (sum of prime numbers)
loop
    INX                 ; increment X register (next number to check)
    CPX limit           ; compare X to limit
    BCS endloop         ; if X >= limit, exit loop
    
    LDY #2              ; reset Y register to 2
check_prime
    CPY X               ; compare Y to X
    BEQ prime           ; if Y = X, X is a prime number
    CPY #1              ; check if Y is 1
    BEQ not_prime       ; if Y = 1, not a prime number
    CPX #2              ; check if X is 2
    BEQ prime           ; if X = 2, X is a prime number
    CPX #3              ; check if X is 3
    BEQ prime           ; if X = 3, X is a prime number
    CPX #4              ; check if X is 4
    BEQ not_prime       ; if X = 4, not a prime number

    CPY #0              ; check if Y is 0
    BEQ not_divisible   ; if Y = 0, not divisible
    CPX #2              ; check if X is 2
    BEQ divisible       ; if X = 2, divisible
    CPY #1              ; check if Y is 1
    BEQ not_divisible   ; if Y = 1, not divisible

    CPY #2              ; check if Y is 2
    BEQ divisible       ; if Y = 2, divisible
    CPX #3              ; check if X is 3
    BEQ divisible       ; if X = 3, divisible
    CPY X               ; check if Y = X
    BEQ prime           ; if Y = X, X is a prime number
    INY                 ; increment Y register
    JMP check_prime     ; loop back to check if X is prime

divisible
    JMP not_prime       ; jump to not_prime if X is divisible

not_divisible
    CPY #256            ; check if Y is 256
    BEQ prime           ; if Y = 256, X is a prime number
    INY                 ; increment Y register
    JMP check_prime     ; loop back to check if X is prime

prime
    CLC                 ; clear carry
    ADC X               ; add X to accumulator
    JMP loop            ; continue looping

not_prime
    JMP loop            ; continue looping

endloop
    RTS                 ; return from subroutine

.limit
    .byte 10            ; define limit as 10
