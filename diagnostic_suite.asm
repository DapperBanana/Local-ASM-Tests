
; Linear Regression Model in 6502 Assembly

; Constants
X_VALUES .BYTE 2, 4, 6, 8, 10
Y_VALUES .BYTE 4, 8, 10, 16, 20
NUM_POINTS = 5

ORG $1000

START
    LDX #0              ; Initialize index variable to 0
    LDA #0              ; Initialize sumX
    STA SUMX
    LDA #0              ; Initialize sumY
    STA SUMY
    LDA #0              ; Initialize sumXY
    STA SUMXY
    LDA #0              ; Initialize sumXsq
    STA SUMXSQ

LOOP
    LDA X_VALUES, X    ; Load X value from X_VALUES array
    CLC
    ADC SUMX           ; Add X to sumX
    STA SUMX

    LDA Y_VALUES, X    ; Load Y value from Y_VALUES array
    CLC
    ADC SUMY           ; Add Y to sumY
    STA SUMY

    LDX #2
INNER_LOOP
    LDA X_VALUES, X
    ASL
    CLC
    ADC TEMP
    STA TEMP

    DEX
    BNE INNER_LOOP

    LDA TEMP
    ADC SUMXY
    STA SUMXY

    LDA X_VALUES, X
    CLC
    ADC SUMXSQ
    STA SUMXSQ

    INX
    INX
    CPX NUM_POINTS
    BNE LOOP

    LDA SUMX
    STA X_SUM
    LDA SUMY
    STA Y_SUM
    LDA SUMXY
    STA XY_SUM
    LDA SUMXSQ
    STA XSQ_SUM

    LDY #NUM_POINTS

    LDA X_SUM
    STA TEMP1
    LDA Y_SUM
    STA TEMP2
    LDA XY_SUM
    STA TEMP3
    LDA XSQ_SUM
    STA TEMP4

    LDA TEMP1
    LSR
    STA X_BAR
    LDA TEMP2
    LSR
    STA Y_BAR
    LDA TEMP3
    STA XY_BAR
    LDA TEMP4
    STA XSQ_BAR

    ; Calculate m (slope) and b (y-intercept)
    LDA XSQ_BAR
    SEC
    SBC X_BAR
    LDX 2
    DEX
    STA TEMP1
    SBC X_BAR
    STX TEMP2
    LDA XY_BAR
    SEC
    SBC Y_BAR
    STA TEMP3

    STA M
    LDA Y_BAR
    STA B

    ; Output slope and y-intercept
    LDA M
    STA $0200
    LDA B
    STA $0202

END
