
        LDA YEAR       ; Load the year to check into the accumulator
        STA YEAR_TMP   ; Store a copy of the year for later use
        LDX #0         ; Initialize X register to 0 for counting leap year checks

LOOP:   CMP #4         ; Check if the year is divisible by 4
        BEQ DIV_BY_4   ; If divisible by 4, proceed to check if divisible by 100
        JMP NOT_LEAP   ; If not divisible by 4, not a leap year

DIV_BY_4:
        CMP #100       ; Check if the year is divisible by 100
        BEQ DIV_BY_100 ; If divisible by 100, proceed to check if divisible by 400
        JMP LEAP_YEAR  ; If not divisible by 100, it is a leap year

DIV_BY_100:
        CMP #400       ; Check if the year is divisible by 400
        BEQ LEAP_YEAR  ; If divisible by 400, it is a leap year
        JMP NOT_LEAP   ; If not divisible by 400, not a leap year

LEAP_YEAR:
        LDA #1         ; Set the carry flag to indicate it is a leap year
        STA IS_LEAP
        JMP END

NOT_LEAP:
        LDA #0         ; Clear the carry flag to indicate it is not a leap year
        STA IS_LEAP

END:    BRK            ; Break and end program

YEAR:   .BYTE 64       ; Year to check (e.g. 2020)
YEAR_TMP: .BYTE 0      ; Temporary storage for the year
IS_LEAP: .BYTE 0      ; Flag to indicate if it is a leap year or not
