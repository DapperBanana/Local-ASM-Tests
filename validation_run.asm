
; Define constants
YEAR_ADDRESS = $00 ; Memory address for input year
IS_LEAP_ADDRESS = $01 ; Memory address for storing result
EXIT_ADDRESS = $02 ; Memory address for exit code

; Function to check if a year is a leap year
LEAP_YEAR_CHECK:
    LDX #0
    LDA YEAR_ADDRESS
    CMP #$00
    BEQ IS_NOT_LEAP_YEAR

    ; Check if year is divisible by 4
    LDA YEAR_ADDRESS
    JSR DIVIDE_BY_FOUR
    CMP #$00
    BEQ IS_LEAP_YEAR

    ; Check if year is divisible by 100
    LDA YEAR_ADDRESS
    JSR DIVIDE_BY_ONE_HUNDRED
    CMP #$00
    BEQ IS_NOT_LEAP_YEAR

    ; Check if year is divisible by 400
    LDA YEAR_ADDRESS
    JSR DIVIDE_BY_FOUR_HUNDRED
    CMP #$00
    BEQ IS_LEAP_YEAR

IS_NOT_LEAP_YEAR:
    LDA #$00
    STA IS_LEAP_ADDRESS
    RTS

IS_LEAP_YEAR:
    LDA #$01
    STA IS_LEAP_ADDRESS
    RTS

; Division function for checking if year is divisible by 4
DIVIDE_BY_FOUR:
    SEC
    SBC #$04
    BCC YEAR_IS_DIVISIBLE_BY_FOUR
    RTS

YEAR_IS_DIVISIBLE_BY_FOUR:
    EOR #$00
    RTS

; Division function for checking if year is divisible by 100
DIVIDE_BY_ONE_HUNDRED:
    SEC
    SBC #$64
    BCC YEAR_IS_DIVISIBLE_BY_ONE_HUNDRED
    RTS

YEAR_IS_DIVISIBLE_BY_ONE_HUNDRED:
    EOR #$00
    RTS

; Division function for checking if year is divisible by 400
DIVIDE_BY_FOUR_HUNDRED:
    SEC
    SBC #$190
    BCC YEAR_IS_DIVISIBLE_BY_FOUR_HUNDRED
    RTS

YEAR_IS_DIVISIBLE_BY_FOUR_HUNDRED:
    EOR #$00
    RTS

; Main program
    LDA #$1C
    STA YEAR_ADDRESS
    JSR LEAP_YEAR_CHECK

    LDA IS_LEAP_ADDRESS
    BEQ PRINT_NOT_LEAP_YEAR
    LDA #$01
    STA EXIT_ADDRESS
    JMP EXIT

PRINT_NOT_LEAP_YEAR:
    LDA #$00
    STA EXIT_ADDRESS
    JMP EXIT

EXIT:
    BRK
