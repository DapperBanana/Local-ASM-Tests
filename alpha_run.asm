
.data
data_values: .byte 10, 20, 15, 30, 25
bar_char: .byte "|"

.text
start:
    lda #0
    sta $6000 ; Start memory address for bars
    lda #0
    sta $7000 ; Start memory address for data values

loop:
    ldx #0
    ldy #0

    lda data_values, y
    sta $7000, x ; Store data value at memory address
    
    lda bar_char
    sta $6000, x ; Store bar character at memory address
    
    lda #, uchar 
    clc
    adc #1
    sta x
    lda #$50
    cmp x
    bcc loop
