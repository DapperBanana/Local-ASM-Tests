
    lda #0             ; Initialize loop counter
outerLoop:
    lda #0             ; Initialize inner loop counter
innerLoop:
    lda matrix, x      ; Load value at current location
    sta temp          ; Store value temporarily
    
    lda matrix, y      ; Load value at mirrored location
    sta matrix, x     ; Store mirrored value at current location
    
    lda temp          ; Load temporary value
    sta matrix, y     ; Store original value at mirrored location
    
    inx                ; Increment x index
    cpx #NUM_COLS     ; Check if end of row reached
    bne innerLoop      ; If not, continue inner loop
    
    iny                ; Increment y index
    cpy #NUM_ROWS     ; Check if end of matrix reached
    bne outerLoop      ; If not, continue outer loop
    
    rts                ; Return from subroutine
    
matrix:
    .byte 1, 2, 3, 4    ; Sample 2D matrix
    .byte 5, 6, 7, 8
    .byte 9, 10, 11, 12

temp:
    .byte 0            ; Temporary storage for swap
    
NUM_ROWS:
    .byte 3            ; Number of rows in matrix
NUM_COLS:
    .byte 4            ; Number of columns in matrix
