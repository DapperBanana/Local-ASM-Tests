
; Calculate the sum of prime numbers in a given range

        .org $0200

start:
        ; Initialize variables
        LDA #0         ; Accumulator = 0
        STA sum        ; Store the sum of prime numbers
        LDA #2         ; Start check from number 2
        STA num        ; Store the current number
        LDA #0         ; Initialize found flag to 0
        STA found

loop:
        ; Check if the number is prime
        LDA num
        JSR is_prime

        ; If the number is prime, add it to the sum
        LDA found
        CMP #1          ; Check if found flag is set
        BEQ add_to_sum  ; If found flag is set, add to sum

        ; Increment current number
        LDA num
        CLC
        ADC #1
        STA num

        ; Check if we have reached the end of the range (e.g. 100)
        LDA num
        CMP #100
        BNE loop         ; If not, continue looping
        JMP end

add_to_sum:
        LDA sum
        CLC
        ADC num
        STA sum

        ; Increment current number
        LDA num
        CLC
        ADC #1
        STA num

        ; Check if we have reached the end of the range (e.g. 100)
        LDA num
        CMP #100
        BNE loop         ; If not, continue looping
        JMP end

is_prime:
        ; Check if number is divisible by any number between 2 and itself
        LDA #2          ; Start checking from 2
        STA divisor

check_divisor:
        LDA num
        SEC
        SBC divisor
        BEQ is_prime_end

        LDA num
        SEC
        SBC divisor
        CMP #0          ; Check if remainder is 0
        BEQ not_prime

        ; Increment divisor
        LDA divisor
        CLC
        ADC #1
        STA divisor
        JMP check_divisor

not_prime:
        LDA #0          ; Set found flag to indicate not prime
        STA found
        RTS

is_prime_end:
        LDA #1          ; Set found flag to indicate prime
        STA found
        RTS

end:
        BRK

sum:
        .byte 0
num:
        .byte 0
found:
        .byte 0
divisor:
        .byte 0

        .end
