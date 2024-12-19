
        .org $0200

start   LDA #0             ; Initialize sum
        STA sum

        LDA #2             ; Set start of range
        STA num

loop    JSR is_prime       ; Check if num is prime
        BCS not_prime      ; Branch if not prime

        CLC
        LDA sum            ; Add prime number to sum
        ADC num
        STA sum

not_prime
        INX                ; Increment num
        CPX #10           ; Set end of range
        BNE loop

done    BRK                ; Break and end program

is_prime
        LDY #2             ; Initialize divisor

check   CPY num            ; Check if divisor exceeds num
        BCS prime          ; Branch if prime

        LDA num
        CMP #$00           ; Check if num is divisible by divisor
        BEQ not_prime2

        LSR                ; Shift right bit
        BCC is_prime2      ; Branch if not divisible

not_prime2
        RTS

is_prime2
        INY                ; Increment divisor
        JMP check

prime   SEC
        RTS

sum     .byte 0
num     .byte 0

        .end
