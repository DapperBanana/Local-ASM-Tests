
; Program to calculate the sum of all prime numbers up to a given limit
        .org $0200

Start   LDA #2                  ; Start with the first prime number 2
        STA PrimeSum            ; Initialize the sum of prime numbers
        LDX #2                  ; Initialize loop counter
        LDA #2                  ; Initialize divisor
        
Loop    INX                      ; Increment number to check if prime
        JSR IsPrime             ; Check if the number is prime
        BEQ NotPrime            ; If not prime, continue to next number
        CLC
        ADC PrimeSum            ; Add prime number to sum
        STA PrimeSum

NotPrime
        CPX Limit               ; Check if reached the limit
        BCC Loop                ; If not, continue loop
        
Done    BRK                      ; Stop program

IsPrime LDA Divisor             ; Load divisor
        SEC
        SBC #1                  ; Subtract 1 from divisor
        BEQ Prime                ; If divisor is 1, number is prime
        STA Remainder
        LDA #0                  ; Initialize remainder
        LDX #0                  ; Initialize loop counter
        
DivLoop LDA Remainder           ; Load remainder
        CMP #0                  ; Check if remainder is 0
        BEQ NotPrime            ; If remainder is 0, number is not prime
        CLC
        ADC Divisor             ; Add divisor to remainder
        CMP X                   ; Check if exceeded divisor
        BCC DivLoop             ; If not exceeded, continue loop
        INX                      ; Increment loop counter
        CPX Divisor              ; Check if reached divisor
        BCC DivLoop             ; If not reached, continue loop
        RTS

Prime   LDA #1                  ; Return 1 for prime number
        RTS

PrimeSum .byte 0                ; Variable to store sum of prime numbers
Limit   .byte 10                ; Upper limit for prime number calculation
Divisor .byte 0                 ; Divisor for division
Remainder .byte 0               ; Remainder for division
