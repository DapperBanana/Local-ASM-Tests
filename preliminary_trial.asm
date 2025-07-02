
        .org $0200

check_prime:
        LDX #2          ; Initialize divisor to 2
        LDY #0          ; Initialize the number of factors found to 0
loop:
        CPX number     ; Compare divisor to the input number
        BEQ prime      ; If divisor equals number, it is prime
        CPY #1          ; Check if more than 1 factor has been found
        BNE not_prime   ; If more than 1 factor is found, number is not prime

        LDA number     ; Load the number to check
        LSR             ; Shift right to divide by 2
        BMI not_prime   ; If number is negative or 0, not prime

        CMP #$2         ; Compare number with 2
        BEQ prime      ; If number equals 2, it is prime

        CPX #$2         ; Compare divisor with 2
        BEQ prime      ; If divisor equals 2, number is prime

        CPX #$3         ; Check if divisor is 3
        BEQ prime      ; If divisor is 3, number is prime

        CPX number     ; Check if divisor equals number
        BEQ prime      ; If divisor equals number, number is prime

        CPY #0          ; Check if any factors have been found
        BNE not_prime   ; If no factors are found, number is not prime

        CPY #1          ; Check if one factor is found
        BEQ prime      ; If one factor is found, number is prime

        INY             ; Increment factor count
        DEX             ; Decrement divisor
        BMI loop        ; Branch back to loop if divisor is negative

prime:
        LDA #$01        ; Load with 01 value for true
        RTS

not_prime:
        LDA #$00        ; Load with 00 value for false
        RTS

number:
        .byte 23        ; Input number to check for prime

        .end
