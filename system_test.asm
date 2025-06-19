
; Program to check if a number is prime
;
; Input:  Number to check in accumulator (A)
; Output: Carry flag set if number is prime, cleared if not

        LDA #2          ; Initialize divisor to 2
        STA divisor

        LDA #0          ; Initialize count to 0
        STA count

check:  CMP #0          ; Compare number with 0
        BEQ not_prime   ; If number is 0, it is not prime
        CMP #1          ; Compare number with 1
        BEQ not_prime   ; If number is 1, it is not prime

next_divisor:
        LDA count       ; Increment count
        CLC
        ADC #1
        STA count

        LDA count       ; Compare count with number
        CMP A
        BEQ prime       ; If count == number, number is prime

        LDA count
        STA dividend

        LDA divisor     ; Divide number by divisor
        CLC
        ADC divisor
        STA divisor
        LDA dividend
        SEC
        SBC divisor
        BCC next_divisor ; If remainder != 0, check next divisor

not_prime:
        SEC             ; Clear carry flag to indicate not prime
        RTS

prime:
        CLC             ; Set carry flag to indicate prime
        RTS
