
START:

    ; Load the year value
    LDA #LO_YEAR ; load the low byte of the year value
    STA YEAR

    LDA #HI_YEAR ; load the high byte of the year value
    STA YEAR + 1

    ; Check if the year is divisible by 4
    LDA YEAR
    AND #4
    BEQ DONE  ; If not divisible by 4, it's not a leap year

    ; Check if the year is divisible by 100
    LDA YEAR
    AND #100
    BEQ LEAP_YEAR  ; If divisible by 100, it's a leap year

    ; Check if the year is divisible by 400
    LDA YEAR
    AND #3
    BEQ DONE  ; If not divisible by 400, it's not a leap year

LEAP_YEAR:
    LDA #LEAP
    STA RESULT

DONE:
    ; End of program
    BRK

YEAR:
    .BYTE 0,0  ; Year value in little-endian format

RESULT:
    .BYTE 0    ; Result of the leap year check

LO_YEAR:
    .BYTE 21   ; Low byte of the year value
HI_YEAR:
    .BYTE 18   ; High byte of the year value

LEAP:
    .BYTE "Y"  ; Flag indicating leap year

    .END
