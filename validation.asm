
    ORG $1000

checkNarcissistic:
    LDX #0          ; Initialize sum
    LDA number      ; Load number to check
    STA temp        ; Store number in temp variable

sumDigits:
    LDA #0
    STA remainder   ; Initialize remainder
    LDA temp
    CMP #0
    BEQ checkResult ; If number is 0, check result
    LDX #0
    LDA temp
    LSR
divideBy10:
    ROR
    STA temp
    ROL
    LDA #10
    SEC
    SBC temp
    BCC sumDigits  ; Repeat until number is 0
    LDA temp
    STA temp

    LDA remainder
    CLC
    ADC sum
    STA sum        ; Add current digit to sum
    BCC sumDigits

checkResult:
    LDA sum
    CMP number      ; Compare sum to original number
    BEQ isNarcissistic ; If equal, number is narcissistic
    LDA #error
    STA result
    RTS

isNarcissistic:
    LDA #1
    STA result
    RTS

number: .BYTE $3A   ; Change this to the number you want to check
result: .BYTE 0
temp:   .BYTE 0
remainder: .BYTE 0
error:  .BYTE 0xFF

    END
