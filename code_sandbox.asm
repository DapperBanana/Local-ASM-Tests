
    .org $0200
    lda #0         ; Initialize sumX
    sta sumX
    lda #0         ; Initialize sumY
    sta sumY
    lda #0         ; Initialize sumXY
    sta sumXY
    lda #0         ; Initialize sumX2
    sta sumX2
    lda #0         ; Initialize n
    sta n

loop:
    lda dataX, x  ; Load X value
    sta tempX
    lda dataY, x  ; Load Y value
    sta tempY

    clc
    lda sumX
    adc tempX
    sta sumX       ; Add X value to sumX

    lda sumY
    adc tempY
    sta sumY       ; Add Y value to sumY

    lda tempX
    asl            ; Multiply tempX by 2
    tay
    lda tempX
    adc tempX
    adc #0
    sta tempX

    lda sumXY
    adc tempX
    sta sumXY      ; Add (X*Y) to sumXY

    lda sumX2
    adc tempY
    sta sumX2      ; Add (X*X) to sumX2

    inx
    lda n
    clc
    adc #1
    sta n          ; Increment n

    cpx #numPoints
    bne loop

    lda n
    cmp #1
    beq end        ; If n = 1, no need to calculate regression lines

    lda sumX
    cmp #0
    beq end        ; If sumX = 0, division by 0 error

    lda n
    tay
    lda sumX2
    mulY
    sta tempX      ; n * sumX2

    lda sumX
    mulY
    sta tempY      ; sumX * sumX

    lda n
    lda n
    sec
    sbc tempY
    lsr
    sta tempY      ; n - (n*sumX^2)/(sumX*sumX)

    lda tempX
    lda tempY
    clc
    div
    sta slope      ; (n * sumXY - sumX * sumY) / (n - (n * sumX^2) / (sumX * sumX))

    lda sumY
    lda slope
    lda sumX
    lda n
    mulY
    sta intercept  ; (sumY - slope * sumX) / n

end:
    rts

dataX:
    .byte 1, 2, 3, 4, 5
dataY:
    .byte 2, 4, 6, 8, 10

numPoints = * - dataX
sumX = $FD
sumY = $FE
sumXY = $FF
sumX2 = $100
n = $101

tempX = $102
tempY = $103
slope = $104
intercept = $105
