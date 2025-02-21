
    .org $0200

matrix: .byte 1, 2, 3, 4, 5, 6, 7, 8, 9
result: .byte 0

start:
    lda #0
    sta result

    ; Check rows
    ldx #0
check_rows:
    lda matrix, x
    clc
    adc matrix, x+1
    adc matrix, x+2
    cmp #15
    bne not_magic_square

    inx
    inx
    inx
    cpx #9
    bne check_rows

    ; Check columns
    ldx #0
check_columns:
    lda matrix, x
    clc
    adc matrix, x+3
    adc matrix, x+6
    cmp #15
    bne not_magic_square

    inx
    inx
    inx
    cpx #3
    bne check_columns

    ; Check diagonals
    lda matrix
    clc
    adc matrix, 4
    adc matrix, 8
    cmp #15
    bne not_magic_square

    lda matrix + 2
    clc
    adc matrix + 4
    adc matrix + 6
    cmp #15
    bne not_magic_square

    ; If all checks pass, the matrix is a magic square
    lda #1
    sta result

not_magic_square:
    rts
