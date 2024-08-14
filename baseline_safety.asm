
            .org $0200

start:      lda #1             ; Initialize sum to 0
            sta sum

            lda #1             ; Initialize counter to 1
            sta counter

loop:       lda counter        ; Load current number into A
            jsr is_prime       ; Check if current number is prime
            beq not_prime      ; Branch if not prime

            clc                ; Add current prime number to sum
            lda sum
            adc counter
            sta sum

not_prime:  inr counter        ; Increment counter
            cmp #11            ; Check if counter has reached end of range
            bne loop

done:       hlt

is_prime:   lda #2             ; Initialize divisor to 2
            sta divisor

div_loop:   cmp counter        ; Compare current number with divisor
            beq prime         ; Branch if divisor equals current number
            lsr divisor        ; Divide divisor by 2
            bcc div_loop      ; Branch if no remainder

            lda #0             ; Not prime, return false
            rts

prime:      lda #1             ; Prime, return true
            rts

sum:        .byte 0
divisor:    .byte 0
counter:    .byte 0

            .end
