
YEAR    .BYTE   2022            ; Define the year to check here

        LDA     YEAR            ; Load the year into the accumulator
        JSR     IS_LEAP_YEAR    ; Call the subroutine to check if it's a leap year
        
        BEQ     NOT_LEAP_YEAR   ; Branch if not a leap year
        LDA     #1              ; Load 1 into the accumulator (leap year)
        BRA     END_PROGRAM     ; Branch to end the program

NOT_LEAP_YEAR:
        LDA     #0              ; Load 0 into the accumulator (not a leap year)

END_PROGRAM:
        NOP                     ; No operation - end the program

IS_LEAP_YEAR:
        STA     TMP_YEAR        ; Store the year in a temporary memory location
        LDA     TMP_YEAR        ; Load the year again
        CMP     #0              ; Check if the year is divisible by 4
        BEQ     DIV_BY_FOUR     ; If it is, check if it's divisible by 100
        JMP     IS_NOT_LEAP     ; If not divisible by 4, it's not a leap year

DIV_BY_FOUR:
        LSR                     ; Divide the year by 2 to check for divisibility by 100
        BCC     DIV_BY_HUNDRED  ; If the result is even, go to the next check
        JMP     IS_NOT_LEAP     ; If the result is odd, it's not a leap year

DIV_BY_HUNDRED:
        LSR                     ; Divide the year by 2 again to check for divisibility by 400
        BCC     IS_LEAP         ; If the result is even, it's a leap year
        JMP     IS_NOT_LEAP     ; If the result is odd, it's not a leap year

IS_LEAP:
        LDA     #1              ; Load 1 into the accumulator (it's a leap year)
        RTS                     ; Return from the subroutine

IS_NOT_LEAP:
        LDA     #0              ; Load 0 into the accumulator (it's not a leap year)
        RTS                     ; Return from the subroutine

TMP_YEAR    .BYTE   0              ; Temporary memory location to store the year
