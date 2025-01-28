
        LDA number              ; load the input number into the accumulator
        LDY #$00                ; initialize Y register to 0 (for counting the number of factors)
        LDX #$01                ; initialize X register to 1 (start checking factors from 1)

check_factors:
        CPX number              ; compare the current factor to the input number
        BEQ is_perfect_square   ; if the current factor is equal to the input number, it is a perfect square

        LDA number              ; load the input number back into the accumulator
        SEC                     ; set the carry flag
        SBC X                   ; subtract the current factor from the input number
        BMI not_perfect_square  ; if the result is negative, the input number is not a perfect square

        INY                     ; increment the number of factors
        INX                     ; increment the current factor
        JMP check_factors       ; check the next factor

is_perfect_square:
        LDA #$01                ; load 1 into the accumulator (indicating the number is a perfect square)
        RTS                     ; return from subroutine

not_perfect_square:
        LDA #$00                ; load 0 into the accumulator (indicating the number is not a perfect square)
        RTS                     ; return from subroutine

number: .byte 36                ; example input number (change this value to test different numbers)
