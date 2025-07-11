
; Constants
YEAR       = $00
IS_LEAP    = $01

; Function to check if a year is a leap year
CHECK_LEAP_YEAR:
    LDA YEAR      ; Load the year into accumulator
    STA YEAR      ; Store the year
    LDA #$00       ; Clear IS_LEAP flag
    STA IS_LEAP

    ; Check if the year is divisible by 4
    LDA YEAR
    SEC
    SBC #$04
    AND #$03      ; Check if remainder is 0
    BEQ DIVISIBLE_BY_4

    ; Check if the year is divisible by 100
    LDA YEAR
    SEC
    SBC #$64
    AND #$3B      ; Check if remainder is 0
    BEQ DIVISIBLE_BY_100

    ; Check if the year is divisible by 400
    LDA YEAR
    SEC
    SBC #$90
    AND #$67      ; Check if remainder is 0
    BEQ DIVISIBLE_BY_400

    BRA NOT_LEAP_YEAR

DIVISIBLE_BY_4:
    LDA IS_LEAP
    INC          ; Set IS_LEAP flag
    BRA END

DIVISIBLE_BY_100:
    LDA IS_LEAP
    BNE NOT_LEAP_YEAR
    BRA END

DIVISIBLE_BY_400:
    LDA IS_LEAP
    INC          ; Set IS_LEAP flag
    BRA END

NOT_LEAP_YEAR:
    LDA #$00
    STA IS_LEAP

END:
    RTS

; Main program
    LDA #$57      ; Load the year to check here
    JSR CHECK_LEAP_YEAR

    LDA IS_LEAP
    BEQ NOT_LEAP
    JMP LEAP

NOT_LEAP:
    ; Year is not a leap year
    JMP END_PROGRAM

LEAP:
    ; Year is a leap year
    JMP END_PROGRAM

END_PROGRAM:
    BRK

    .END
