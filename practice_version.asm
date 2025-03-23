
LDA #0
STA sum1
LDA #0
STA sum2

; Load matrix values into memory
LDA matrix1
STA temp1
LDA matrix2
STA temp2
LDA matrix3
STA temp3
LDA matrix4
STA temp4

; Calculate determinant
LDA temp1
CLC
ADC temp4
LDX temp2
JSR multiply
LDX temp3
JSR subtract

; Store result in sum1
STA sum1

; Load matrix values into memory
LDA matrix4
STA temp1
LDA matrix3
STA temp2
LDA matrix2
STA temp3
LDA matrix1
STA temp4

; Calculate determinant
LDA temp1
CLC
ADC temp4
LDX temp2
JSR multiply
LDX temp3
JSR subtract

; Store result in sum2
STA sum2

; Calculate final determinant (sum1 - sum2) and store in result
LDA sum1
SEC
SBC sum2
STA result

BRK

multiply:
    CLC
    LDA #$00
    ADC temp4
    STA temp4
    LDA #$00
    ADC temp3
    STA temp3
    RTS

subtract:
    CLC
    LDA #$00
    ADC temp2
    STA temp2
    LDA #$00
    ADC temp1
    STA temp1
    RTS

.matrix1 .DA 1
.matrix2 .DA 2
.matrix3 .DA 3
.matrix4 .DA 4
.temp1 .DS 1
.temp2 .DS 1
.temp3 .DS 1
.temp4 .DS 1
.sum1 .DS 1
.sum2 .DS 1
.result .DS 1
