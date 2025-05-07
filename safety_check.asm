
        .org    $0200
start:
        ldx     #2              ; Set X to starting number 2
        lda     #0              ; Clear accumulator for sum
loop:
        jsr     is_prime        ; Check if number in X is prime
        bcc     not_prime       ; If not prime, skip adding to sum
        clc                     ; Clear carry flag
        lda     result          ; Add prime number to sum
        adc     $00             ; Add carry (0)
        sta     result          ; Store new sum
not_prime:
        inx                     ; Increment X
        cpx     #100            ; Check if end of range
        bcc     loop            ; If not at end of range, loop
done:
        rts

is_prime:
        ldy     #2              ; Set Y to starting number 2
        cpx     #2              ; Check for special case of number 2
        beq     prime           ; If number is 2, return as prime
check_divisor:
        iny                     ; Increment Y
        cpy     x               ; Check if Y is equal to X
        beq     prime           ; If Y equals X, number is prime
        cpx     y               ; Check if X is divisible by Y
        lsr     a               ; Divide accumulator by 2
        bcs     done_check_divisor
        rts
done_check_divisor:
        bcc     not_prime       ; If X is divisible by Y, not prime
        bne     check_divisor   ; Otherwise, continue checking divisors
prime:
        sec                     ; Set carry flag for prime number
        rts

        .org    $FC
result: .byte   0               ; Variable to store sum

        .end
