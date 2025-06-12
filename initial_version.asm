
; Check if a given year is a leap year using a function
; Input: X register contains the year to be checked
; Output: Carry flag set if leap year, otherwise clear

LDA #0        ; Clear the accumulator
STA leap_year ; Initialize leap_year flag to 0

JSR is_leap_year ; Call the function to check if the year is a leap year

BCC not_leap_year ; Branch if not a leap year

; Set carry flag to indicate leap year
SEC
JMP end_program

not_leap_year:
CLC

end_program:
RTS

is_leap_year:
; Check if the year is divisible by 4
LDA #$04
SEC
SBC #0
CMP #0
BEQ check_century

RTS

check_century:
; Check if the year is a century year (divisible by 100)
LDA #$64
SEC
SBC #0
CMP #0
BEQ check_year

RTS

check_year:
; Check if the year is divisible by 400
LDA #$190
SEC
SBC #0
CMP #0
BEQ is_leap

RTS

is_leap:
; Set leap_year flag to 1
LDA #1
STA leap_year

RTS

leap_year:
.byte 0 ; Flag to indicate if the year is a leap year (0 = not leap year, 1 = leap year)
