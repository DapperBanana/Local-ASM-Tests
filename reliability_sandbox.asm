
SudokuValidation:

; Initialize variables
lda #0
sta valid ; variable to store validation result
lda #1
sta row ; initialize row counter

; Check each row
check_rows:
    lda #1 ; initialize column counter
    sta col
check_cols:
    lda (row, col),y ; load value from Sudoku grid
    
    ; Check if value is valid (1-9)
    cmp #9
    bcs invalid_value
    
    ; Check if value is duplicated in row
    jsr check_row
    beq duplicate_value
    
    ; Check if value is duplicated in column
    jsr check_col
    beq duplicate_value
    
    ; Move to next column
    iny
    cmp #9
    bne check_cols
    
    ; Move to next row
    lda row
    clc
    adc #1
    sta row
    cmp #9
    bne check_rows
    
    ; Sudoku solution is valid
    lda #1
    sta valid
    
    ; Exit program
    rts

invalid_value:
    lda #0
    sta valid
    rts

duplicate_value:
    lda #0
    sta valid
    rts

check_row:
    lda #1
    sta col_tmp
    lda #0
    sta found
    
check_row_loop:
    lda (row, col_tmp),y
    cmp (row, col),y
    beq row_duplicate_found
    
    ; Move to next column
    iny
    cmp #9
    bne check_row_loop
    
    rts
    
row_duplicate_found:
    lda #1
    sta found
    rts

check_col:
    lda #1
    sta row_tmp
    lda #0
    sta found
    
check_col_loop:
    lda (row_tmp, col),y
    cmp (row, col),y
    beq col_duplicate_found
    
    ; Move to next row
    iny
    cmp #9
    bne check_col_loop
    
    rts
    
col_duplicate_found:
    lda #1
    sta found
    rts

valid: .byte 0
row: .byte 0
col: .byte 0
col_tmp: .byte 0
row_tmp: .byte 0
found: .byte 0
