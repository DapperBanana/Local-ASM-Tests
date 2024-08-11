
START:
    lda #0             ; Initialize row counter
    sta ROW_COUNTER
    
LOOP_ROWS:
    lda ROW_COUNTER    ; Load current row index
    clc
    adc #1             ; Increment row counter
    sta ROW_COUNTER
    
    cmp #ROWS          ; Compare row counter to total number of rows
    bcs DONE           ; If all rows have been processed, exit loop
    
    lda #0             ; Initialize column counter
    sta COL_COUNTER
    
LOOP_COLS:
    lda COL_COUNTER    ; Load current column index
    clc
    adc #1             ; Increment column counter
    sta COL_COUNTER
    
    cmp #COLS          ; Compare column counter to total number of columns
    bcs NEXT_ROW       ; If all columns have been processed, move to next row
    
    lda ROW_COUNTER
    asl
    tay                ; Calculate index of current element in input matrix
    
    lda COL_COUNTER
    clc
    adc ROWS
    tax                ; Calculate index of current element in output matrix
    
    lda MATRIX_INPUT, y ; Load current element from input matrix
    sta MATRIX_OUTPUT, x ; Store current element in output matrix
    
    jmp LOOP_COLS
    
NEXT_ROW:
    jmp LOOP_ROWS
    
DONE:
    rts
    
ROW_COUNTER: .byte 0
COL_COUNTER: .byte 0

ROWS: .byte 3
COLS: .byte 3

MATRIX_INPUT:
    .byte 1, 2, 3
    .byte 4, 5, 6
    .byte 7, 8, 9

MATRIX_OUTPUT:
    .block 9
