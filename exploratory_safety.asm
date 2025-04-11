
        .org $0200

; Input: X - number to check
; Output: A - 0 if not a narcissistic number, 1 if it is

START   LDX #0          ; initialize sum
        LDA #0
        STA $00         ; store number in memory
LOOP    LDA $00         ; load number
        CMP #0
        BEQ CHECK       ; if number is 0, check sum
        TYA
        ASL             ; multiply sum by 10
        ASL
        ASL
        ASL
        CLC
        ADC $00         ; add number
        TAY
        LDA $00
        ASL
        CLC
        ROR
        STA $00         ; divide by 10
        BCC LOOP
CHECK   TXA
        SEC
        SBC #1          ; subtract 1 from sum
        AND $00         ; check if sum is equal to original number
        BNE NOT_NARCISSISTIC
        LDA #1
        TAX             ; set result to true
        BRA END
NOT_NARCISSISTIC
        LDA #0
END     RTS

        .end
