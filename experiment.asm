
        .org    $0600

start   lda     #10         ; Start of range
        sta     range_start
        lda     #50         ; End of range
        sta     range_end

        ldx     #0          ; Initialize prime count

check   lda     range_start ; Load current number to check
        jsr     is_prime    ; Check if the number is prime
        bne     not_prime   ; If not prime, skip incrementing prime count
        inx                 ; Increment prime count

not_prime
        inc     range_start ; Move to next number in range
        cmp     range_end   ; Compare current number to end of range
        bcc     check       ; Repeat loop if still within range

done    lda     prime_count ; Load prime count into accumulator
        ; Output prime count using your preferred method

        rts                 ; Return from subroutine

is_prime
        ldx     #2          ; Start checking for factors at 2

check_factors
        cpx     #256        ; Check all numbers less than 256
        beq     prime       ; If no factors found, number is prime
        cpx     range_start ; Check if current factor exceeds half the number
        bcs     prime       ; If current factor exceeds half the number, number is prime
        lda     range_start ; Load current number
        clc
        adc     #1          ; Increment current factor
        sta     temp_factor
        lda     temp_factor ; Load current factor
        cmp     #2          ; Check if current factor is 2
        beq     check_factors ; Skip checking factor of 2
        lda     range_start ; Load current number
        div     temp_factor ; Divide current number by current factor
        bne     check_factors ; If remainder is not 0, continue checking factors
        rts                 ; Return with zero in accumulator if not prime

prime   lda     #1          ; Load 1 (prime) into accumulator
        rts                 ; Return with 1 in accumulator

range_start .byte   0
range_end   .byte   0
prime_count .byte   0
temp_factor .byte   0

        .end
