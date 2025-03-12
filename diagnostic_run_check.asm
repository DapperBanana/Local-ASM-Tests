
    LDA #0               ; Initialize variables
    STA SUMX
    STA SUMY
    STA SUMXY
    STA SUMX2
    STA SUMY2
    LDA #10              ; Number of elements in the lists
    STA LENGTH

LOOP:
    LDA LIST1, X         ; Load element from first list
    CLC
    ADC SUMX             ; Add to overall sum of first list
    STA SUMX
    LDA LIST2, X         ; Load element from second list
    ADC SUMY             ; Add to overall sum of second list
    STA SUMY
    CLC
    ADC SUMXY            ; Add to overall sum of product of elements
    STA SUMXY
    ASL
    ASL
    CLC
    ADC SUMX2            ; Add to overall sum of squares of first list
    STA SUMX2
    CLC
    ADC SUMY2            ; Add to overall sum of squares of second list
    STA SUMY2

    INX
    CPX LENGTH          ; Compare with length of lists
    BNE LOOP            ; If not reached end, continue looping

    LDA SUMX
    SEC
    SBC SUMY
    STA DIFFSUM
    LDA SUMXY
    SEC
    SBC LENGTH * SUMX * SUMY
    STA DIFFPROD
    LDA SUMX2
    SEC
    SBC LENGTH * SUMX * SUMX
    STA XSUMSQ
    LDA SUMY2
    SEC
    SBC LENGTH * SUMY * SUMY
    STA YSUMSQ

    LDA XSUMSQ
    CLC
    ADC YSUMSQ
    SEC
    SBC XSUMSQ * YSUMSQ
    STA DENOM

    LDA DIFFPROD
    SEC
    SBC DIFFSUM * LENGTH
    STA NUMER

    SEC
    LDA NUMER
    SBC DENOM
    STA CORREL

    ; Now, the correlation coefficient is stored in CORREL
    ; You can use it for further calculations or display it

LIST1:  .BYTE 10, 15, 20, 25, 30, 35, 40, 45, 50, 55
LIST2:  .BYTE 5, 10, 15, 20, 25, 30, 35, 40, 45, 50
SUMX:   .BYTE 0
SUMY:   .BYTE 0
SUMXY:  .BYTE 0
SUMX2:  .BYTE 0
SUMY2:  .BYTE 0
DIFFSUM: .BYTE 0
DIFFPROD: .BYTE 0
XSUMSQ: .BYTE 0
YSUMSQ: .BYTE 0
NUMER: .BYTE 0
DENOM: .BYTE 0
CORREL: .BYTE 0
LENGTH: .BYTE 0
