
start:
    lda mat1       ; load matrix values into registers
    ldx mat2
    ldy mat3
    
    ; calculate determinant using matrix formula
    lda mat1
    clc
    adc mat5
    adc mat9
    sta result
    
    lda mat2
    sec
    sbc mat4
    sbc mat8
    adc result
    sta result
    
    lda mat3
    clc
    adc mat4
    adc mat6
    sbc mat7
    adc result
    sta result
    
    ; store the result in memory
    sta det_result
    
    ; infinite loop
    jmp start

mat1:   .byte 2
mat2:   .byte 4
mat3:   .byte 3
mat4:   .byte 1
mat5:   .byte 5
mat6:   .byte 2
mat7:   .byte 1
mat8:   .byte 3
mat9:   .byte 6

result: .byte 0
det_result: .byte 0
