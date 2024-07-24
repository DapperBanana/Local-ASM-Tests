
        .org $0200

start:  LDX #0               ; Initialize X register as sum of prime numbers
        LDY #2               ; Start checking for prime numbers from 2

loop:   JSR isPrime          ; Check if Y is a prime number
        BCC notPrime         ; If not prime, skip adding to sum
        CLC
        ADC Y                ; Add prime number to sum
notPrime:
        INY                  ; Move to next number
        CPY #10              ; Check if we have reached end of range
        BCC loop             ; If not, continue checking

done:   BRK                   ; Exit program

isPrime:
        LDA #2                ; Initialize divisor
checkDivisor:
        CPY #2                ; Check if Y is equal to 2
        BEQ prime            ; If yes, it is prime
        CPY #3                ; Check if Y is equal to 3
        BEQ prime            ; If yes, it is prime
        CPY #4                ; Check if Y is equal to 4
        BEQ notPrime         ; If yes, it is not prime
        CPY #5                ; Check if Y is equal to 5
        BEQ prime            ; If yes, it is prime
        CPY #6                ; Check if Y is equal to 6
        BEQ notPrime         ; If yes, it is not prime
        CPY #7                ; Check if Y is equal to 7
        BEQ prime            ; If yes, it is prime
        CPY #8                ; Check if Y is equal to 8
        BEQ notPrime         ; If yes, it is not prime
        CPY #9                ; Check if Y is equal to 9
        BEQ notPrime         ; If yes, it is not prime

        LDA Y                 ; Load Y into the accumulator
        SEC
        SBC #2                ; Subtract divisor
        BPL checkDivisor      ; If result is positive, continue checking

prime:  SEC
        SBC #0                ; Clear carry flag if number is prime
        RTS

notPrime:
        CLC
        RTS

        .end start
