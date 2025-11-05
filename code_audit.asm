
        .text
year_is_leap:
        LDA #0              ; Assume not a leap year
        CMP #4              ; Check if divisible by 4
        BEQ .leap_year_1
        JMP .not_leap_year

.leap_year_1:
        CMP #100            ; Check if divisible by 100
        BEQ .leap_year_2
        JMP .is_leap_year

.leap_year_2:
        CMP #400            ; Check if divisible by 400
        BEQ .is_leap_year
        JMP .not_leap_year

.is_leap_year:
        LDA #1              ; Set the result to 1 (leap year)
        RTS

.not_leap_year:
        LDA #0              ; Set the result to 0 (not a leap year)
        RTS

        .org $fffc
        .word start

start:
        JSR year_is_leap   ; Call the year_is_leap function
        BRK                 ; Halt the program

        .end
