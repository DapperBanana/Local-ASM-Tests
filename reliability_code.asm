
;**************************
;* Leap Year Checker Program
;********************* ***

    .org $0200   ;start of program memory

start:
    LDX #0      ;initialize X register to 0

    LDA $0000   ;load input year
    JSR check_leap_year  ;call the function to check if year is leap year
    
    BEQ not_leap_year   ;branch if zero flag is set (not a leap year)
    JMP is_leap_year     ;jump if not zero (leap year)
    

check_leap_year:
    ; Check if year is divisible by 4
    CMP #4
    BNE not_leap_year  ; if not divisible by 4, branch
    RTS               ; Return if divisible
    
not_leap_year:
    LDX #0
    RTS
    
is_leap_year:
    LDX #1
    RTS
