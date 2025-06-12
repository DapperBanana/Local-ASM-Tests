
; Program to check if a given year is a leap year using a function

    .org $0600  ; Start the program at memory location $0600

    LDA #0      ; Load accumulator with 0
    STA year    ; Store 0 in memory location year

    LDA #1988   ; Load accumulator with the year to check
    STA year+1  ; Store the year in memory location year+1

    JSR isLeapYear  ; Call the isLeapYear function

    BEQ notLeap    ; If the result is 0, the year is not a leap year
    JMP isLeap     ; If the result is 1, the year is a leap year

notLeap:
    NOP
    ; code to execute if the year is not a leap year
    JMP $FFFC     ; End of program

isLeapYear:
    LDA year+1    ; Load the high byte of the year
    AND #$03      ; Check if the year is divisible by 4
    BEQ leapCheck ; If the year is divisible by 4, go to leapCheck

notLeapYear:
    LDA #0        ; Set accumulator to 0 (not a leap year)
    RTS           ; Return from function

leapCheck:
    LDA year+1    ; Load the high byte of the year
    AND #$07      ; Check if the year is divisible by 100
    BEQ leapYear  ; If the year is divisible by 100, go to leapYear

notLeapYear100:
    LDA #1        ; Set accumulator to 1 (leap year)
    RTS           ; Return from function

leapYear:
    LDA year+1    ; Load the high byte of the year
    AND #$0F      ; Check if the year is divisible by 400
    BEQ leapYear400 ; If the year is divisible by 400, go to leapYear400

notLeapYear400:
    LDA #0        ; Set accumulator to 0 (not a leap year)
    RTS           ; Return from function

leapYear400:
    LDA #1        ; Set accumulator to 1 (leap year)
    RTS           ; Return from function

year:  .word 0     ; Memory location to store the year to check
