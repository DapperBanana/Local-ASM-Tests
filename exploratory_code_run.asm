
; Binary Search Program in 6502 Assembly

.ORG $0200

LDA #0         ; Set up values for low, high, and mid
STA lowval
LDA #9
STA highval
LDA #5
STA midval

LDA #6         ; Value to search for
STA searchval

loop:
    LDA lowval         ; Check if mid value is equal to search value
    CMP highval
    BCC found
    BMI notfound

    LDA midval
    CMP searchval
    BEQ found

    LDA midval
    SEC
    SBC searchval
    BMI less

more:
    LDA midval         ; Update low or high value based on comparison
    LDA midval
    SEC
    SBC #1
    STA midval

    JMP loop

less:
    LDA midval         ; Update low or high value based on comparison
    LDA midval
    CLC
    ADC #1
    STA midval

    JMP loop

found:
    LDA midval
    STA result         ; Save the index of the search value
    RTS

notfound:
    LDA #$FF
    STA result         ; Indicate search value was not found
    RTS

lowval: .BYTE 0
highval: .BYTE 0
midval: .BYTE 0
searchval: .BYTE 0
result: .BYTE 0
    
.END
