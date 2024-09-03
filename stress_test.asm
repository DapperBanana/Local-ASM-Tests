
; Program to check if a given matrix is orthogonal

.ORG $0200

LDA #$00
STA indexX
LDA #$00
STA indexY

checkMatrix:
    LDA matrix, X
    STA temp1
    LDA matrix + 1, X
    STA temp2
    
    LDA matrix, Y
    STA temp3
    LDA matrix + 1, Y
    STA temp4
    
    CLC
    LDA temp1
    ADC temp3
    STA result1
    LDA temp2
    ADC temp4
    STA result2
    
    CMP #$00
    BNE notOrthogonal

    INX
    CPX #2
    BNE nextRow

    LDA result1
    STA temp5
    LDA result2
    STA temp6
    
    JMP endProgram

nextRow:
    INY
    CPY #2
    BNE checkMatrix

endProgram:
    RTS

notOrthogonal:
    JMP $FFFC

indexX:
    .BYTE $00
indexY:
    .BYTE $00
temp1:
    .BYTE $00
temp2:
    .BYTE $00
temp3:
    .BYTE $00
temp4:
    .BYTE $00
temp5:
    .BYTE $00
temp6:
    .BYTE $00
result1:
    .BYTE $00
result2:
    .BYTE $00

matrix:
    .BYTE 1, 0
    .BYTE 0, 1
    .BYTE 1, 0

; Replace the matrix values above with your own matrix values

.END
