
.include "macros.s"

LDA year     ; Load the year into accumulator
AND #$03     ; Check if year is divisible by 4
BNE end      ; If not, jump to end

LDA year     ; Load the year into accumulator
AND #$07     ; Check if year is divisible by 100
BEQ leap     ; If yes, jump to leap

LDA year     ; Load the year into accumulator
AND #$0F     ; Check if year is divisible by 400
BNE end      ; If not, jump to end

leap:
  LDX #$01    ; Set X register to 1 (leap year)
  JMP end

end:
  STX isLeapYear  ; Store result in memory location isLeapYear
  BRK            ; End the program
