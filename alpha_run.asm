
 ; 6502 Assembly program to calculate the sum of all prime numbers in a given range

 .org $0200

start:
    ldx #1         ; Initialize X to 1
    ldy #0         ; Initialize Y to 0 (sum of primes)
    lda #50        ; Set upper limit of range
loop:
    jsr check_prime      ; Check if number in X register is prime
    bcc not_prime        ; Branch if not prime
    clc
    lda y
    adc x                ; Add prime number to sum
    sta y
not_prime:
    inx
    cmp a               ; Compare with upper limit
    bcc loop            ; Continue loop if within range
    rts

check_prime:
    ldy #2             ; Initialize Y to 2
    cpx #2             ; If X is 2 it's prime
    beq prime
loop1:
    iny                ; Increment divisor
    cpy x              ; Compare with number
    bcs prime           ; If bigger the number is prime
    cpx #4             ; If number is smaller than 4 it's prime
    bne check_divisor  ; Otherwise check if it's divisible by current divisor
    rts                ; Return if not prime
check_divisor:
    sec
    ldy #0             ; Set remainder to 0
    clc
    div y              ; Divide by divisor
    bne loop1          ; Continue loop if not divisible
    clc
    rts                ; Return if not prime
prime:
    clc
    rts                ; Return if prime

 .end
