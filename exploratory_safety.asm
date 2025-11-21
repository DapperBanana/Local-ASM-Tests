
; Program to check if a given year is a leap year using a function

        .org $0200  ; Start address of program

check_leap_year:
        LDX #2      ; Load X register with the divisor (2)
        JSR divide_by ; Call the divide_by function
        CPX #0      ; Check if the remainder is 0
        BEQ is_leap_year ; Branch if the remainder is 0
        RTS         ; Return if not a leap year

is_leap_year:
        LDX #4      ; Load X register with the divisor (4)
        JSR divide_by ; Call the divide_by function
        CPX #0      ; Check if the remainder is 0
        BEQ is_not_leap_year ; Branch if the remainder is 0
        RTS         ; Return if not a leap year

is_not_leap_year:
        LDA #$00    ; Load A register with 0 (negative result for leap year)
        RTS         ; Return if not a leap year

divide_by:
        SEC         ; Set carry bit
        SBC #0      ; Subtract the divisor from the accumulator
        CPX #0      ; Check if the result is less than the divisor
        BCS divide_by ; Branch if the result is not less than the divisor
        JMP divide_by_done ; Jump to divide_by_done

divide_by_done:
        RTS         ; Return from the divide_by function

        .end        ; End of program
