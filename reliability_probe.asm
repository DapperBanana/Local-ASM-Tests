
    .text
    .org $2000

checkSymmetric:
    lda matrixSize
    sta numRows
    
    lda numRows
    clc
    adc numRows
    tax
    lda #0
    sta result
    
    lda numRows
    
checkRow:
    lda #0
    sta index1
    
    lda #0
    sta index2
    
checkColumn:
    lda index1
    clc
    adc index2
    sta address1
    
    lda index2
    clc
    adc index1
    sta address2
    
    lda (address1),y
    cmp (address2),y
    bne notSymmetric
    
    iny
    lda numRows
    cmp index2
    bne checkColumn
    
    lda index1
    clc
    adc #1
    sta index1
    
    lda numRows
    cmp index1
    bne checkRow
    
    lda numRows
    clc
    adc numRows
    cmp index1
    bne done
    
notSymmetric:
    lda #1
    sta result
    
done:
    rts
