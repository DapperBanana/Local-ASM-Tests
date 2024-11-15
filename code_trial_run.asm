
        .org $1000
start   lda #$00        ; Initialize sum to 0
        sta $03
        lda #$02        ; Start checking numbers from 2
        sta $04
loop    jsr is_prime   ; Check if the number is prime
        bcc not_prime   ; Branch if it is not prime
        lda $04         ; Add prime number to sum
        clc
        adc $03
        sta $03
not_prime
        lda $04         ; Increment number
        clc
        adc #$01
        sta $04
        lda $04
        cmp $01         ; Compare number to limit
        bcc loop        ; Loop until limit is reached
        
done    rts

is_prime
        lda #$02        ; Check for divisibility from 2
        cmp $04
        beq prime
loop2
        lsr             ; Divide by 2
        bcs not_prime2  ; If carry is set, number is not prime
        dec             ; Decrement divisor
        bne loop2       ; Loop until divisor
prime   sec
        rts
not_prime2
        clc
        rts

        .org $2000
        .byte $00 $10 ; Initial sum
        .byte $20 $00 ; Current number
        .byte $50 $00 ; Limit
