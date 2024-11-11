
        .org $0200
start   lda #number         ; Load the number to check if it is prime
        ldx #2              ; Load divisor
        cpx #1              ; Check if divisor is 1
        beq not_prime       ; If divisor is 1, the number is not prime
check_divisor:
        cpx number          ; Check if divisor equals the number
        beq prime           ; If divisor equals the number, it is prime
        lda number          ; Load the number
        sec
        sbc x               ; Subtract divisor from the number
        bcs not_prime       ; If result is negative, the number is not prime
        inx                 ; Increment divisor
        bne check_divisor   ; Continue checking divisor
prime   lda #1              ; Set result to prime
        sta result
done    jmp $FFFC           ; End program

not_prime:
        lda #0              ; Set result to not prime
        sta result
        jmp done

result  .byte 0             ; Result variable
number  .byte 21            ; Number to check if prime

        .end
