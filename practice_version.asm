
; Prime number counter program

    processor 6502
    org $1000

start:
    lda #0      ; Initialize counter for prime numbers
    sta prime_count
    
    lda #0      ; Initialize number to test
    sta num
    
loop:
    lda num     ; Load current number to test
    jsr is_prime ; Check if number is prime
    bne not_prime ; Branch if not prime
    
    inc prime_count ; Increment prime number counter
    
not_prime:
    inc num     ; Increment number to test
    cmp #$64    ; Compare to 100
    bcc loop    ; Loop if less than 100

done:
    ; Output the result
    lda prime_count
    ; Output the count

    rts

is_prime:
    cmp #2      ; Check for number less than 2
    beq not_prime
    
    cpx #2      ; Check for number equal to 2
    beq prime
    
    cpx #3      ; Check for number equal to 3
    beq prime
    
    lda #2
loop1:
    cmp num     ; Compare to current number
    beq prime   ; Branch if equal
    
    inc a       ; Increment divisor
    cmp num     ; Compare to current number
    bcc loop1   ; Loop if less than current number
    
    rts

prime:
    lda #1
    rts
    
prime_count:
    .byte 0
num:
    .byte 0

    end start
