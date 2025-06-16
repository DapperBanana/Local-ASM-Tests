
        .org $0200

start   lda #NumberToCheck
        sta NumberToCheck
        lda #2
        sta Divisor
        lda #0
        sta IsPrime

check   lda Divisor
        cmp NumberToCheck
        beq done
        
        lda NumberToCheck
        jsr divide
        lda Remainder
        cmp #0
        beq notPrime
        
        lda #1
        sta IsPrime

notPrime
        lda Divisor
        clc
        adc #1
        sta Divisor
        jmp check

done    lda IsPrime
        beq prime
        lda #NumberToCheck
        jsr displayNotPrime
        jmp end

prime   lda #NumberToCheck
        jsr displayPrime

end     rts

divide  sec
        lda NumberToCheck
        sbc Divisor
        bpl divide
        sta Remainder
        rts

NumberToCheck   .byte 13
Divisor         .byte 0
IsPrime         .byte 0
Remainder       .byte 0

displayPrime    ; code to display number is prime
displayNotPrime ; code to display number is not prime
