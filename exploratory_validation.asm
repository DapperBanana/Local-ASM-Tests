
START:
    lda #7         ; Initialize the row counter
    sta ROW_COUNT

REVERSE_ROWS:
    lda #7         ; Initialize the column counter
    sta COL_COUNT

REVERSE_COLS:
    lda MATRIX, X  ; Load value from current position in the matrix
    sta TEMP        ; Store it temporarily
    
    lda MATRIX, Y  ; Load value from other position in the matrix
    sta MATRIX, X  ; Store it in the current position

    lda TEMP       ; Load the temporarily stored value
    sta MATRIX, Y  ; Store it in the other position

    dex            ; Decrement the column counter
    bpl REVERSE_COLS ; Repeat for all columns

    dey            ; Decrement the row counter
    bne REVERSE_ROWS ; Repeat for all rows

END:
    rts

MATRIX:
    .byte 1, 2, 3, 4, 5, 6, 7, 8
    .byte 9, 10, 11, 12, 13, 14, 15, 16
    .byte 17, 18, 19, 20, 21, 22, 23, 24
    .byte 25, 26, 27, 28, 29, 30, 31, 32

ROW_COUNT: .byte 0
COL_COUNT: .byte 0
TEMP: .byte 0
