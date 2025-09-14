
        .org $1000

start   lda #0            ; initialize counter to 0
        sta count

        ldx #2            ; initialize number to check at 2
loop    lda #0            ; initialize isPrime flag to 0
        sta isPrime

        cpx #2            ; check if number is 2
        beq check        ; go to check if number is 2

        cpx #1            ; check if number is 1
        beq notPrime      ; go to notPrime if number is 1

        cpx #0            ; check if number is 0
        beq notPrime      ; go to notPrime if number is 0

        ldy #2            ; initialize divisor at 2
check   cpy x             ; check if divisor is equal to number
        beq prime        ; go to prime if divisor is equal to number

        dex               ; decrement number
        cpx #1            ; check if number is 1
        bne loop          ; go back to loop if number is not 1

notPrime
        inc x             ; increment number
        jmp loop

prime   lda isPrime      ; load isPrime flag
        cmp #0            ; check if isPrime flag is 0
        bne notPrime      ; go to notPrime if isPrime flag is not 0

        lda count         ; load counter
        clc               ; clear carry flag
        adc #1            ; increment counter
        sta count         ; store updated counter

        inc x             ; increment number
        jmp loop

        .dsb 1            ; reserve 1 byte for count
        isPrime .dsb 1    ; reserve 1 byte for isPrime flag

        .end
