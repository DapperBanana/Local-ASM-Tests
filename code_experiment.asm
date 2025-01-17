
; Program to check if a year is a leap year
;
; Year is input by the user and the program will output whether it is a leap year or not.

    .org $0200

start
    LDX #0               ; Initialize X register to store the input year
    LDY #0               ; Initialize Y register as a flag for leap year

inputYear
    LDA $C000            ; Read input year from memory location $C000
    STA $FB              ; Store input year in memory location $FB
    INX                  ; Increment X register
    CPX #2               ; Check if both digits of year have been read
    BEQ leapYearCheck    ; If yes, check if it's a leap year
    JMP inputYear        ; Continue reading input year

leapYearCheck
    LDA $FB              ; Load input year from memory location $FB
    CMP #0               ; Check if year is divisible by 4
    BEQ checkDivisibleBy100
    JMP isLeapYear       ; If divisible, it's a leap year

checkDivisibleBy100
    CMP #0
    BEQ checkDivisibleBy400
    JMP isNotLeapYear    ; If not divisible by 4, it's not a leap year

checkDivisibleBy400
    LDA $FB              ; Load input year from memory location $FB
    CMP #0
    BEQ isLeapYear       ; If divisible by 400, it's a leap year
    JMP isNotLeapYear    ; If not divisible by 400, it's not a leap year

isLeapYear
    STY $C001            ; Store flag for leap year in memory location $C001
    LDA #$4C             ; Load ASCII code for 'L' character
    STA $C002            ; Store 'L' character in memory location $C002
    JMP endProgram       ; End program

isNotLeapYear
    STY $C001            ; Store flag for non-leap year in memory location $C001
    LDA #$4E             ; Load ASCII code for 'N' character
    STA $C002            ; Store 'N' character in memory location $C002

endProgram
    BRK                  ; End program

    .end
