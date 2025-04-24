
        .org $0200       ; Start address of program

check_prime:
        LDX #$02         ; Initialize X register to 2
        LDY #$00         ; Initialize Y register to 0

check_loop:
        CPY ARG          ; Compare Y (current number) with input number
        BEQ is_prime     ; If Y == input number, number is prime

        INY              ; Increment Y (current number)

        CPX ARG          ; Compare X (divisor) with input number
        BEQ check_prime  ; If X == input number, number is prime

        CPY ARG          ; Check if Y > input number
        BCC check_loop   ; If Y < input number, continue loop

        INX              ; Increment X (divisor)
        LDA ARG          ; Load input number
        SEC              ; Set carry flag
        SBC DIVISOR      ; Subtract divisor from input number
        BCC check_loop   ; If result is not negative, continue loop

        JMP not_prime    ; If divisor found, number is not prime

is_prime:
        LDA #$01         ; Load 1 into accumulator (number is prime)
        STA RESULT       ; Store result in RESULT

exit:
        RTS              ; Return from subroutine

not_prime:
        LDA #$00         ; Load 0 into accumulator (number is not prime)
        STA RESULT       ; Store result in RESULT
        JMP exit         ; Jump to exit

ARG     .byte $05       ; Input number to check if prime
RESULT  .byte $00       ; Result of prime check
DIVISOR .byte $00       ; Divisor used in loop

        .end             ; End of program
