
        .org $0200

start   lda #1            ; Initialize range start
        sta rangeStart
        lda #10           ; Initialize range end
        sta rangeEnd

        lda #0            ; Initialize sum
        sta sum

        lda rangeStart
loop    cmp rangeEnd
        beq done          ; If range end reached, end program

        jsr isPrime       ; Check if current number is prime
        bne notPrime      ; If not prime, skip adding to sum

        lda sum
        clc
        adc currentNum    ; Add prime number to sum
        sta sum

notPrime
        lda rangeStart
        clc
        adc #1            ; Increment current number
        sta rangeStart
        jmp loop

done    lda sum
        ; Output sum

        rts

isPrime lda rangeStart  ; Check if current number is prime
        cmp #2
        beq isPrimeEnd

        lda #2
        sta divisor

isPrimeLoop
        lda rangeStart
        clc
        div divisor
        beq isPrimeNotPrime
        lda rangeStart
        cmp divisor
        bcc isPrimeEnd

        lda divisor
        clc
        adc #1
        sta divisor
        lda rangeStart
        jmp isPrimeLoop

isPrimeNotPrime
        lda #0
        rts

isPrimeEnd
        lda #1
        rts

        .end
