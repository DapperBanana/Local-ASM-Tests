
PRIME_SUM    .org $1000  ; Start address of the program

            lda #0       ; Initialize sum of prime numbers to 0
            sta SUM

            ldx #2       ; Initialize number to check for primality to 2
LOOP        lda CHECK   ; Load the current number to check
            jsr IS_PRIME ; Check if the number is prime
            beq NOT_PRIME ; Branch if not prime
            clc          ; Add prime number to sum
            adc LOOP
            sta SUM
NOT_PRIME   inx          ; Increment the number to check
            cpx LIMIT    ; Check if reached the limit
            bcc LOOP     ; Branch if not reached the limit

            rts          ; Return

IS_PRIME    cmp #2       ; Compare with the number 2
            beq PRIME     ; Branch if it is 2
            beq NOT_PRIME ; Not prime if 0 or 1
            cpx #2       ; Compare with the number 2
            beq PRIME     ; Branch if it is 2
            lda #2       ; Initialize divisor to 2
            clc
DIVIDE      sbc DIVISOR ; Reduce the current number by divisor
            cmp #0       ; Check if reached 0
            bcc PRIME    ; Branch if reached 0 (prime number)
            inx          ; Increment divisor
            bne DIVIDE   ; Loop until divisor equals the current number
            lda #0       ; Set current number to 0 (not prime)
            rts

PRIME       lda #1       ; Set current number to 1 (prime)
            rts

SUM         .byte 0
CHECK       .byte 0
LIMIT       .byte 10
DIVISOR     .byte 0

            .end
