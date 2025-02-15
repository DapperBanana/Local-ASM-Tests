
ROMAN_TO_INT:
    LDX #0       ; Initialize index to zero
    LDY #$0      ; Initialize total sum to zero
CHECK_NEXT_DIGIT:
    LDA ROMAN,X  ; Load next Roman numeral digit
    BEQ DONE     ; If end of string, exit loop
    CMP #$49     ; Compare with 'I'
    BEQ ADD_ONE  ; If equal to 'I', add 1 to total
    CMP #$56     ; Compare with 'V'
    BEQ ADD_FIVE ; If equal to 'V', add 5 to total
    CMP #$58     ; Compare with 'X'
    BEQ ADD_TEN  ; If equal to 'X', add 10 to total
    JMP DONE     ; Otherwise, exit loop
ADD_ONE:
    INX          ; Increment index
    INC Y        ; Add 1 to total
    JMP CHECK_NEXT_DIGIT
ADD_FIVE:
    INX          ; Increment index
    LDA ROMAN,X  ; Load next digit
    CMP #$49     ; Compare with 'I'
    BNE ADD_FIVE_DONE ; If not 'I', add 5 and continue
    LDA #3       ; If 'IV', add 4 to total
    INC Y        ; Add 1 to total (for 'V')
ADD_FIVE_DONE:
    INC Y        ; Add 5 to total
    JMP CHECK_NEXT_DIGIT
ADD_TEN:
    INX          ; Increment index
    LDA ROMAN,X  ; Load next digit
    CMP #$49     ; Compare with 'I'
    BNE ADD_TEN_DONE ; If not 'I', add 10 and continue
    LDA #8       ; If 'IX', add 9 to total
    INC Y        ; Add 1 to total (for 'X')
ADD_TEN_DONE:
    ADC #$B0     ; Add 10 to total
    INC Y        ; Add 10 to total
    JMP CHECK_NEXT_DIGIT
DONE:
    RTS          ; Return from subroutine

ROMAN: .BYTE 'XI' ; Roman numeral to convert (change as needed)
