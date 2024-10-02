
        .org $1000

prime_sum:
        lda #0                    ; Initialize sum to 0
        sta $20                   ; Store sum at memory location $20
        lda $10                   ; Load the limit into A register
        sta $30                   ; Store the limit at memory location $30
        ldx #2                    ; Initialize X to 2

next_number:
        lda $30                   ; Load the limit into A register
        cmp $30                   ; Compare A with the limit
        beq end                   ; If A equals the limit, end

check_prime:
        ldy #2                    ; Initialize Y to 2
        cpx #2                    ; Compare X with 2
        beq prime                 ; If X equals 2, it is a prime number
check_divisor:
        txa                       ; Transfer X to A register
        cpy $20                   ; Compare Y with the sum
        beq not_prime             ; If Y equals the sum, not prime
        jsr divide                ; Call divide subroutine
        bne not_prime             ; If A does not equal 0, not prime
inc_loop:
        iny                       ; Increment Y
        cpy $20                   ; Compare Y with the sum
        bne check_divisor         ; Continue checking divisor
not_prime:
        inx                       ; Increment X
        jmp next_number           ; Continue to next number

prime:
        lda $20                   ; Load the sum into A register
        clc                       ; Clear the carry flag
        adc x                      ; Add X to the sum
        sta $20                   ; Store the sum

end:
        rts

        .org $2000

divide:
        tay                       ; Transfer A to Y register
        stx $40                   ; Store X at memory location $40

divide_loop:
        tya                       ; Transfer Y to A register
        sec                       ; Set the carry flag
        sbc $40                   ; Subtract X from Y
        bcc divide_done           ; If carry flag is clear, done
        dey                       ; Decrement Y
        bne divide_loop           ; Continue loop

divide_done:
        rts

        .end
