
    LDA YEAR                ; Load the input year into the accumulator
    STA TEMP                ; Store it in a temporary location
    CMP #$1900              ; Compare the year with 1900
    BCC NOT_LEAP_YEAR       ; If the year is less than 1900, it is not a leap year
    CMP #$2000              ; Compare the year with 2000
    BCS LEAP_YEAR_2000      ; If the year is greater than or equal to 2000, check leap year criteria
NOT_LEAP_YEAR:
    LDA #$00                ; Not a leap year, set the flag to 0
    STA IS_LEAP_YEAR
    RTS

LEAP_YEAR_2000:
    LDA TEMP                ; Load the year back into the accumulator
    CMP #$2000              ; Compare the year with 2000
    BEQ LEAP                ; If the year is 2000, it is a leap year
    CMP #$2100              ; Compare the year with 2100
    BCS NOT_LEAP_YEAR       ; If the year is greater than or equal to 2100, it is not a leap year
    CMP #$20E4              ; Compare the year with 2100
    BCC LEAP                ; If the year is less than or equal to 20E4, it is a leap year
NOT_LEAP_YEAR:
    LDA #$00                ; Not a leap year, set the flag to 0
    STA IS_LEAP_YEAR
    RTS

LEAP:
    LDA #$01                ; Is a leap year, set the flag to 1
    STA IS_LEAP_YEAR
    RTS

YEAR:   .BYTE 2000          ; Input year
TEMP:   .BYTE 0             ; Temporary storage
IS_LEAP_YEAR: .BYTE 0       ; Flag to indicate leap year (0 - No, 1 - Yes)
