
    lda #MATRIX_SIZE
    sta MATRIX_SIZE
    
    ; Load the matrix into memory
    ldx #0
load_matrix:
    lda MATRIX, x
    sta MATRIX_COPY, x
    inx
    cpx #MATRIX_SIZE
    bne load_matrix
    
    ; Calculate the determinant
    lda MATRIX_COPY
    clc
    adc MATRIX_COPY+4
    adc MATRIX_COPY+8
    sta COL_SUM1
    lda MATRIX_COPY+1
    clc
    adc MATRIX_COPY+5
    adc MATRIX_COPY+9
    sta COL_SUM2
    lda MATRIX_COPY+2
    clc
    adc MATRIX_COPY+6
    adc MATRIX_COPY+10
    sta COL_SUM3
    
    lda MATRIX_COPY
    sec
    sbc MATRIX_COPY+8
    sbc MATRIX_COPY+10
    sta COL_DIFF1
    lda MATRIX_COPY+1
    sec
    sbc MATRIX_COPY+9
    sbc MATRIX_COPY+11
    sta COL_DIFF2
    lda MATRIX_COPY+2
    sec
    sbc MATRIX_COPY+6
    sbc MATRIX_COPY+4
    sta COL_DIFF3
    
    lda MATRIX_COPY
    asl
    sta TEMP1
    lda MATRIX_COPY+1
    asl
    sta TEMP2
    lda MATRIX_COPY+2
    asl
    sta TEMP3
    
    lda COL_SUM1
    asl
    sta TEMP1
    lda COL_SUM2
    asl
    sta TEMP2
    lda COL_SUM3
    asl
    sta TEMP3
    
    lda COL_DIFF1
    asl
    sta TEMP1
    lda COL_DIFF2
    asl
    sta TEMP2
    lda COL_DIFF3
    asl
    sta TEMP3
    
    lda TEMP1
    clc
    adc TEMP2
    adc TEMP3
    sta DETERMINANT
    
    ; Halt execution and output the determinant
    brk
    rts

MATRIX_SIZE equ 3
MATRIX_COPY equ $C000
MATRIX equ $D000
COL_SUM1 equ $D010
COL_SUM2 equ $D011
COL_SUM3 equ $D012
COL_DIFF1 equ $D013
COL_DIFF2 equ $D014
COL_DIFF3 equ $D015
TEMP1 equ $D016
TEMP2 equ $D017
TEMP3 equ $D018
DETERMINANT equ $D019
