
        .org $0200   ; Start at address $0200

start   lda number  ; Load the number to check into the accumulator
        cmp #$02     ; Compare with 2
        beq prime    ; If the number is 2, it is a prime number
        cmp #$01     ; Compare with 1
        beq not_prime; If the number is 1, it is not a prime number
        cmp #$00     ; Compare with 0
        beq not_prime; If the number is 0, it is not a prime number
        ldx #$02     ; Initialize X register to 2 (start divisor at 2)

check_divisor
        cpx number   ; Compare X with the number
        beq prime    ; If X is equal to the number, it is a prime number
        jsr divide   ; Call divide subroutine
        beq not_prime; If the number is divisible, it is not a prime number
        inx          ; Increment X
        jmp check_divisor ; Check next divisor

prime   lda #$01     ; Load 1 into the accumulator (prime number flag)
        jmp end      ; Jump to end of program

not_prime
        lda #$00     ; Load 0 into the accumulator (not prime number flag)

end     rts          ; Return from subroutine

divide  sec          ; Set carry flag
        lsr          ; Shift number right (divide by 2)
        sta quotient ; Store quotient
        bcc divisible; If carry is clear, it is divisible
        rts          ; Return from subroutine

divisible
        inc quotient ; Increment quotient
        rts          ; Return from subroutine

number  .byte $0A    ; Number to check if prime
quotient .byte $00   ; Quotient for division result
