
        lda #0         ; Initialize sum to 0
        sta sum

        lda #2         ; Start checking numbers from 2
loop:
        jsr is_prime   ; Check if the number is prime
        bne not_prime  ; Branch if not prime
        clc
        lda sum        ; Add prime number to sum
        adc a
        sta sum
not_prime:
        inr a          ; Increment number
        cmp #100       ; Check if reached limit
        bcc loop       ; Loop back if not

        rts            ; Return from subroutine

is_prime:
        lda #2         ; Start checking for divisibility from 2
check_divisible:
        cmp a          ; Compare number
        beq prime      ; Branch if number is a prime number
        clc
        lda a
        ldx #2         ; Start checking division from 2
divisible_loop:
        dex
        beq not_prime  ; Branch if not prime
        cpx #2
        bne check_divisible
prime:
        rts            ; Return from subroutine

sum:    .byte 0        ; Memory location to store sum
a:      .byte 0        ; Memory location to store current number
