
ORG $1000

START:
    LDX #0
    LDA $2000, X
    BEQ END
    
CHECK_DIGIT:
    CMP #$30
    BMI NOT_VALID
    CMP #$39
    BCS NOT_VALID
    
    INX
    CPX #10
    BEQ VALID
    JMP CHECK_DIGIT
    
NOT_VALID:
    LDA #$00
    STA $3000
    JMP END

VALID:
    LDX #9
    LDA #$00
    STA $3000
    
LOOP:
    LDA $2000, X
    STA $3000, X
    DEX
    BPL LOOP
    
END:
    RTS

    .ORG $2000
    .BYTE "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", $00

    .ORG $3000
    .BLKW 10
